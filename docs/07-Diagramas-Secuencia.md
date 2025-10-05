# Diagramas de Secuencia
## Smart Room Control System (SRCS)

**Universidad Tecnológica de Panamá**
**Facultad de Ingeniería de Sistemas Computacionales**

**Autores:** Alejandro Mosquera, Victor Rodríguez
**Versión:** 1.0
**Fecha:** Enero 2025

---

## Tabla de Contenido

1. [Introducción](#1-introducción)
2. [DS-001: Comando de Voz Simple](#2-ds-001-comando-de-voz-simple)
3. [DS-002: Comando Compuesto/Escena](#3-ds-002-comando-compuestoescena)
4. [DS-003: Inicialización del Sistema](#4-ds-003-inicialización-del-sistema)
5. [DS-004: Registro de Dispositivo IoT](#5-ds-004-registro-de-dispositivo-iot)
6. [DS-005: Aprendizaje de Preferencias](#6-ds-005-aprendizaje-de-preferencias)
7. [DS-006: Manejo de Error en Dispositivo](#7-ds-006-manejo-de-error-en-dispositivo)
8. [DS-007: Ejecución de Escena Predefinida](#8-ds-007-ejecución-de-escena-predefinida)
9. [DS-008: Consulta de Estado del Sistema](#9-ds-008-consulta-de-estado-del-sistema)
10. [DS-009: Autenticación de Usuario por Voz](#10-ds-009-autenticación-de-usuario-por-voz)
11. [DS-010: Procesamiento de Comando Ambiguo](#11-ds-010-procesamiento-de-comando-ambiguo)
12. [Resumen de Tiempos](#12-resumen-de-tiempos)

---

## 1. Introducción

Este documento presenta los **diagramas de secuencia** que ilustran las interacciones dinámicas entre componentes del Smart Room Control System (SRCS). Cada diagrama muestra el flujo temporal de mensajes para un caso de uso específico.

### 1.1 Propósito

- Documentar interacciones detalladas entre componentes
- Especificar tiempos de respuesta para cumplir requisitos no funcionales
- Facilitar comprensión de flujos complejos
- Guiar implementación de componentes

### 1.2 Notación

- **PlantUML**: Diagramas en formato texto PlantUML
- **Actores**: Usuarios externos o sistemas externos
- **Participantes**: Componentes internos del sistema
- **Mensajes síncronos**: `->` (respuesta esperada)
- **Mensajes asíncronos**: `->>` (sin esperar respuesta)
- **Activaciones**: Barras verticales que muestran cuando un componente está activo
- **Notas**: Anotaciones con información adicional (especialmente tiempos)
- **Grupos**: `alt`, `opt`, `loop`, `par` para flujos condicionales/paralelos

### 1.3 Convenciones de Timing

- **Target total**: < 2 segundos para comandos simples (RNF-001)
- **Target individual**: Cada componente debe contribuir mínimamente a la latencia
- **Formato**: Tiempos en milisegundos (ms)

---

## 2. DS-001: Comando de Voz Simple

**Caso de Uso**: CU-001 - Controlar Iluminación por Comando de Voz

**Descripción**: Usuario emite comando de voz "Enciende las luces de la sala" y el sistema ejecuta la acción.

**Objetivo de Timing**: < 2000 ms total (RNF-001)

```plantuml
@startuml DS001_ComandoVozSimple

!theme plain
skinparam sequenceMessageAlign center

actor Usuario as user
participant "UI\n(Voice Interface)" as ui
participant "Whisper STT" as stt
participant "LLM Agent" as llm
participant "Ollama\n(Llama 3.1)" as ollama
participant "MCP Coordinator" as mcp
participant "MCP Lighting\nServer" as lighting
participant "Philips Hue\nConnector" as hue
database "SQLite DB" as db
participant "Luz Sala" as device

== Captura de Voz ==
user -> ui : Habla: "Enciende las\nluces de la sala"
activate ui
note right of ui: Inicio: t0

ui -> ui : Captura audio (mic)
note right of ui: ~200ms

== Speech-to-Text ==
ui -> stt : transcribe_audio(audio_data)
activate stt
note right of stt: Whisper Base\n~300-500ms
stt -> stt : Procesa audio
stt --> ui : {"text": "Enciende las luces de la sala"}
deactivate stt
note right of ui: t0 + 500ms

== Procesamiento NLP y Decisión ==
ui -> llm : process_command(text, user_id=1)
activate llm

llm -> db : get_user_context(user_id=1)
activate db
db --> llm : user_context
deactivate db
note right of llm: ~10ms

llm -> db : get_conversation_history(user_id=1, limit=5)
activate db
db --> llm : previous_messages
deactivate db
note right of llm: ~15ms

llm -> ollama : generate_response(\n  prompt=system_prompt + context + user_message,\n  tools=available_mcp_tools\n)
activate ollama
note right of ollama: LLM Inference\n~400-700ms\n(depende del hardware)

ollama --> llm : {\n  "action": "tool_call",\n  "tool": "lighting_turn_on",\n  "arguments": {"device_id": "luz_sala"}\n}
deactivate ollama
note right of llm: t0 + 925ms

== Ejecución de Acción via MCP ==
llm -> mcp : invoke_tool(\n  server="lighting",\n  tool="lighting_turn_on",\n  args={"device_id": "luz_sala"}\n)
activate mcp

mcp -> lighting : tool_call(\n  name="lighting_turn_on",\n  arguments={"device_id": "luz_sala"}\n)
activate lighting
note right of lighting: JSON-RPC over stdio

lighting -> hue : send_command(\n  command="turn_on",\n  parameters={"device_id": "luz_sala"}\n)
activate hue

hue -> device : POST /api/{key}/lights/1/state\n{"on": true}
activate device
note right of device: API REST\n~100-200ms

device --> hue : 200 OK\n{"success": true}
deactivate device

hue --> lighting : {"result": "success", "state": {"power": "on"}}
deactivate hue

lighting --> mcp : {"result": "success"}
deactivate lighting

mcp --> llm : {"result": "success"}
deactivate mcp
note right of llm: t0 + 1225ms

== Registro de Acción ==
llm -> db : insert_action_log(\n  user_id=1,\n  action="lighting_turn_on",\n  device_id="luz_sala",\n  result="success"\n)
activate db
db --> llm : OK
deactivate db
note right of llm: ~20ms (async)

== Generación de Respuesta ==
llm -> ollama : generate_final_response(\n  "He encendido las luces de la sala"\n)
activate ollama
ollama --> llm : response_text
deactivate ollama
note right of llm: ~200ms

llm -> db : save_conversation(\n  user_id=1,\n  role="assistant",\n  message="He encendido..."\n)
activate db
db --> llm : OK
deactivate db

llm --> ui : {\n  "response": "He encendido las luces de la sala",\n  "success": true\n}
deactivate llm
note right of ui: t0 + 1645ms

== Text-to-Speech ==
ui -> ui : synthesize_speech(\n  "He encendido las luces..."\n)
note right of ui: Piper TTS\n~200-300ms

ui -> user : Reproduce audio:\n"He encendido las luces..."
deactivate ui
note right of user: **Total: ~1945ms**\n✓ < 2000ms (RNF-001)

@enduml
```

**Análisis de Timing**:

| Fase | Componente | Tiempo (ms) | % Total |
|------|-----------|-------------|---------|
| Captura audio | UI | 200 | 10% |
| STT (Whisper) | Whisper | 500 | 26% |
| DB queries | SQLite | 25 | 1% |
| LLM Inference | Ollama | 600 | 31% |
| MCP + IoT | MCP + Hue | 320 | 16% |
| Registro log | SQLite | 20 | 1% |
| Generación respuesta | Ollama | 200 | 10% |
| TTS | Piper | 100 | 5% |
| **TOTAL** | | **1945 ms** | **100%** |

**Cuellos de Botella Identificados**:
1. **LLM Inference (600ms)**: Principal contribuidor. Optimizable mediante:
   - Modelo más pequeño (Llama 3.1 8B → 7B)
   - Cuantización del modelo
   - GPU aceleración
2. **STT Whisper (500ms)**: Segundo contribuidor. Optimizable mediante:
   - Modelo "tiny" en lugar de "base"
   - Procesamiento en GPU

---

## 3. DS-002: Comando Compuesto/Escena

**Caso de Uso**: CU-007 - Ejecutar Acción Compuesta

**Descripción**: Usuario solicita "Enciende las luces y sube la temperatura a 23 grados" y el sistema ejecuta ambas acciones en paralelo.

**Objetivo de Timing**: < 2500 ms (múltiples acciones)

```plantuml
@startuml DS002_ComandoCompuesto

!theme plain

actor Usuario as user
participant "UI" as ui
participant "LLM Agent" as llm
participant "Ollama" as ollama
participant "MCP Coordinator" as mcp
participant "MCP Lighting" as lighting
participant "MCP Climate" as climate
participant "Hue Connector" as hue
participant "Nest Connector" as nest
database "SQLite DB" as db

user -> ui : "Enciende las luces\ny sube la temperatura\na 23 grados"
activate ui

ui -> llm : process_command(text)
activate llm

llm -> ollama : analyze_intent(text)
activate ollama
ollama --> llm : {\n  "intents": [\n    {"action": "lighting_turn_on"},\n    {"action": "climate_set_temp", "temp": 23}\n  ]\n}
deactivate ollama

note over llm: Detecta 2 intenciones\nseparadas

llm -> mcp : execute_actions_parallel([\n  {tool: "lighting_turn_on", args: {}},\n  {tool: "climate_set_temperature", args: {temp: 23}}\n])
activate mcp

== Ejecución Paralela ==

par Acción 1: Iluminación
  mcp -> lighting : lighting_turn_on()
  activate lighting
  lighting -> hue : turn_on()
  activate hue
  hue --> lighting : success
  deactivate hue
  lighting --> mcp : success
  deactivate lighting
else Acción 2: Clima
  mcp -> climate : climate_set_temperature(23)
  activate climate
  climate -> nest : set_temperature(23)
  activate nest
  nest --> climate : success
  deactivate nest
  climate --> mcp : success
  deactivate climate
end

note over mcp: Espera a que ambas\nacciones completen

mcp --> llm : {\n  "results": [\n    {"action": "lighting", "status": "success"},\n    {"action": "climate", "status": "success"}\n  ]\n}
deactivate mcp

llm -> db : log_actions([\n  {action: "lighting_turn_on", result: "success"},\n  {action: "climate_set_temp", result: "success"}\n])
activate db
db --> llm : OK
deactivate db

llm -> ollama : generate_response(results)
activate ollama
ollama --> llm : "He encendido las luces\ny ajustado la temperatura a 23 grados"
deactivate ollama

llm --> ui : response
deactivate llm

ui -> user : Reproduce respuesta
deactivate ui

note right of user: **Total: ~2100ms**\n✓ < 2500ms

@enduml
```

**Ventajas de Ejecución Paralela**:
- Sin paralelización: 1945ms (luces) + 1800ms (clima) = 3745ms
- Con paralelización: max(1945ms, 1800ms) = 1945ms
- **Ahorro: ~1800ms (48%)**

---

## 4. DS-003: Inicialización del Sistema

**Caso de Uso**: CU-018 - Inicializar Componentes del Sistema

**Descripción**: Secuencia de arranque del sistema con sus 6 fases.

**Objetivo de Timing**: < 10 segundos (RNF-020)

```plantuml
@startuml DS003_InicializacionSistema

!theme plain

participant "Main Process" as main
participant "Database Module" as db
participant "Config Loader" as config
participant "MCP Coordinator" as mcp
participant "MCP Lighting" as light_srv
participant "MCP Climate" as climate_srv
participant "MCP Security" as sec_srv
participant "LLM Agent" as llm
participant "Ollama" as ollama
participant "UI Module" as ui
participant "Background Tasks" as bg

[-> main : srcs start
activate main

note over main: **Fase 1: Base de Datos**\nt0

main -> db : initialize()
activate db

db -> db : Conecta SQLite\n(database/smart_room.db)
db -> db : Ejecuta migrations\n(Alembic)
db -> db : Valida schema

db --> main : ✓ DB Ready
deactivate db

note over main: t0 + 500ms

== Fase 2: Configuración ==

main -> config : load_all_config()
activate config

config -> config : Lee config.json
config -> config : Lee mcp-servers-config.json
config -> config : Lee devices-config.json
config -> config : Valida JSON schemas

config --> main : ✓ Config Loaded
deactivate config

note over main: t0 + 800ms

== Fase 3: Servidores MCP ==

main -> mcp : initialize_servers(config)
activate mcp

par Iniciar Lighting Server
  mcp -> light_srv : start_process(\n  command="python -m mcp_lighting"\n)
  activate light_srv
  light_srv -> light_srv : Conecta via stdio
  light_srv --> mcp : tools=[turn_on, turn_off, ...]
else Iniciar Climate Server
  mcp -> climate_srv : start_process(\n  command="python -m mcp_climate"\n)
  activate climate_srv
  climate_srv -> climate_srv : Conecta via stdio
  climate_srv --> mcp : tools=[set_temp, ...]
else Iniciar Security Server
  mcp -> sec_srv : start_process(\n  command="python -m mcp_security"\n)
  activate sec_srv
  sec_srv -> sec_srv : Conecta via stdio
  sec_srv --> mcp : tools=[arm, disarm, ...]
end

mcp -> mcp : Consolida herramientas\n(18 tools disponibles)

mcp --> main : ✓ 4 Servers Ready\n18 tools
deactivate mcp

note over main: t0 + 3500ms

== Fase 4: LLM Agent ==

main -> llm : initialize(ollama_config)
activate llm

llm -> ollama : health_check()
activate ollama
ollama --> llm : ✓ Available
deactivate ollama

llm -> llm : Carga system prompt
llm -> db : Inicializa conversation store
activate db
db --> llm : OK
deactivate db

llm --> main : ✓ LLM Ready
deactivate llm

note over main: t0 + 4200ms

== Fase 5: Interfaces de Usuario ==

main -> ui : initialize()
activate ui

ui -> ui : Carga Whisper (STT)\nModelo: base
note right of ui: ~2-3 segundos\n(primera vez)

ui -> ui : Carga Piper (TTS)\nModelo: es_ES
note right of ui: ~1 segundo

ui -> ui : Inicia CLI interface
ui -> ui : (Opcional) Inicia Web\nen puerto 8080

ui --> main : ✓ UI Ready
deactivate ui

note over main: t0 + 7500ms

== Fase 6: Tareas en Background ==

main -> bg : schedule_tasks()
activate bg

bg -> bg : Programa sync_devices\n(cada 60s)
bg -> bg : Programa learn_preferences\n(cada 1h)
bg -> bg : Programa cleanup_logs\n(diaria)

bg --> main : ✓ Tasks Scheduled
deactivate bg

note over main: t0 + 7800ms

== Resumen Final ==

main -> main : Genera resumen:\n"✓ SRCS iniciado\n- 4 servidores MCP\n- 18 herramientas\n- 10 dispositivos (8 online)"

[<- main : Sistema LISTO
deactivate main

note over main: **Total: 7800ms**\n✓ < 10000ms (RNF-020)

@enduml
```

**Distribución de Tiempo de Inicio**:

| Fase | Tiempo (ms) | % Total |
|------|-------------|---------|
| 1. Base de Datos | 500 | 6% |
| 2. Configuración | 300 | 4% |
| 3. Servidores MCP | 2700 | 35% |
| 4. LLM Agent | 700 | 9% |
| 5. UI (STT/TTS) | 3300 | 42% |
| 6. Background Tasks | 300 | 4% |
| **TOTAL** | **7800 ms** | **100%** |

**Optimizaciones Posibles**:
1. **Carga lazy de modelos STT/TTS**: Cargar solo cuando se necesiten (primera interacción)
2. **Paralelizar fases 3 y 5**: Iniciar UI mientras servidores MCP arrancan
3. **Caché de modelos**: Mantener modelos en memoria entre reinicios

---

## 5. DS-004: Registro de Dispositivo IoT

**Caso de Uso**: CU-008 - Configurar Nuevo Dispositivo IoT

**Descripción**: Administrador registra un nuevo dispositivo Philips Hue.

```plantuml
@startuml DS004_RegistroDispositivo

!theme plain

actor Administrador as admin
participant "CLI" as cli
participant "Device Manager" as dev_mgr
participant "Philips Hue\nConnector" as hue
database "SQLite DB" as db
participant "MCP Coordinator" as mcp
participant "MCP Lighting" as light_srv

admin -> cli : srcs device add
activate cli

cli -> cli : Solicita información:\n- Nombre: "Luz Pasillo"\n- Tipo: "light"\n- Protocolo: "philips_hue"\n- IP: "192.168.1.100"\n- API Key: "xxx"

admin -> cli : Ingresa datos
activate admin

cli -> dev_mgr : register_device(device_info)
deactivate admin
activate dev_mgr

== Validación ==

dev_mgr -> dev_mgr : Valida formato datos
note right of dev_mgr: - IP válida\n- API key presente\n- Tipo válido

dev_mgr -> hue : Crea conector temporal
activate hue

hue -> hue : Configurar conexión:\n- IP: 192.168.1.100\n- Port: 80\n- API Key: xxx

== Verificación de Conectividad ==

hue -> hue : connect()
note right of hue: HTTP GET\n/api/{key}/lights

alt Dispositivo responde
  hue -> hue : verify_api_key()
  note right of hue: 200 OK → API key válida

  hue --> dev_mgr : ✓ Conectividad OK

else Dispositivo no responde
  hue --> dev_mgr : ✗ Error: Connection timeout
  dev_mgr --> cli : Error: No pude conectar\ncon dispositivo en IP
  cli --> admin : Muestra error
  note right of admin: **Flujo termina aquí**
end

deactivate hue

== Registro en Base de Datos ==

dev_mgr -> db : INSERT INTO devices (\n  name="Luz Pasillo",\n  type="light",\n  server_mcp="lighting",\n  config=JSON,\n  enabled=1\n)
activate db

db -> db : Valida constraints
db -> db : Genera ID autoincremental

db --> dev_mgr : device_id=11
deactivate db

note right of dev_mgr: Dispositivo\nregistrado con ID=11

== Notificación a MCP ==

dev_mgr -> mcp : notify_new_device(\n  server="lighting",\n  device_id=11\n)
activate mcp

mcp -> light_srv : reload_devices()
activate light_srv

light_srv -> db : SELECT * FROM devices\nWHERE server_mcp='lighting'\nAND enabled=1
activate db
db --> light_srv : [..., {id:11, name:"Luz Pasillo"}]
deactivate db

light_srv -> light_srv : Actualiza caché\nde dispositivos

light_srv --> mcp : ✓ Cache actualizado
deactivate light_srv

mcp --> dev_mgr : OK
deactivate mcp

== Confirmación ==

dev_mgr -> dev_mgr : Genera log de auditoría

dev_mgr --> cli : {\n  "result": "success",\n  "device_id": 11,\n  "message": "Dispositivo registrado"\n}
deactivate dev_mgr

cli --> admin : ✓ Dispositivo 'Luz Pasillo'\nregistrado exitosamente\n(ID: 11)
deactivate cli

note right of admin: **Total: ~800ms**

@enduml
```

---

## 6. DS-005: Aprendizaje de Preferencias

**Caso de Uso**: CU-014 - Aprender Preferencias del Usuario

**Descripción**: Sistema detecta patrón de uso y aprende preferencia automáticamente (tarea programada que se ejecuta cada hora).

```plantuml
@startuml DS005_AprendizajePreferencias

!theme plain

participant "Scheduler" as sched
participant "Preference\nLearner" as learner
database "SQLite DB" as db
participant "LLM Agent" as llm

[-> sched : Tarea programada\n(cada 1 hora)
activate sched

sched -> learner : analyze_preferences()
activate learner

note over learner: Análisis para\ntodos los usuarios

== Obtención de Datos ==

learner -> db : SELECT user_id, action, parameters, timestamp\nFROM action_logs\nWHERE timestamp >= NOW() - 7 days\nGROUP BY user_id
activate db

db --> learner : action_logs[\n  {user_id: 1, actions: [...]},\n  {user_id: 2, actions: [...]}\n]
deactivate db

note right of learner: ~100-200ms\n(depende del volumen)

== Análisis de Patrones ==

loop Para cada usuario

  learner -> learner : analyze_patterns(user_id=1)

  note over learner: **Algoritmo de Detección:**\n1. Agrupa acciones similares\n2. Identifica correlaciones temporales\n3. Calcula frecuencia y consistencia

  alt Patrón detectado

    learner -> learner : Calcula confianza:\nconfianza = (ocurrencias / días)\nSi ocurrencias >= 5 y\nconfianza >= 0.70

    note over learner: **Ejemplo detectado:**\n- Acción: set_temperature(22)\n- Horario: 18:00-22:00\n- Ocurrencias: 6/7 días\n- Confianza: 0.86

    learner -> db : SELECT * FROM user_preferences\nWHERE user_id=1\nAND preference_key='evening_temperature'
    activate db

    alt Preferencia no existe
      db --> learner : NULL
      deactivate db

      note over learner: Nueva preferencia

      learner -> db : INSERT INTO user_preferences (\n  user_id=1,\n  preference_key='evening_temperature',\n  preference_value=JSON({\n    "time": "18:00-22:00",\n    "value": 22,\n    "confidence": 0.86,\n    "sample_size": 6\n  })\n)
      activate db
      db --> learner : OK
      deactivate db

      learner -> learner : Log: "Nueva preferencia\naprendida para user_id=1"

      learner -> llm : notify_new_preference(\n  user_id=1,\n  preference="evening_temperature"\n)
      activate llm

      note over llm: LLM Agent puede usar\nesta preferencia para\nsugerencias proactivas

      llm --> learner : ACK
      deactivate llm

    else Preferencia existe
      db --> learner : existing_preference
      deactivate db

      note over learner: Preferencia ya existe

      learner -> learner : Compara confianzas:\nnueva (0.86) vs existente (0.75)

      alt Nueva confianza mayor
        learner -> db : UPDATE user_preferences\nSET preference_value=NEW_JSON\nWHERE user_id=1\nAND preference_key='evening_temperature'
        activate db
        db --> learner : OK
        deactivate db

        learner -> learner : Log: "Preferencia actualizada"
      else Nueva confianza menor
        learner -> learner : Log: "Preferencia no actualizada\n(confianza insuficiente)"
      end
    end

  else No hay patrón suficiente
    learner -> learner : Log: "Sin patrones para user_id=1"
  end

end

learner -> learner : Genera reporte:\n- Usuarios analizados: 2\n- Preferencias nuevas: 1\n- Preferencias actualizadas: 0

learner --> sched : ✓ Análisis completado
deactivate learner

[<- sched : Log guardado
deactivate sched

note over sched: **Total: ~2000-5000ms**\n(depende de volumen de datos)

@enduml
```

**Criterios de Aprendizaje**:

| Criterio | Valor Mínimo | Descripción |
|----------|--------------|-------------|
| Ocurrencias | 5 | Mínimo de veces que se repite el patrón |
| Confianza | 0.70 | Consistencia del patrón (70%) |
| Ventana temporal | 7 días | Período de análisis |

---

## 7. DS-006: Manejo de Error en Dispositivo

**Caso de Uso**: CU-015 - Recuperar de Error de Dispositivo

**Descripción**: Sistema detecta error de comunicación con dispositivo y aplica lógica de retry con backoff exponencial y circuit breaker.

```plantuml
@startuml DS006_ManejoError

!theme plain

participant "MCP Coordinator" as mcp
participant "MCP Lighting" as light_srv
participant "Philips Hue\nConnector" as hue
participant "Dispositivo\n(Luz Sala)" as device
database "SQLite DB" as db

mcp -> light_srv : lighting_turn_on(\n  device_id="luz_sala"\n)
activate light_srv

light_srv -> hue : send_command(\n  command="turn_on",\n  device_id="luz_sala"\n)
activate hue

== Intento 1 ==

hue -> hue : Verifica circuit breaker\nEstado: CLOSED (OK)

hue -> device : POST /api/lights/1/state
activate device
note right of device: Timeout: 5 segundos

... Espera 5 segundos ...

hue <-- device : ✗ TIMEOUT\n(sin respuesta)
deactivate device

note over hue: Error detectado

== Retry con Backoff Exponencial ==

hue -> hue : Incrementa contador retry:\nretry_count = 1\nbackoff = 2^1 = 2s

note right of hue: **Backoff Strategy:**\nretry_1: wait 2s\nretry_2: wait 4s\nretry_3: wait 8s

... Espera 2 segundos ...

== Intento 2 ==

hue -> device : POST /api/lights/1/state
activate device

... Espera 5 segundos ...

hue <-- device : ✗ TIMEOUT
deactivate device

hue -> hue : retry_count = 2\nbackoff = 2^2 = 4s

... Espera 4 segundos ...

== Intento 3 ==

hue -> device : POST /api/lights/1/state
activate device

note right of device: Dispositivo\nse recuperó

device --> hue : 200 OK\n{"success": true}
deactivate device

note over hue: ✓ Recuperación exitosa

== Registro de Recuperación ==

hue -> hue : Reset retry_count = 0

hue --> light_srv : {\n  "result": "success",\n  "recovery_info": {\n    "retries": 3,\n    "recovery_time_ms": 11000\n  }\n}
deactivate hue

light_srv -> db : INSERT INTO action_logs (\n  action="device_recovery",\n  device_id="luz_sala",\n  result="success",\n  parameters=JSON({"retries": 3})\n)
activate db
db --> light_srv : OK
deactivate db

light_srv --> mcp : ✓ success\n(después de 3 retries)
deactivate light_srv

note over mcp: **Total: ~11 segundos**\n(5s + 2s + 5s + 4s + 5s + delays)

@enduml
```

**Flujo Alternativo: Circuit Breaker Activado**

```plantuml
@startuml DS006b_CircuitBreaker

!theme plain

participant "Hue Connector" as hue
participant "Circuit Breaker" as cb
participant "Device" as device
database "Metrics DB" as db

note over cb: **Estado Inicial:**\nCLOSED (normal)

== Fallo Repetido ==

loop 5 fallos consecutivos
  hue -> device : Request
  activate device
  hue <-- device : TIMEOUT
  deactivate device

  hue -> cb : record_failure()
  activate cb
  cb -> cb : failure_count++
  deactivate cb
end

note over cb: failure_count = 5\nen últimos 5 minutos

cb -> cb : Transición:\nCLOSED → OPEN

note over cb: **Estado: OPEN**\nBloquea requests\npor 60 segundos

== Request Durante Circuit Open ==

hue -> cb : check_state()
activate cb
cb --> hue : OPEN\n(rechazar request)
deactivate cb

hue -> hue : return error inmediatamente\nSIN intentar llamar dispositivo

note right of hue: **Ventaja:**\nNo desperdicia tiempo\nen timeouts adicionales

... 60 segundos después ...

== Transición a Half-Open ==

cb -> cb : Timeout expirado\nTransición: OPEN → HALF_OPEN

note over cb: **Estado: HALF_OPEN**\nPermite 1 request de prueba

hue -> cb : check_state()
activate cb
cb --> hue : HALF_OPEN\n(permitir 1 request)
deactivate cb

hue -> device : Request de prueba
activate device

alt Dispositivo recuperado
  device --> hue : SUCCESS
  deactivate device

  hue -> cb : record_success()
  activate cb
  cb -> cb : Transición:\nHALF_OPEN → CLOSED
  deactivate cb

  note over cb: **Estado: CLOSED**\nSistema normal

else Dispositivo sigue fallando
  device --> hue : TIMEOUT
  deactivate device

  hue -> cb : record_failure()
  activate cb
  cb -> cb : Transición:\nHALF_OPEN → OPEN\nNuevo timeout: 60s
  deactivate cb

  note over cb: **Estado: OPEN**\nCircuit se mantiene abierto
end

@enduml
```

**Configuración de Circuit Breaker**:

| Parámetro | Valor | Descripción |
|-----------|-------|-------------|
| Umbral de fallos | 5 | Fallos consecutivos para abrir circuit |
| Ventana temporal | 5 minutos | Período de conteo de fallos |
| Timeout (Open) | 60 segundos | Tiempo antes de intentar Half-Open |
| Max retries | 3 | Intentos antes de declarar fallo |

---

## 8. DS-007: Ejecución de Escena Predefinida

**Caso de Uso**: CU-003 - Activar Escena Predefinida

**Descripción**: Usuario activa escena "Modo Cine" que configura múltiples dispositivos coordinadamente.

```plantuml
@startuml DS007_EjecucionEscena

!theme plain

actor Usuario as user
participant "UI" as ui
participant "LLM Agent" as llm
database "SQLite DB" as db
participant "MCP Coordinator" as mcp
participant "MCP Lighting" as light
participant "MCP Climate" as climate
participant "MCP Entertainment" as entertain
participant "Luces" as lights
participant "Termostato" as thermo
participant "Proyector" as proj

user -> ui : "Activa modo cine"
activate ui

ui -> llm : process_command("Activa modo cine")
activate llm

== Identificación de Escena ==

llm -> db : SELECT * FROM scenes\nWHERE name LIKE '%cine%'\nOR name LIKE '%película%'
activate db

db --> llm : scene_id=3,\nname="Modo Cine",\nconfig=JSON
deactivate db

llm -> llm : Parsea configuración:\n{\n  "lighting": {\n    "Luz Sala": {brightness: 20, color: "warm"},\n    "Luz Ambiente": {power: "off"}\n  },\n  "climate": {\n    "Termostato Sala": {temp: 20}\n  },\n  "entertainment": {\n    "Proyector": {power: "on", source: "HDMI1"},\n    "Audio Sala": {volume: 60}\n  }\n}

== Ejecución Coordinada ==

llm -> mcp : execute_scene(scene_config)
activate mcp

note over mcp: Planifica ejecución:\n5 acciones en paralelo

par Acción 1: Luz Sala
  mcp -> light : lighting_set(\n  "Luz Sala",\n  brightness=20,\n  color="warm"\n)
  activate light
  light -> lights : API call
  activate lights
  lights --> light : OK
  deactivate lights
  light --> mcp : ✓ success
  deactivate light

else Acción 2: Luz Ambiente
  mcp -> light : lighting_turn_off(\n  "Luz Ambiente"\n)
  activate light
  light -> lights : API call
  activate lights
  lights --> light : OK
  deactivate lights
  light --> mcp : ✓ success
  deactivate light

else Acción 3: Temperatura
  mcp -> climate : climate_set_temperature(\n  zone="sala",\n  temp=20\n)
  activate climate
  climate -> thermo : API call
  activate thermo
  thermo --> climate : OK
  deactivate thermo
  climate --> mcp : ✓ success
  deactivate climate

else Acción 4: Proyector
  mcp -> entertain : entertainment_select_source(\n  device="Proyector",\n  source="HDMI1"\n)
  activate entertain
  entertain -> proj : API call
  activate proj
  proj --> entertain : OK
  deactivate proj
  entertain --> mcp : ✓ success
  deactivate entertain

else Acción 5: Audio
  mcp -> entertain : entertainment_set_volume(\n  device="Audio Sala",\n  volume=60\n)
  activate entertain
  entertain --> mcp : ✓ success
  deactivate entertain
end

note over mcp: Todas las acciones\ncompletadas en paralelo\nTiempo max: ~500ms

mcp --> llm : {\n  "result": "success",\n  "actions": 5,\n  "successful": 5,\n  "failed": 0\n}
deactivate mcp

== Registro y Respuesta ==

llm -> db : INSERT INTO action_logs (\n  user_id=1,\n  action="activate_scene",\n  parameters=JSON({scene_id: 3}),\n  result="success"\n)
activate db
db --> llm : OK
deactivate db

llm --> ui : "He activado el modo cine"
deactivate llm

ui -> user : Reproduce respuesta
deactivate ui

note right of user: **Total: ~1800ms**

@enduml
```

**Flujo Alternativo: Fallo Parcial**

```plantuml
@startuml DS007b_FalloParcial

!theme plain

participant "MCP Coordinator" as mcp
participant "MCP Lighting" as light
participant "MCP Entertainment" as entertain

note over mcp: Ejecución de escena\n"Modo Cine"

par Acción 1: Luces
  mcp -> light : lighting_set()
  activate light
  light --> mcp : ✓ success
  deactivate light

else Acción 2: Proyector
  mcp -> entertain : turn_on_projector()
  activate entertain
  entertain --> mcp : ✗ error\n"Device offline"
  deactivate entertain
end

note over mcp: Resultado parcial:\n1 exitosa, 1 fallida

mcp -> mcp : Genera reporte:\n{\n  "result": "partial",\n  "successful": ["Luces"],\n  "failed": [{\n    "device": "Proyector",\n    "error": "offline"\n  }]\n}

note right of mcp: **Política:**\nContinuar con dispositivos\nexitosos, informar fallos

@enduml
```

---

## 9. DS-008: Consulta de Estado del Sistema

**Caso de Uso**: CU-004 - Consultar Estado de Dispositivos

**Descripción**: Usuario pregunta "¿Cómo está la habitación?" y el sistema consulta estado de todos los dispositivos en paralelo.

```plantuml
@startuml DS008_ConsultaEstado

!theme plain

actor Usuario as user
participant "UI" as ui
participant "LLM Agent" as llm
participant "MCP Coordinator" as mcp
participant "MCP Lighting" as light
participant "MCP Climate" as climate
participant "MCP Security" as security
participant "MCP Entertainment" as entertain
database "SQLite DB" as db

user -> ui : "¿Cómo está la habitación?"
activate ui

ui -> llm : process_command(text)
activate llm

llm -> llm : Detecta intención:\nCONSULTA_ESTADO_GENERAL

== Consulta Paralela de Estado ==

llm -> mcp : get_all_status()
activate mcp

par Consulta Lighting
  mcp -> light : lighting_get_status()
  activate light
  light --> mcp : {\n  "devices": [\n    {"name": "Luz Sala", "power": "on", "brightness": 75},\n    {"name": "Luz Escritorio", "power": "off"}\n  ]\n}
  deactivate light

else Consulta Climate
  mcp -> climate : climate_get_status()
  activate climate
  climate --> mcp : {\n  "zones": [\n    {"zone": "sala", "temp": 22, "target": 23}\n  ]\n}
  deactivate climate

else Consulta Security
  mcp -> security : security_get_status()
  activate security
  security --> mcp : {\n  "armed": false,\n  "sensors": "all clear"\n}
  deactivate security

else Consulta Entertainment
  mcp -> entertain : entertainment_get_status()
  activate entertain
  entertain --> mcp : {\n  "devices": [\n    {"name": "Audio Sala", "playing": true, "volume": 50}\n  ]\n}
  deactivate entertain
end

note over mcp: Consolida respuestas\nde 4 servidores MCP

mcp --> llm : {\n  "lighting": {...},\n  "climate": {...},\n  "security": {...},\n  "entertainment": {...}\n}
deactivate mcp

== Generación de Respuesta Natural ==

llm -> llm : Construye respuesta natural:\n"Las luces de la sala están encendidas\nal 75%, la temperatura es 22 grados,\nel sistema de seguridad está desarmado,\ny el audio está reproduciendo."

llm --> ui : response_text
deactivate llm

ui -> user : Reproduce respuesta
deactivate ui

note right of user: **Total: ~800ms**\n(solo consultas, sin cambios)

@enduml
```

**Optimización de Consultas**:
- **Sin paralelización**: 200ms × 4 = 800ms
- **Con paralelización**: max(200ms, 200ms, 200ms, 200ms) = 200ms
- **Ahorro**: 600ms (75%)

---

## 10. DS-009: Autenticación de Usuario por Voz

**Caso de Uso**: CU-016 - Autenticar Usuario

**Descripción**: Sistema autentica al usuario mediante reconocimiento de voz (voice fingerprint).

```plantuml
@startuml DS009_AutenticacionVoz

!theme plain

actor Usuario as user
participant "UI" as ui
participant "Whisper STT" as stt
participant "Voice Auth\nModule" as voice_auth
database "SQLite DB" as db
participant "LLM Agent" as llm

user -> ui : Habla: "Hola"
activate ui

ui -> ui : Captura audio (5 segundos)

== Speech-to-Text ==

ui -> stt : transcribe_audio(audio_data)
activate stt
stt --> ui : {\n  "text": "Hola",\n  "audio_features": [...]\n}
deactivate stt

note right of ui: Whisper también\nretorna features de audio

== Extracción de Voice Fingerprint ==

ui -> voice_auth : extract_fingerprint(\n  audio_data\n)
activate voice_auth

voice_auth -> voice_auth : Analiza características:\n- Pitch\n- Timbre\n- Cadencia\n- Formantes

voice_auth --> ui : voice_fingerprint_hash
deactivate voice_auth

note right of ui: ~100ms

== Búsqueda de Usuario ==

ui -> db : SELECT id, name, voice_profile\nFROM users\nWHERE voice_profile IS NOT NULL
activate db

db --> ui : [\n  {id: 1, name: "Victor", profile: "hash1"},\n  {id: 2, name: "Alejandro", profile: "hash2"}\n]
deactivate db

== Comparación de Perfiles ==

ui -> voice_auth : match_profile(\n  fingerprint=current,\n  profiles=[hash1, hash2]\n)
activate voice_auth

voice_auth -> voice_auth : Calcula similitud coseno:\nsimilarity(current, hash1) = 0.92\nsimilarity(current, hash2) = 0.45

note over voice_auth: **Umbral de confianza:**\n> 0.80 = Match\n0.60-0.80 = Ambiguo\n< 0.60 = No match

voice_auth --> ui : {\n  "match": true,\n  "user_id": 1,\n  "name": "Victor",\n  "confidence": 0.92\n}
deactivate voice_auth

== Creación de Sesión ==

ui -> ui : Crea sesión de usuario:\n{\n  "user_id": 1,\n  "name": "Victor",\n  "authenticated_at": NOW(),\n  "auth_method": "voice",\n  "confidence": 0.92\n}

== Saludo Personalizado ==

ui -> llm : generate_greeting(\n  user_name="Victor"\n)
activate llm
llm --> ui : "Hola Victor, ¿en qué puedo ayudarte?"
deactivate llm

ui -> user : Reproduce:\n"Hola Victor, ¿en qué\npuedo ayudarte?"
deactivate ui

note right of user: **Total: ~800ms**\n✓ Usuario autenticado

@enduml
```

**Flujo Alternativo: Usuario No Reconocido**

```plantuml
@startuml DS009b_NoReconocido

!theme plain

participant "UI" as ui
participant "Voice Auth" as auth
database "DB" as db

ui -> auth : match_profile(fingerprint)
activate auth

auth -> auth : Calcula similitudes:\nmax_similarity = 0.55

note over auth: Confianza < 0.60\n→ No match

auth --> ui : {\n  "match": false,\n  "confidence": 0.55\n}
deactivate auth

ui -> ui : Modo invitado\n(sin autenticación)

ui -> ui : Reproduce:\n"No te reconozco.\n¿Cómo te llamas?"

note right of ui: **Opciones:**\n1. Usuario da su nombre\n2. Administrador registra\n   nuevo perfil de voz

@enduml
```

---

## 11. DS-010: Procesamiento de Comando Ambiguo

**Caso de Uso**: CU-006 - Manejar Comando Ambiguo

**Descripción**: Sistema detecta ambigüedad en comando "Enciende la luz" (múltiples luces disponibles) y solicita aclaración.

```plantuml
@startuml DS010_ComandoAmbiguo

!theme plain

actor Usuario as user
participant "UI" as ui
participant "LLM Agent" as llm
database "SQLite DB" as db
participant "MCP Lighting" as light

user -> ui : "Enciende la luz"
activate ui

ui -> llm : process_command("Enciende la luz")
activate llm

== Análisis de Intención ==

llm -> llm : Detecta intención:\nLIGHTING_TURN_ON

llm -> llm : Extrae parámetros:\ndevice_id = "luz" (ambiguo)

== Búsqueda de Dispositivos ==

llm -> db : SELECT id, name FROM devices\nWHERE type='light'\nAND enabled=1\nAND name LIKE '%luz%'
activate db

db --> llm : [\n  {id: 1, name: "Luz Sala Principal"},\n  {id: 2, name: "Luz Escritorio"},\n  {id: 3, name: "Luz Ambiente"}\n]
deactivate db

note over llm: 3 dispositivos coinciden\n→ Ambigüedad detectada

== Solicitud de Aclaración ==

llm -> llm : Genera opciones:\n1. Luz Sala Principal\n2. Luz Escritorio\n3. Luz Ambiente\n4. Todas

llm --> ui : {\n  "type": "clarification_needed",\n  "message": "Hay varias luces disponibles.\\n¿A cuál te refieres?",\n  "options": [\n    "1. Luz Sala Principal",\n    "2. Luz Escritorio",\n    "3. Luz Ambiente",\n    "4. Todas"\n  ]\n}
deactivate llm

ui -> user : Muestra opciones:\n"Hay varias luces disponibles.\n¿A cuál te refieres?\n1. Luz Sala Principal\n2. Luz Escritorio\n3. Luz Ambiente\n4. Todas"
deactivate ui

note right of user: Usuario debe responder\nen < 30 segundos

== Respuesta del Usuario ==

user -> ui : "Escritorio"
activate ui

ui -> llm : process_clarification("Escritorio")
activate llm

== Resolución de Ambigüedad ==

llm -> llm : Busca coincidencia:\n"Escritorio" → "Luz Escritorio"

note over llm: Match encontrado\ndevice_id = 2

llm -> llm : Almacena preferencia\npara futura inferencia

llm -> db : INSERT INTO user_preferences (\n  user_id=1,\n  preference_key='preferred_light',\n  preference_value=JSON({\n    "context": "escritorio",\n    "device_id": 2\n  })\n)
activate db
db --> llm : OK
deactivate db

note over llm: Próxima vez que usuario\ndiga "escritorio",\nel sistema sabrá a qué\nse refiere

== Ejecución del Comando ==

llm -> light : lighting_turn_on(\n  device_id=2\n)
activate light
light --> llm : success
deactivate light

llm --> ui : "He encendido la luz\ndel escritorio"
deactivate llm

ui -> user : Reproduce respuesta
deactivate ui

note right of user: **Total: ~3500ms**\n(incluye tiempo de\ninteracción humana)

@enduml
```

**Flujo Alternativo: Timeout**

```plantuml
@startuml DS010b_Timeout

!theme plain

participant "UI" as ui
participant "LLM Agent" as llm

ui -> llm : Espera respuesta...

note over ui, llm: 30 segundos sin respuesta

ui -> llm : timeout_event()
activate llm

llm -> llm : Cancela comando pendiente

llm --> ui : "Comando cancelado\npor timeout"
deactivate llm

ui -> ui : Reproduce mensaje\ny vuelve a estado inicial

@enduml
```

---

## 12. Resumen de Tiempos

### 12.1 Tabla Comparativa de Tiempos

| Diagrama | Caso de Uso | Tiempo (ms) | Cumple RNF | Observaciones |
|----------|-------------|-------------|------------|---------------|
| DS-001 | Comando voz simple | 1945 | ✓ < 2000ms | RNF-001 |
| DS-002 | Comando compuesto | 2100 | ✓ < 2500ms | Ejecución paralela |
| DS-003 | Inicialización | 7800 | ✓ < 10000ms | RNF-020 |
| DS-004 | Registro dispositivo | 800 | N/A | Operación admin |
| DS-005 | Aprendizaje preferencias | 2000-5000 | N/A | Background task |
| DS-006 | Manejo de error | 11000 | N/A | 3 retries |
| DS-007 | Ejecución escena | 1800 | ✓ < 2000ms | 5 acciones paralelas |
| DS-008 | Consulta estado | 800 | ✓ < 1000ms | Solo lectura |
| DS-009 | Autenticación voz | 800 | ✓ < 1000ms | Sin LLM |
| DS-010 | Comando ambiguo | 3500 | N/A | Incluye interacción humana |

### 12.2 Cuellos de Botella Identificados

**Top 3 componentes más lentos**:

1. **LLM Inference (Ollama)**: 400-700ms
   - **Impacto**: 31% del tiempo total en DS-001
   - **Optimizaciones**:
     - Modelo cuantizado (4-bit)
     - GPU acceleration (CUDA/Metal)
     - Modelo más pequeño (7B en lugar de 8B)
     - Caché de respuestas comunes

2. **Speech-to-Text (Whisper)**: 300-500ms
   - **Impacto**: 26% del tiempo total en DS-001
   - **Optimizaciones**:
     - Modelo "tiny" o "base" en lugar de "small"
     - GPU acceleration
     - Streaming STT (procesar mientras habla)

3. **Carga de Modelos (Inicio)**: 3300ms
   - **Impacto**: 42% del tiempo de inicio
   - **Optimizaciones**:
     - Lazy loading (cargar solo cuando se necesita)
     - Caché persistente de modelos
     - Paralelización con otras tareas de inicio

### 12.3 Métricas de Rendimiento Objetivo

| Métrica | Valor Objetivo | Valor Actual | Estado |
|---------|----------------|--------------|--------|
| Latencia comando simple | < 2000ms | 1945ms | ✓ |
| Latencia comando compuesto | < 2500ms | 2100ms | ✓ |
| Throughput | > 30 comandos/min | ~35 comandos/min | ✓ |
| Tiempo de inicio | < 10s | 7.8s | ✓ |
| Disponibilidad | > 99% | - | TBD |

---

## Notas Finales

Estos diagramas de secuencia especifican las interacciones detalladas entre componentes del SRCS. Durante la implementación:

1. **Validar tiempos reales** mediante profiling y métricas
2. **Ajustar optimizaciones** según hardware disponible
3. **Monitorear latencias** en producción
4. **Iterar en diseño** si no se cumplen requisitos no funcionales

**Próximos pasos:**
1. Implementar componentes según flujos especificados
2. Crear pruebas de integración basadas en estos diagramas
3. Validar tiempos en hardware objetivo
4. Documentar desviaciones significativas

---

**Última actualización:** Enero 2025
**Autores:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC
