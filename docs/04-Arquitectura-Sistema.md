# Arquitectura del Sistema
## Smart Room Control System (SRCS)

**Universidad Tecnológica de Panamá**
**Facultad de Ingeniería de Sistemas Computacionales**

**Autores:** Alejandro Mosquera, Victor Rodríguez
**Versión:** 1.0
**Fecha:** Enero 2025

---

## Tabla de Contenido

1. [Introducción](#1-introducción)
2. [Diagrama de Contexto (C4 Level 1)](#2-diagrama-de-contexto-c4-level-1)
3. [Diagrama de Contenedores (C4 Level 2)](#3-diagrama-de-contenedores-c4-level-2)
4. [Diagrama de Componentes (C4 Level 3)](#4-diagrama-de-componentes-c4-level-3)
5. [Diagrama de Despliegue](#5-diagrama-de-despliegue)
6. [Patrones Arquitectónicos](#6-patrones-arquitectónicos)
7. [Decisiones Arquitectónicas (ADRs)](#7-decisiones-arquitectónicas-adrs)
8. [Flujo de Datos](#8-flujo-de-datos)

---

## 1. Introducción

Este documento describe la arquitectura de software del Smart Room Control System (SRCS), siguiendo el modelo C4 (Context, Containers, Components, Code) para proporcionar vistas en diferentes niveles de abstracción.

### 1.1 Objetivos Arquitectónicos

1. **Modularidad**: Componentes independientes y reemplazables
2. **Escalabilidad**: Soporte para agregar dispositivos y subsistemas sin rediseño
3. **Privacidad**: Procesamiento local sin dependencias externas
4. **Interoperabilidad**: Uso de MCP como protocolo estándar
5. **Mantenibilidad**: Código organizado, documentado y testeable

### 1.2 Principios de Diseño

- **Separation of Concerns**: Cada componente tiene responsabilidad única y bien definida
- **Dependency Inversion**: Componentes de alto nivel no dependen de detalles de implementación
- **Open/Closed Principle**: Abierto para extensión, cerrado para modificación
- **Single Source of Truth**: Configuración centralizada
- **Fail Fast**: Detección temprana de errores con logging comprehensivo

### 1.3 Base Tecnológica: mcp-client-cli

**DECISIÓN ARQUITECTÓNICA CLAVE** (ver [00-ADR-Base-Tecnologica.md](./00-ADR-Base-Tecnologica.md#adr-001-uso-de-mcp-client-cli-como-base-del-proyecto))

El Smart Room Control System se construye sobre [**mcp-client-cli**](https://github.com/adhikasp/mcp-client-cli), un cliente CLI open-source para Model Context Protocol. Esta decisión proporciona:

**Componentes Base Ya Implementados (~40% del sistema):**

| Componente | Archivo en mcp-client | Requisitos Cubiertos | Estado |
|------------|----------------------|---------------------|--------|
| **Cliente Coordinador MCP** | `tool.py` (McpToolkit) | RF-007, RF-008, RF-011 | ✅ Reutilizar |
| **Agente LLM** | `cli.py` + LangGraph | RF-001, RF-002, RF-004, RF-006 | ✅ Reutilizar |
| **Sistema de Configuración** | `config.py` | RF-028 (parcial) | ✏️ Extender para IoT |
| **Memoria Persistente** | `memory.py` (SqliteStore) | RF-032 | ✏️ Extender |
| **Cache de Herramientas** | `storage.py` | RF-011 | ✅ Reutilizar |
| **Interfaz STT** | `whisperVoiceInterface.py` | RF-019 | ✅ Reutilizar |
| **Interfaz CLI** | `cli.py`, `input.py`, `output.py` | RF-020, RF-022 | ✏️ Extender |
| **Historial Conversacional** | AsyncSqliteSaver (LangGraph) | RF-032 | ✅ Reutilizar |

**Componentes Nuevos a Desarrollar (~60% del sistema):**

| Componente | Ubicación Propuesta | Requisitos | Estimación |
|------------|-------------------|------------|-----------|
| **Servidores MCP IoT** | `src/mcp-servers/` | RF-012 a RF-015 | 40h |
| **Conectores IoT** | `src/iot-connectors/` | RF-016 a RF-018 | 30h |
| **Gestión de Escenas** | `src/scenes/` | RF-024 a RF-026 | 15h |
| **TTS (Text-to-Speech)** | `src/ui/tts_interface.py` | RF-021 | 8h |
| **Administración** | `src/admin/` | RF-027, RF-029, RF-030 | 10h |
| **Aprendizaje de Preferencias** | `src/learning/` | RF-031, RF-033 | 7h |

**Beneficios de esta Arquitectura:**
- ⚡ **Ahorro de ~90 horas** de desarrollo (37.5%)
- ✅ **Código probado** en producción con tests de integración
- 🏗️ **Fundación sólida** para extensión con servidores MCP IoT
- 🔄 **Compatibilidad** con especificación MCP oficial
- 📚 **Documentación existente** (README.md, CLAUDE.md, CONFIG.md)

**Estrategia de Integración:**
1. **Fork** del repositorio mcp-client-cli
2. **Renombrar** proyecto a smart-room-mcp
3. **Extender** base de datos con tablas para dispositivos, escenas, métricas
4. **Crear** servidores MCP especializados para IoT
5. **Mantener** créditos y licencia MIT del proyecto original

---

## 2. Diagrama de Contexto (C4 Level 1)

El diagrama de contexto muestra el sistema en su entorno, interactuando con usuarios y sistemas externos.

```plantuml
@startuml C4_Context
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Context.puml

title Smart Room Control System - Context Diagram

Person(user, "Usuario del Smart Room", "Persona que habita o usa el Smart Room")
Person(admin, "Administrador", "Responsable de configurar y mantener el sistema")
Person(developer, "Desarrollador", "Extiende funcionalidad del sistema")

System(srcs, "Smart Room Control System", "Sistema inteligente para control unificado de dispositivos IoT mediante agentes AI y MCP")

System_Ext(devices_lighting, "Dispositivos de Iluminación", "Philips Hue, LIFX")
System_Ext(devices_climate, "Dispositivos de Climatización", "Nest, Ecobee")
System_Ext(devices_security, "Dispositivos de Seguridad", "Cámaras IP, sensores")
System_Ext(devices_entertainment, "Dispositivos de Entretenimiento", "Sonos, Chromecast")

Rel(user, srcs, "Controla ambiente mediante voz/texto", "Comandos en lenguaje natural")
Rel(admin, srcs, "Configura y monitorea", "Interfaz web/CLI")
Rel(developer, srcs, "Extiende funcionalidad", "APIs, Servidores MCP personalizados")

Rel(srcs, devices_lighting, "Controla iluminación", "API REST")
Rel(srcs, devices_climate, "Controla temperatura", "API REST")
Rel(srcs, devices_security, "Gestiona seguridad", "ONVIF, API REST")
Rel(srcs, devices_entertainment, "Controla audio/video", "API REST")

@enduml
```

### 2.1 Actores Externos

**Usuario Final**
- Interactúa mediante voz o texto en lenguaje natural
- Objetivo: Controlar ambiente de forma intuitiva
- Ejemplos: Estudiante en laboratorio Smart Room, profesor dando clase

**Administrador del Sistema**
- Gestiona configuración y dispositivos
- Monitorea logs y métricas de rendimiento
- Objetivo: Mantener sistema operativo y optimizado

**Desarrollador/Investigador**
- Crea nuevos servidores MCP personalizados
- Integra nuevos dispositivos IoT
- Objetivo: Extender capacidades del sistema

**Sistemas Externos (Dispositivos IoT)**
- Ejecutan acciones físicas (encender luces, ajustar temperatura, etc.)
- Reportan estado actual al sistema
- Comunicación mediante APIs REST, MQTT, Zigbee, etc.

---

## 3. Diagrama de Contenedores (C4 Level 2)

Los contenedores representan aplicaciones o servicios ejecutables del sistema.

```plantuml
@startuml C4_Container
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

title Smart Room Control System - Container Diagram

Person(user, "Usuario", "Usuario del Smart Room")

System_Boundary(srcs, "Smart Room Control System") {
    Container(ui, "User Interface", "Python, Rich CLI / FastAPI Web", "Interfaz de voz y texto para interacción con el usuario")

    Container(llm_agent, "LLM Agent", "Python, LangChain, Ollama", "Cerebro del sistema: Procesa lenguaje natural, toma decisiones, orquesta acciones")

    Container(mcp_coordinator, "MCP Coordinator", "Python, MCP SDK", "Gestiona conexiones con servidores MCP, invoca herramientas, consolida respuestas")

    Container(mcp_server_lighting, "MCP Lighting Server", "Python, MCP SDK", "Expone herramientas para control de iluminación")

    Container(mcp_server_climate, "MCP Climate Server", "Python, MCP SDK", "Expone herramientas para climatización")

    Container(mcp_server_security, "MCP Security Server", "Python, MCP SDK", "Expone herramientas para seguridad")

    Container(mcp_server_entertainment, "MCP Entertainment Server", "Python, MCP SDK", "Expone herramientas para audio/video")

    Container(iot_connectors, "IoT Connectors", "Python, API Clients", "Adaptadores que traducen comandos MCP a APIs de dispositivos específicos")

    ContainerDb(database, "Database", "SQLite", "Almacena preferencias, historial, configuración, escenas")

    ContainerDb(config, "Configuration Files", "JSON", "Configuración de servidores MCP, dispositivos, sistema")
}

System_Ext(devices, "Dispositivos IoT", "Philips Hue, Nest, Cámaras, Sonos")
System_Ext(llm_model, "Llama Model", "Modelo LLM ejecutado por Ollama")

Rel(user, ui, "Comandos de voz/texto", "HTTP/WebSocket/CLI")
Rel(ui, llm_agent, "Envía transcripción/texto", "Python function call")
Rel(llm_agent, llm_model, "Solicita inferencia", "HTTP API")
Rel(llm_agent, mcp_coordinator, "Orquesta acciones", "Python function call")
Rel(llm_agent, database, "Consulta contexto, preferencias", "SQLAlchemy")

Rel(mcp_coordinator, mcp_server_lighting, "Invoca herramientas", "JSON-RPC over stdio")
Rel(mcp_coordinator, mcp_server_climate, "Invoca herramientas", "JSON-RPC over stdio")
Rel(mcp_coordinator, mcp_server_security, "Invoca herramientas", "JSON-RPC over stdio")
Rel(mcp_coordinator, mcp_server_entertainment, "Invoca herramientas", "JSON-RPC over stdio")

Rel(mcp_server_lighting, iot_connectors, "Delega ejecución", "Python function call")
Rel(mcp_server_climate, iot_connectors, "Delega ejecución", "Python function call")
Rel(mcp_server_security, iot_connectors, "Delega ejecución", "Python function call")
Rel(mcp_server_entertainment, iot_connectors, "Delega ejecución", "Python function call")

Rel(iot_connectors, devices, "Controla dispositivos", "API REST/MQTT/Zigbee")

Rel(mcp_coordinator, config, "Lee configuración de servidores", "File I/O")
Rel(llm_agent, config, "Lee system prompt, configuración LLM", "File I/O")

@enduml
```

### 3.1 Descripción de Contenedores

#### User Interface (UI)
- **Tecnología**: Python, Rich (CLI), FastAPI (web opcional)
- **Responsabilidades**:
  - Captura de entrada de voz mediante micrófono
  - Conversión Speech-to-Text con Whisper
  - Aceptación de entrada de texto
  - Conversión Text-to-Speech con Bark/Piper
  - Display de respuestas
- **Interfaz**: CLI principal, API HTTP/WebSocket opcional

#### LLM Agent
- **Tecnología**: Python, LangChain, LangGraph, Ollama client
- **Responsabilidades**:
  - Procesamiento de lenguaje natural
  - Toma de decisiones contextuales
  - Planificación de acciones complejas
  - Gestión de conversación multi-turno
  - Aprendizaje de preferencias
- **Modelo**: Llama 3.1 8B o superior (ejecutado por Ollama)

#### MCP Coordinator
- **Tecnología**: Python, MCP SDK oficial
- **Responsabilidades**:
  - Descubrimiento y conexión con servidores MCP
  - Gestión de pool de conexiones (stdio)
  - Invocación de herramientas según indicaciones del LLM
  - Consolidación de respuestas
  - Caché de capacidades de servidores
- **Protocolo**: JSON-RPC 2.0 sobre stdio

#### MCP Servers (Lighting, Climate, Security, Entertainment)
- **Tecnología**: Python, MCP SDK oficial
- **Responsabilidades**:
  - Exposición de herramientas específicas del dominio
  - Validación de parámetros
  - Delegación a conectores IoT
  - Retorno de resultados estandarizados
- **Protocolo**: JSON-RPC 2.0 sobre stdio

#### IoT Connectors
- **Tecnología**: Python, librerías de clientes (phue, python-nest, soco, etc.)
- **Responsabilidades**:
  - Traducción de comandos MCP a APIs nativas de dispositivos
  - Autenticación y manejo de sesiones
  - Manejo de errores específicos de dispositivos
  - Normalización de respuestas
- **Patrón**: Adapter Pattern

#### Database (SQLite)
- **Tecnología**: SQLite 3, SQLAlchemy ORM
- **Responsabilidades**:
  - Persistencia de preferencias de usuario
  - Historial de conversaciones (LangGraph checkpoints)
  - Almacenamiento de escenas y rutinas
  - Logs de acciones ejecutadas
  - Métricas de rendimiento
- **Ubicación**: `~/.llm/conversations.db`

#### Configuration Files
- **Formato**: JSON con soporte de comentarios (commentjson)
- **Archivos**:
  - `config.json`: Configuración general, system prompt, configuración LLM
  - `mcp-servers-config.json`: Configuración de servidores MCP
  - `devices-config.json`: Registro de dispositivos IoT
- **Ubicación**: `~/.llm/` o `./config/`

---

## 4. Diagrama de Componentes (C4 Level 3)

Detalle de componentes internos del contenedor **LLM Agent**.

```plantuml
@startuml C4_Component_LLM_Agent
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Component.puml

title Smart Room Control System - LLM Agent Components

Container(ui, "User Interface", "Python")
Container(mcp_coordinator, "MCP Coordinator", "Python")
ContainerDb(database, "Database", "SQLite")
System_Ext(ollama, "Ollama Service", "LLM Runtime")

Container_Boundary(llm_agent, "LLM Agent") {
    Component(nlp_processor, "NLP Processor", "Python, LangChain", "Interpreta comandos en lenguaje natural, extrae intención y entidades")

    Component(decision_engine, "Decision Engine", "Python, LangChain", "Toma decisiones basadas en contexto y preferencias")

    Component(action_planner, "Action Planner", "Python, LangGraph", "Descompone tareas complejas en acciones atómicas, determina orden de ejecución")

    Component(context_manager, "Context Manager", "Python", "Gestiona contexto de conversación, recupera información relevante de DB")

    Component(preference_learner, "Preference Learner", "Python", "Analiza patrones de uso, aprende preferencias del usuario")

    Component(response_generator, "Response Generator", "Python, LangChain", "Genera respuestas en lenguaje natural basadas en resultados de acciones")

    Component(llm_interface, "LLM Interface", "Python, Ollama client", "Abstracción para comunicación con Ollama/Llama")
}

Rel(ui, nlp_processor, "Envía texto de comando", "Python call")
Rel(nlp_processor, llm_interface, "Solicita inferencia", "HTTP")
Rel(llm_interface, ollama, "Genera respuesta", "HTTP API")

Rel(nlp_processor, context_manager, "Solicita contexto", "Python call")
Rel(context_manager, database, "Consulta historial, preferencias", "SQLAlchemy")

Rel(nlp_processor, decision_engine, "Pasa intención y entidades", "Python call")
Rel(decision_engine, action_planner, "Solicita plan de acción", "Python call")
Rel(decision_engine, preference_learner, "Consulta preferencias", "Python call")

Rel(action_planner, mcp_coordinator, "Invoca herramientas MCP", "Python call")
Rel(mcp_coordinator, action_planner, "Retorna resultados", "Python call")

Rel(action_planner, response_generator, "Solicita generación de respuesta", "Python call")
Rel(response_generator, llm_interface, "Solicita generación de texto", "HTTP")
Rel(response_generator, ui, "Envía respuesta", "Python call")

Rel(preference_learner, database, "Almacena preferencias aprendidas", "SQLAlchemy")

@enduml
```

### 4.1 Componentes del LLM Agent

**NLP Processor**
- Entrada: Texto del comando (transcripción de voz o texto directo)
- Procesamiento: Análisis sintáctico, extracción de intención y entidades mediante LLM
- Salida: Estructura `Intent(action, entities, parameters)`
- Tecnología: LangChain PromptTemplate + Llama

**Decision Engine**
- Entrada: Intención + contexto + preferencias
- Procesamiento: Aplicación de reglas de negocio, consideración de estado actual
- Salida: Decisión de acción a ejecutar
- Patrón: Rule Engine + Context-aware AI

**Action Planner**
- Entrada: Decisión de alto nivel (ej: "activar modo cine")
- Procesamiento: Descomposición en acciones atómicas, determinación de secuencialidad/paralelismo
- Salida: Grafo de acciones con dependencias
- Tecnología: LangGraph (agent with state)

**Context Manager**
- Entrada: Solicitudes de contexto (estado actual, historial, etc.)
- Procesamiento: Recuperación de DB, construcción de contexto relevante
- Salida: Diccionario de contexto
- Optimización: Caché en memoria para contexto frecuente

**Preference Learner**
- Entrada: Historial de acciones del usuario
- Procesamiento: Detección de patrones, inferencia de preferencias
- Salida: Reglas de preferencia almacenadas
- Algoritmo: Análisis de frecuencia + clustering temporal

**Response Generator**
- Entrada: Resultado de acciones ejecutadas
- Procesamiento: Generación de texto natural explicando resultado
- Salida: Texto de respuesta
- Tecnología: LangChain + Llama con template de respuestas

**LLM Interface**
- Entrada: Prompt formateado para Llama
- Procesamiento: Comunicación con Ollama, manejo de streaming
- Salida: Texto generado o estructura JSON
- Abstracción: Permite intercambiar backend LLM

---

## 5. Diagrama de Despliegue

```plantuml
@startuml Deployment
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Deployment.puml

title Smart Room Control System - Deployment Diagram

Deployment_Node(smartroom, "Smart Room Environment", "Physical Lab") {

    Deployment_Node(server, "Server Principal", "Ubuntu 22.04 LTS / Windows 11") {
        Deployment_Node(python_env, "Python Virtual Environment", "Python 3.12+") {
            Container(srcs_app, "SRCS Application", "Python processes", "LLM Agent, MCP Coordinator, Servers MCP, UI")
        }

        Deployment_Node(ollama_service, "Ollama Service", "Systemd service / Windows Service") {
            Container(llm_model, "Llama 3.1 8B", "GGUF format", "Modelo LLM cargado en VRAM")
        }

        Deployment_Node(storage, "Storage", "SSD NVMe") {
            ContainerDb(sqlite_db, "SQLite Database", "conversations.db", "Preferencias, historial, configuración")
            ContainerDb(config_files, "Config Files", "JSON", "Configuración del sistema")
        }
    }

    Deployment_Node(network, "Local Network", "Gigabit Ethernet / WiFi 6") {
        Deployment_Node(hue_bridge, "Philips Hue Bridge", "IoT Hub") {
            System_Ext(hue_lights, "Philips Hue Lights", "Bombillas inteligentes")
        }

        System_Ext(nest_thermostat, "Nest Thermostat", "Termostato inteligente")
        System_Ext(ip_camera, "IP Camera", "Cámara de seguridad")
        System_Ext(sonos_speaker, "Sonos Speaker", "Altavoz inteligente")
    }

    Deployment_Node(user_devices, "User Devices", "Optional") {
        System_Ext(web_browser, "Web Browser", "Interfaz web de administración")
    }
}

Rel(srcs_app, llm_model, "Solicita inferencia", "HTTP localhost:11434")
Rel(srcs_app, sqlite_db, "Lee/Escribe datos", "File I/O")
Rel(srcs_app, config_files, "Lee configuración", "File I/O")

Rel(srcs_app, hue_bridge, "Controla luces", "HTTP API REST")
Rel(srcs_app, nest_thermostat, "Controla clima", "HTTP API REST")
Rel(srcs_app, ip_camera, "Obtiene stream", "RTSP/ONVIF")
Rel(srcs_app, sonos_speaker, "Controla audio", "HTTP API REST")

Rel(web_browser, srcs_app, "Accede a interfaz web", "HTTPS (opcional)")

@enduml
```

### 5.1 Descripción del Despliegue

**Servidor Principal**
- **Hardware**: Según especificaciones RH-001 a RH-006 (ver SRS)
- **SO**: Ubuntu 22.04 LTS (preferido) o Windows 11 Pro
- **Servicios**:
  - Ollama: Puerto 11434 (localhost only)
  - SRCS Application: Procesos Python
  - Base de datos SQLite: Archivo local
- **Red**: Conectado a red local del Smart Room

**Red Local**
- **Topología**: Estrella con switch/router central
- **Protocolo**: Ethernet 1Gbps o WiFi 6
- **Segmentación**: VLAN opcional para aislar tráfico IoT

**Dispositivos IoT**
- **Philips Hue**: Requiere bridge conectado a red
- **Nest Thermostat**: WiFi directo a router
- **Cámaras IP**: PoE o WiFi
- **Sonos**: WiFi directo

**Opcionales**
- **Web Browser**: Para interfaz de administración (FastAPI)
- **Home Assistant**: Como intermediario para dispositivos heterogéneos

---

## 6. Patrones Arquitectónicos

### 6.1 Patrón Agente Orquestador

**Descripción**: El LLM actúa como agente central que orquesta múltiples agentes especializados (servidores MCP).

**Ventajas**:
- Inteligencia centralizada con especialización distribuida
- Facilita razonamiento de alto nivel
- Permite extensibilidad mediante nuevos agentes

**Implementación**: LangGraph ReAct Agent con herramientas MCP

### 6.2 Patrón Adapter (para Conectores IoT)

**Descripción**: Conectores traducen interfaz MCP estándar a APIs específicas de dispositivos.

**Ventajas**:
- Desacopla lógica de negocio de detalles de dispositivos
- Facilita agregar nuevos dispositivos
- Centraliza manejo de errores específicos de dispositivos

**Ejemplo**:
```python
class PhilipsHueAdapter:
    def turn_on(self, device_id, brightness, color):
        # Traduce a API de Philips Hue
        hue_command = self._translate_to_hue_format(brightness, color)
        self.hue_bridge.set_light(device_id, hue_command)
```

### 6.3 Patrón Strategy (para Modelos LLM)

**Descripción**: Abstracción que permite intercambiar modelo LLM sin cambiar código del agente.

**Ventajas**:
- Facilita experimentación con diferentes modelos
- Permite selección dinámica según recurso disponible
- Simplifica testing con modelos mock

**Implementación**: LangChain AbstractLLM interface

### 6.4 Patrón Observer (para Estado de Dispositivos)

**Descripción**: Dispositivos notifican cambios de estado al sistema.

**Ventajas**:
- Mantiene vista consistente del ambiente
- Permite reacciones automáticas a eventos
- Reduce polling innecesario

**Implementación**: Webhooks o MQTT subscriptions

### 6.5 Patrón Command (para Acciones)

**Descripción**: Cada acción en dispositivo se encapsula como objeto Command.

**Ventajas**:
- Facilita deshacer/rehacer acciones
- Simplifica logging y auditoría
- Permite composición de comandos

### 6.6 Patrón Repository (para Datos)

**Descripción**: Abstracción de persistencia mediante repositorios.

**Ventajas**:
- Desacopla lógica de negocio de DB
- Facilita testing con repositories mock
- Centraliza queries

**Implementación**: SQLAlchemy con pattern Repository

---

## 7. Decisiones Arquitectónicas (ADRs)

**NOTA IMPORTANTE**: Las decisiones arquitectónicas fundamentales (ADR-001 a ADR-003) están documentadas en [00-ADR-Base-Tecnologica.md](./00-ADR-Base-Tecnologica.md):
- **ADR-001**: Uso de mcp-client-cli como base del proyecto ⭐ **CRÍTICO**
- **ADR-002**: Stack tecnológico Python + LangChain
- **ADR-003**: SQLite como base de datos

Los siguientes ADRs son decisiones específicas de diseño del sistema:

### ADR-004: Procesamiento Local vs. Cloud

**Contexto**: El sistema necesita procesar comandos de lenguaje natural y tomar decisiones.

**Decisión**: Ejecutar LLM localmente con Ollama + Llama, sin dependencia de servicios cloud.

**Razones**:
- Privacidad: Datos de usuario permanecen locales
- Latencia: Eliminación de round-trip a internet
- Costo: Sin cargos por inferencia
- Autonomía: Sistema funciona sin internet

**Consecuencias**:
- (+) Garantía de privacidad
- (+) Latencia predecible y baja
- (-) Requiere hardware potente (GPU)
- (-) Limitado a modelos que caben en VRAM local

### ADR-005: Model Context Protocol como Capa de Comunicación

**Contexto**: Necesidad de protocolo estandarizado para comunicación entre LLM y agentes especializados.

**Decisión**: Adoptar MCP como protocolo oficial para comunicación.

**Alternativas consideradas**:
- APIs REST personalizadas
- gRPC
- MQTT

**Razones**:
- Diseñado específicamente para agentes AI
- Soporte nativo en LangChain
- Comunidad activa y especificación abierta
- Facilita descubrimiento de capacidades

**Consecuencias**:
- (+) Interoperabilidad con ecosistema MCP
- (+) Protocolo bien documentado
- (+) Facilita extensibilidad
- (-) Protocolo relativamente nuevo (menos maduro que REST)

### ADR-006: LangGraph para Gestión de Estado del Agente

**Contexto**: El agente AI necesita mantener estado entre múltiples turnos de conversación.

**Decisión**: Usar LangGraph con checkpoints en SQLite.

**Alternativas consideradas**:
- Estado en memoria (volátil)
- Redis para estado distribuido
- Custom state management

**Razones**:
- Integración nativa con LangChain
- Soporte para grafos de estado complejos
- Persistencia automática con checkpoints
- Facilita debugging con visualización de grafo

**Consecuencias**:
- (+) Estado persistente entre reinicios
- (+) Facilita implementación de ReAct pattern
- (+) Debugging simplificado
- (-) Overhead de persistencia en cada paso

**NOTA**: Los ADRs sobre selección de base de datos (SQLite) y lenguaje de programación (Python) han sido consolidados en [00-ADR-Base-Tecnologica.md](./00-ADR-Base-Tecnologica.md) como ADR-003 y ADR-002 respectivamente, donde se presentan en el contexto de la decisión de usar mcp-client-cli como base.

---

## 8. Flujo de Datos

### 8.1 Flujo de Comando de Voz Exitoso

```
1. Usuario: "Enciende las luces del salón al 70%"
   └─> UI: Captura audio del micrófono

2. UI: Conversión Speech-to-Text con Whisper
   └─> Transcripción: "Enciende las luces del salón al 70%"

3. UI → LLM Agent: Envía texto transcrito
   └─> NLP Processor: Analiza comando con Llama

4. NLP Processor → LLM: Prompt de extracción de intención
   └─> LLM: Retorna Intent(action="turn_on", device="luces_salón", brightness=70)

5. Decision Engine: Valida intención, consulta contexto
   └─> Context Manager → DB: ¿Existen "luces_salón"? → Sí, device_id=hue_light_3

6. Action Planner: Crea plan de acción
   └─> Plan: [Action(tool="lighting_turn_on", params={device_id:"hue_light_3", brightness:70})]

7. Action Planner → MCP Coordinator: Solicita ejecución
   └─> MCP Coordinator → MCP Lighting Server: Invoca lighting_turn_on(...)

8. MCP Lighting Server → IoT Connector (Philips Hue): Delega ejecución
   └─> Philips Hue Adapter: Traduce a API Hue, envía HTTP request

9. Philips Hue Bridge: Enciende bombilla al 70%
   └─> Dispositivo físico: Luz enciende

10. Philips Hue Bridge → Adapter: Responde success
    └─> Adapter → MCP Server: Retorna resultado estandarizado

11. MCP Server → MCP Coordinator → Action Planner: Confirma éxito

12. Response Generator → LLM: Solicita generación de confirmación
    └─> LLM: "He encendido las luces del salón al 70%"

13. Response Generator → UI: Envía respuesta

14. UI: Text-to-Speech con Bark
    └─> Audio: "He encendido las luces del salón al 70%"

15. Usuario: Escucha confirmación
```

**Tiempo total**: ~1.8 segundos (dentro del objetivo de 2s)

### 8.2 Flujo de Comando Compuesto

```
Usuario: "Activa modo cine"

1-4. [Igual que flujo simple hasta extracción de intención]

5. Decision Engine: Reconoce "modo cine" como escena predefinida
   └─> Context Manager → DB: Recupera Scene(name="modo_cine")
       Scene = {
         lights: {brightness:10, color:"warm_white"},
         climate: {temperature:21},
         entertainment: {device:"tv", source:"HDMI1", volume:60},
         blinds: {position:"closed"}
       }

6. Action Planner: Descompone en acciones paralelas
   └─> Plan: [
         Action(tool="lighting_set_brightness", params={...}) [PARALLEL],
         Action(tool="lighting_set_color", params={...})      [PARALLEL],
         Action(tool="climate_set_temperature", params={...}) [PARALLEL],
         Action(tool="entertainment_power_on", params={...})  [SEQUENTIAL],
         Action(tool="entertainment_select_source", params={...}) [SEQUENTIAL],
       ]

7. MCP Coordinator: Ejecuta acciones paralelas simultáneamente
   └─> Invoca 3 servidores MCP en paralelo (lighting, climate)
       Espera confirmación de todos
       Luego ejecuta acciones secuenciales de entertainment

8-15. [Ejecución y confirmación]

Respuesta: "He activado el modo cine: luces atenuadas al 10%, temperatura a 21 grados y TV encendida"
```

---

## Conclusión

Esta arquitectura proporciona:
- **Modularidad**: Componentes independientes y reemplazables
- **Extensibilidad**: Fácil agregar nuevos servidores MCP y dispositivos
- **Privacidad**: Procesamiento completamente local
- **Escalabilidad**: Arquitectura preparada para crecimiento
- **Mantenibilidad**: Código organizado con separación de responsabilidades

La adopción de MCP como protocolo central permite interoperabilidad futura con otros sistemas y facilita la investigación en agentes AI colaborativos.

---

**Próximos Pasos**: Ver documentos de Historias de Usuario (doc 02), Casos de Uso (doc 03) y Diagramas de Secuencia (doc 07) para detalles de implementación.
