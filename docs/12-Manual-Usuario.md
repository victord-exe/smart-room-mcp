# Manual de Usuario
## Smart Room Control System (SRCS)

**Universidad Tecnológica de Panamá**
**Facultad de Ingeniería de Sistemas Computacionales**

**Autores:** Alejandro Mosquera, Victor Rodríguez
**Versión:** 1.0
**Fecha:** Octubre 2025

---

## Tabla de Contenido

1. [Introducción](#1-introducción)
2. [Requisitos del Sistema](#2-requisitos-del-sistema)
3. [Instalación](#3-instalación)
4. [Configuración Inicial](#4-configuración-inicial)
5. [Uso Básico](#5-uso-básico)
6. [Gestión de Escenas](#6-gestión-de-escenas)
7. [Configuración Avanzada](#7-configuración-avanzada)
8. [Solución de Problemas](#8-solución-de-problemas)
9. [Preguntas Frecuentes](#9-preguntas-frecuentes)

---

## 1. Introducción

### 1.1 ¿Qué es SRCS?

El **Smart Room Control System (SRCS)** es un sistema de control inteligente para habitaciones inteligentes que permite controlar dispositivos IoT mediante comandos de voz y texto en lenguaje natural.

**Características principales:**
- 🗣️ Control por voz (castellano/inglés)
- 💬 Interfaz de texto mediante CLI
- 🏠 Compatible con Philips Hue, Nest, cámaras, Sonos
- 🎬 Gestión de escenas y rutinas personalizadas
- 🧠 Aprendizaje de preferencias del usuario
- 🔒 Procesamiento local (sin enviar datos a la nube)

### 1.2 ¿Cómo funciona?

SRCS utiliza:
1. **Agente AI** (Llama 3.1) para entender comandos en lenguaje natural
2. **Protocolo MCP** para comunicarse con servidores especializados
3. **Servidores MCP IoT** para controlar iluminación, clima, seguridad, entretenimiento
4. **Conectores IoT** para integrarse con dispositivos comerciales

**Ejemplo de flujo:**
```
Usuario: "Enciende la luz de la sala al 80%"
  ↓
[Agente AI] entiende la intención
  ↓
[MCP Coordinator] llama a lighting_turn_on(device="sala", brightness=80)
  ↓
[Lighting Server] ejecuta acción
  ↓
[Philips Hue Connector] envía comando al bombillo
  ↓
[Dispositivo] la luz se enciende
  ↓
Sistema: "Luz de la sala encendida al 80%"
```

---

## 2. Requisitos del Sistema

### 2.1 Hardware Mínimo

- **Procesador:** Intel Core i5 o AMD Ryzen 5 (o superior)
- **RAM:** 8 GB (16 GB recomendado para LLM local)
- **Almacenamiento:** 10 GB libres (5 GB para modelo Llama 3.1)
- **Red:** WiFi 802.11n o Ethernet
- **Micrófono:** (opcional, para comandos de voz)

### 2.2 Software

- **Sistema Operativo:** Linux (Ubuntu 22.04+), macOS (12+), Windows 10/11 con WSL2
- **Python:** 3.12 o superior
- **Ollama:** Última versión (para Llama 3.1)
- **Git:** 2.30+

### 2.3 Dispositivos IoT Soportados

| Categoría | Dispositivos Soportados |
|-----------|-------------------------|
| **Iluminación** | Philips Hue, bombillos compatibles con Hue Bridge |
| **Clima** | Termostatos Nest, Ecobee, termostatos genéricos MQTT |
| **Seguridad** | Cámaras ONVIF, sistemas de alarma genéricos |
| **Entretenimiento** | Sonos, dispositivos Chromecast |

**Nota:** Se requiere al menos **1 dispositivo IoT** para usar SRCS (recomendado: Philips Hue Starter Kit).

---

## 3. Instalación

### 3.1 Instalación en Linux/macOS

#### Paso 1: Instalar Dependencias del Sistema

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install -y python3.12 python3.12-venv python3-pip git portaudio19-dev
```

**macOS (con Homebrew):**
```bash
brew install python@3.12 git portaudio
```

#### Paso 2: Instalar Ollama

**Linux:**
```bash
curl -fsSL https://ollama.ai/install.sh | sh
```

**macOS:**
```bash
brew install ollama
```

Iniciar servicio de Ollama:
```bash
ollama serve
```

En otra terminal, descargar el modelo Llama 3.1:
```bash
ollama pull llama3.1
```

#### Paso 3: Clonar el Repositorio

```bash
git clone https://github.com/YOUR_USERNAME/smart-room-mcp.git
cd smart-room-mcp
```

#### Paso 4: Crear Entorno Virtual

```bash
python3.12 -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
```

#### Paso 5: Instalar Dependencias de Python

```bash
pip install --upgrade pip
pip install -e .
```

Esto instalará todas las dependencias definidas en `pyproject.toml`.

#### Paso 6: Verificar Instalación

```bash
srcs --version
```

Deberías ver:
```
Smart Room Control System v1.0.0
```

### 3.2 Instalación en Windows (WSL2)

#### Paso 1: Habilitar WSL2

Abrir PowerShell como Administrador:
```powershell
wsl --install -d Ubuntu-22.04
```

Reiniciar el sistema.

#### Paso 2: Continuar con Instalación de Linux

Una vez en Ubuntu WSL, seguir los pasos de la sección [3.1 Instalación en Linux/macOS](#31-instalación-en-linuxmacos).

**Nota sobre audio en WSL2:**
- Para comandos de voz, instalar PulseAudio en Windows y configurar PULSE_SERVER
- Alternativa: usar solo interfaz de texto (sin voz)

---

## 4. Configuración Inicial

### 4.1 Estructura de Configuración

SRCS utiliza un archivo de configuración en formato JSON ubicado en:

**Linux/macOS:** `~/.llm/config.json`
**Windows:** `%USERPROFILE%\.llm\config.json`

### 4.2 Configuración Básica

Crear el archivo de configuración:

```bash
mkdir -p ~/.llm
nano ~/.llm/config.json
```

**Contenido mínimo:**

```json
{
  "model": "llama3.1",
  "llm_provider": "ollama",
  "ollama_base_url": "http://localhost:11434",
  "database_path": "~/.llm/smart_room.db",
  "mcp_servers": {
    "lighting": {
      "command": "uvx",
      "args": ["mcp-server-lighting"],
      "env": {
        "HUE_BRIDGE_IP": "192.168.1.100",
        "HUE_USERNAME": "your-hue-username"
      }
    },
    "climate": {
      "command": "uvx",
      "args": ["mcp-server-climate"],
      "env": {
        "NEST_ACCESS_TOKEN": "your-nest-token",
        "NEST_REFRESH_TOKEN": "your-nest-refresh-token"
      }
    }
  }
}
```

### 4.3 Obtener Credenciales de Dispositivos IoT

#### Philips Hue

1. Conectar Hue Bridge a la misma red WiFi que tu PC
2. Descubrir IP del Bridge:
   ```bash
   # Opción 1: Visitar https://discovery.meethue.com/
   # Opción 2:
   nmap -sP 192.168.1.0/24 | grep -i philips
   ```

3. Crear usuario en el Bridge:
   ```bash
   curl -X POST http://YOUR_BRIDGE_IP/api \
     -d '{"devicetype":"smart_room_mcp#user"}'
   ```

   *Presionar el botón del Hue Bridge dentro de 30 segundos*

4. La respuesta contendrá tu username:
   ```json
   [{"success":{"username":"1234567890abcdef"}}]
   ```

5. Agregar a `config.json`:
   ```json
   "HUE_BRIDGE_IP": "192.168.1.100",
   "HUE_USERNAME": "1234567890abcdef"
   ```

#### Nest Thermostat

1. Ir a [Google Cloud Console](https://console.cloud.google.com/)
2. Crear proyecto "Smart Room MCP"
3. Habilitar "Smart Device Management API"
4. Crear credenciales OAuth 2.0
5. Seguir flujo OAuth para obtener tokens
6. Agregar a `config.json`:
   ```json
   "NEST_ACCESS_TOKEN": "ya29.a0AfH6SMBx...",
   "NEST_REFRESH_TOKEN": "1//0gHZ9K8qR..."
   ```

**Nota:** Ver [Guía de Nest API](https://developers.google.com/nest/device-access/get-started) para detalles.

### 4.4 Registrar Dispositivos

Iniciar SRCS por primera vez:

```bash
srcs
```

Registrar dispositivos mediante comandos:

```
> registra un nuevo dispositivo tipo luz llamado "Sala" en la ubicación "sala-principal" con ID "hue-bulb-1"
```

El sistema responderá:
```
Dispositivo registrado exitosamente.
ID: hue-bulb-1
Nombre: Sala
Tipo: luz
Ubicación: sala-principal
Estado: activo
```

Listar dispositivos:
```
> muestra todos los dispositivos
```

### 4.5 Probar la Configuración

Ejecutar comando de prueba:

```
> enciende la luz de la sala
```

Si todo está configurado correctamente, la luz debería encenderse y el sistema responder:
```
Luz de la sala encendida.
```

---

## 5. Uso Básico

### 5.1 Iniciar SRCS

**Modo texto (CLI):**
```bash
srcs
```

**Modo voz:**
```bash
srcs --voice
```

**Modo mixto (voz + texto):**
```bash
srcs --voice --text
```

### 5.2 Comandos de Texto

Una vez iniciado SRCS, verás el prompt:
```
SRCS> _
```

**Ejemplos de comandos:**

#### Iluminación

```
SRCS> enciende la luz de la sala
SRCS> apaga todas las luces
SRCS> pon la luz del dormitorio al 50%
SRCS> cambia la luz de la cocina a color azul
SRCS> atenúa las luces de la sala
SRCS> ¿están las luces encendidas?
```

#### Clima

```
SRCS> sube la temperatura a 22 grados
SRCS> baja la temperatura 2 grados
SRCS> pon el aire acondicionado en modo frío
SRCS> ¿cuál es la temperatura actual?
SRCS> ¿cuál es la humedad?
```

#### Seguridad

```
SRCS> activa la alarma
SRCS> desactiva la alarma
SRCS> pon la alarma en modo noche
SRCS> ¿está la alarma activada?
SRCS> muéstrame la cámara de la entrada
```

#### Entretenimiento

```
SRCS> reproduce música
SRCS> pausa la música
SRCS> sube el volumen
SRCS> baja el volumen al 30%
SRCS> cambia la fuente a Bluetooth
```

#### Comandos Compuestos

```
SRCS> apaga todas las luces y activa la alarma
SRCS> sube la temperatura a 21 grados y enciende la luz de la sala al 80%
SRCS> pon la casa en modo noche (apagar luces, armar alarma, bajar temperatura)
```

### 5.3 Comandos de Voz

Con el modo `--voice` activado, el sistema escucha continuamente.

**Flujo:**
1. Di "Oye SRCS" (wake word) - *opcional, depende de configuración*
2. Habla tu comando claramente: "Enciende la luz de la sala"
3. Espera la respuesta (visual en CLI y/o auditiva si TTS está habilitado)

**Consejos para comandos de voz:**
- 🎤 Habla claro y a velocidad normal
- 🔇 Minimiza ruido de fondo
- 📏 Mantén distancia de 30-50 cm del micrófono
- ⏱️ Espera 1-2 segundos después del wake word

### 5.4 Salir de SRCS

```
SRCS> salir
```

O presionar `Ctrl+C`.

---

## 6. Gestión de Escenas

### 6.1 ¿Qué es una Escena?

Una **escena** es un conjunto de acciones que se ejecutan simultáneamente o en secuencia. Por ejemplo:

**Escena "Modo Cine":**
1. Apagar luces de la sala
2. Cerrar cortinas
3. Encender TV
4. Subir volumen al 40%

### 6.2 Crear Escenas

#### Método 1: Comando de Voz/Texto

```
SRCS> crea una escena llamada "Modo Cine" que apague las luces de la sala, cierre las cortinas y encienda la TV
```

El sistema responderá:
```
Escena "Modo Cine" creada exitosamente.
Acciones:
  1. Apagar luz: sala
  2. Cerrar cortinas: sala
  3. Encender TV: sala
```

#### Método 2: Archivo JSON

Crear archivo `~/.llm/scenes/modo_cine.json`:

```json
{
  "name": "Modo Cine",
  "description": "Configuración para ver películas",
  "actions": [
    {
      "type": "lighting_turn_off",
      "params": {
        "device_id": "hue-bulb-sala"
      }
    },
    {
      "type": "entertainment_select_source",
      "params": {
        "device_id": "tv-sala",
        "source": "HDMI1"
      }
    },
    {
      "type": "entertainment_set_volume",
      "params": {
        "device_id": "tv-sala",
        "level": 40
      }
    }
  ],
  "triggers": [],
  "conditions": []
}
```

Importar escena:
```bash
srcs --import-scene ~/.llm/scenes/modo_cine.json
```

### 6.3 Ejecutar Escenas

```
SRCS> activa la escena "Modo Cine"
```

O abreviado:
```
SRCS> modo cine
```

### 6.4 Listar Escenas

```
SRCS> muestra todas las escenas
```

Respuesta:
```
Escenas disponibles:
  1. Modo Cine - Configuración para ver películas
  2. Buenos Días - Rutina matutina
  3. Modo Noche - Configuración para dormir
```

### 6.5 Editar Escenas

```
SRCS> edita la escena "Modo Cine" para que también apague la luz del pasillo
```

### 6.6 Eliminar Escenas

```
SRCS> elimina la escena "Modo Cine"
```

### 6.7 Escenas con Triggers (Avanzado)

**Trigger de Tiempo:**

```json
{
  "name": "Buenos Días",
  "triggers": [
    {
      "type": "time",
      "params": {
        "hour": 7,
        "minute": 0,
        "days": ["mon", "tue", "wed", "thu", "fri"]
      }
    }
  ],
  "actions": [
    {
      "type": "lighting_turn_on",
      "params": {
        "device_id": "hue-bulb-dormitorio",
        "brightness": 30
      }
    },
    {
      "type": "climate_set_temperature",
      "params": {
        "zone": "dormitorio",
        "temperature": 21
      }
    }
  ]
}
```

Esta escena se ejecutará automáticamente de lunes a viernes a las 7:00 AM.

**Trigger de Evento:**

```json
{
  "name": "Llegada a Casa",
  "triggers": [
    {
      "type": "device_state_change",
      "params": {
        "device_id": "sensor-puerta-entrada",
        "state": "opened"
      }
    }
  ],
  "actions": [
    {
      "type": "lighting_turn_on",
      "params": {
        "device_id": "hue-bulb-entrada",
        "brightness": 100
      }
    },
    {
      "type": "security_disarm",
      "params": {}
    }
  ]
}
```

### 6.8 Escenas con Condiciones

```json
{
  "name": "Ahorro de Energía",
  "conditions": [
    {
      "type": "temperature_above",
      "params": {
        "zone": "sala",
        "threshold": 24
      }
    }
  ],
  "actions": [
    {
      "type": "climate_set_mode",
      "params": {
        "zone": "sala",
        "mode": "cool"
      }
    }
  ]
}
```

Esta escena solo se ejecutará si la temperatura de la sala está por encima de 24°C.

---

## 7. Configuración Avanzada

### 7.1 Personalizar el Modelo LLM

Cambiar a otro modelo de Ollama:

```json
{
  "model": "mistral",
  "llm_provider": "ollama"
}
```

Usar Claude API (requiere internet):

```json
{
  "model": "claude-3-5-sonnet-20241022",
  "llm_provider": "anthropic",
  "anthropic_api_key": "sk-ant-..."
}
```

### 7.2 Ajustar Prompts del Sistema

Editar `~/.llm/system_prompts/smart_room.txt`:

```
Eres un asistente inteligente para el control de una habitación inteligente.
Tu objetivo es interpretar comandos en lenguaje natural y ejecutar acciones
en dispositivos IoT como luces, termostatos, sistemas de seguridad y entretenimiento.

Pautas:
- Sé conciso en las respuestas
- Confirma acciones ejecutadas
- Pide aclaración si el comando es ambiguo
- Sugiere escenas si detectas patrones

Tono: Amigable, profesional, útil
```

### 7.3 Configurar Preferencias de Voz

**STT (Speech-to-Text):**

```json
{
  "stt_engine": "whisper",
  "whisper_model": "base",  // tiny, base, small, medium, large
  "whisper_language": "es"
}
```

**TTS (Text-to-Speech):**

```json
{
  "tts_enabled": true,
  "tts_engine": "piper",
  "piper_voice": "es_ES-davefx-medium",
  "tts_speed": 1.0,
  "tts_volume": 0.8
}
```

### 7.4 Configurar Memoria y Aprendizaje

```json
{
  "memory": {
    "enabled": true,
    "max_history_items": 100,
    "learn_preferences": true,
    "suggest_scenes": true
  }
}
```

Con `learn_preferences: true`, el sistema aprenderá tus patrones:
- Temperatura preferida en diferentes horas
- Nivel de brillo preferido por habitación
- Escenas frecuentemente usadas

### 7.5 Habilitar Logs Detallados

```json
{
  "logging": {
    "level": "DEBUG",
    "file": "~/.llm/logs/srcs.log",
    "max_size_mb": 10,
    "backup_count": 5
  }
}
```

Niveles disponibles: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`

### 7.6 Configurar Múltiples Ubicaciones

Para controlar múltiples habitaciones:

```json
{
  "locations": {
    "sala": {
      "devices": ["hue-bulb-sala", "tv-sala", "thermostat-sala"]
    },
    "dormitorio": {
      "devices": ["hue-bulb-dormitorio", "thermostat-dormitorio"]
    },
    "cocina": {
      "devices": ["hue-bulb-cocina"]
    }
  },
  "default_location": "sala"
}
```

Ahora puedes usar comandos como:
```
SRCS> enciende las luces del dormitorio
SRCS> apaga todo en la cocina
```

---

## 8. Solución de Problemas

### 8.1 SRCS no inicia

**Error:** `ModuleNotFoundError: No module named 'langchain'`

**Solución:**
```bash
source venv/bin/activate
pip install -e .
```

---

**Error:** `ollama: command not found`

**Solución:**
Instalar Ollama según [instrucciones oficiales](https://ollama.ai/):
```bash
# Linux
curl -fsSL https://ollama.ai/install.sh | sh

# macOS
brew install ollama
```

Verificar:
```bash
ollama --version
```

---

**Error:** `Connection refused to http://localhost:11434`

**Solución:**
Iniciar el servicio de Ollama:
```bash
ollama serve
```

En otra terminal, verificar:
```bash
curl http://localhost:11434/api/version
```

---

### 8.2 Comandos de Voz no Funcionan

**Problema:** El sistema no detecta mi voz.

**Soluciones:**
1. Verificar que el micrófono está conectado y configurado como default:
   ```bash
   # Linux
   arecord -l
   pactl list sources

   # macOS
   # System Preferences > Sound > Input
   ```

2. Probar Whisper manualmente:
   ```bash
   python -c "import whisper; model = whisper.load_model('base'); print('OK')"
   ```

3. Verificar permisos de micrófono:
   - **macOS:** System Preferences > Security & Privacy > Microphone
   - **Linux:** `sudo usermod -aG audio $USER` (logout/login después)

4. Aumentar nivel de input en configuración:
   ```json
   {
     "stt_input_device": "default",
     "stt_sample_rate": 16000,
     "stt_channels": 1
   }
   ```

---

### 8.3 Dispositivo IoT no Responde

**Problema:** "Error: No se pudo conectar con el dispositivo hue-bulb-sala"

**Checklist:**
- [ ] ¿Está el dispositivo encendido y conectado a WiFi?
- [ ] ¿Está tu PC en la misma red que el dispositivo?
- [ ] ¿Son correctas las credenciales en `config.json`?
- [ ] ¿Puede el sistema hacer ping al dispositivo?

**Diagnóstico:**

1. Verificar conectividad:
   ```bash
   ping 192.168.1.100  # IP del Hue Bridge
   ```

2. Probar API manualmente:
   ```bash
   curl http://192.168.1.100/api/YOUR_USERNAME/lights
   ```

3. Ver logs de SRCS:
   ```bash
   tail -f ~/.llm/logs/srcs.log
   ```

4. Reiniciar servidor MCP:
   ```
   SRCS> reinicia el servidor lighting
   ```

---

### 8.4 Latencia Alta (> 5 segundos)

**Problema:** Los comandos tardan mucho en ejecutarse.

**Soluciones:**

1. Usar modelo LLM más pequeño:
   ```json
   {
     "model": "llama3.1:7b"  // en vez de llama3.1:70b
   }
   ```

2. Habilitar caché de respuestas:
   ```json
   {
     "cache_llm_responses": true,
     "cache_ttl_seconds": 3600
   }
   ```

3. Optimizar prompts (reducir contexto):
   ```json
   {
     "max_history_context": 5  // solo últimos 5 comandos
   }
   ```

4. Usar GPU para inferencia (si disponible):
   ```bash
   # Instalar CUDA/ROCm según tu GPU
   # Ollama detectará GPU automáticamente
   ```

5. Verificar uso de CPU/RAM:
   ```bash
   htop  # o top
   ```

   Si RAM está al límite, considerar:
   - Cerrar aplicaciones
   - Usar modelo más pequeño
   - Aumentar swap (Linux)

---

### 8.5 Errores de Sintaxis en config.json

**Error:** `JSONDecodeError: Expecting ',' delimiter`

**Solución:**
Validar JSON online: https://jsonlint.com/

Errores comunes:
- Coma faltante entre elementos
- Coma extra al final de lista/objeto
- Comillas dobles (`"`) en vez de simples (`'`) para strings
- Comentarios (`//`) no permitidos en JSON estándar

**Formato correcto:**
```json
{
  "model": "llama3.1",
  "mcp_servers": {
    "lighting": {
      "command": "uvx",
      "args": ["mcp-server-lighting"]
    }
  }
}
```

---

### 8.6 Base de Datos Corrupta

**Error:** `sqlite3.DatabaseError: database disk image is malformed`

**Solución:**

1. Hacer backup de BD actual:
   ```bash
   cp ~/.llm/smart_room.db ~/.llm/smart_room.db.backup
   ```

2. Intentar reparar:
   ```bash
   sqlite3 ~/.llm/smart_room.db "PRAGMA integrity_check;"
   ```

3. Si no se puede reparar, re-crear BD:
   ```bash
   rm ~/.llm/smart_room.db
   srcs --init-db
   ```

4. Re-registrar dispositivos y escenas (usar backups JSON si existen).

---

### 8.7 MCP Server No Se Descubre

**Problema:** "Warning: MCP server 'lighting' no disponible"

**Diagnóstico:**

1. Verificar configuración:
   ```bash
   cat ~/.llm/config.json | grep -A 5 mcp_servers
   ```

2. Probar servidor manualmente:
   ```bash
   uvx mcp-server-lighting
   ```

   Debería mostrar:
   ```
   MCP Server 'lighting' listening on stdio...
   ```

3. Verificar que `uvx` está instalado:
   ```bash
   pip install uvx
   ```

4. Ver logs de McpToolkit:
   ```
   SRCS> modo debug
   SRCS> lista servidores mcp
   ```

---

## 9. Preguntas Frecuentes

### 9.1 General

**P: ¿SRCS envía datos a la nube?**
R: No, si usas Ollama con modelos locales (Llama, Mistral). Toda la inferencia se hace en tu PC. Solo se accede a internet para controlar dispositivos cloud-based como Nest (si los usas).

**P: ¿Puedo usar SRCS sin dispositivos IoT?**
R: Sí, con simuladores. SRCS incluye un modo `--mock-devices` para testing:
```bash
srcs --mock-devices
```

**P: ¿Cuánto consume de RAM Llama 3.1?**
R:
- Llama 3.1 7B: ~4-6 GB RAM
- Llama 3.1 13B: ~8-12 GB RAM
- Llama 3.1 70B: ~40+ GB RAM (requiere GPU)

**P: ¿Puedo usar SRCS en Raspberry Pi?**
R: Parcialmente. Raspberry Pi 4 (8GB) puede ejecutar modelos pequeños (Llama 3.1 7B quantized). Para mejor experiencia, usar Pi 5 o PC dedicado.

### 9.2 Dispositivos

**P: ¿Cómo agrego soporte para marca X de bombillos?**
R: Ver guía de desarrollo de conectores en `docs/tech-specs/IoT-Connectors-Spec.md`. En resumen:
1. Implementar `BaseConnector` interface
2. Crear `XYZ_connector.py`
3. Registrar en `config.json`

**P: ¿Puedo controlar dispositivos Zigbee/Z-Wave?**
R: Sí, mediante un hub compatible (Home Assistant, Zigbee2MQTT). SRCS se conecta al hub vía API.

**P: ¿Funcionan dispositivos de Alexa/Google Home?**
R: No directamente. Se requiere integración con sus APIs (fuera del alcance de v1.0).

### 9.3 Seguridad

**P: ¿Es seguro guardar credenciales en config.json?**
R: Para uso personal en red local, sí. Para producción, considera:
- Cifrar `config.json` con `ansible-vault` o similar
- Usar variables de entorno en vez de archivo JSON
- Restringir permisos: `chmod 600 ~/.llm/config.json`

**P: ¿SRCS tiene autenticación de usuario?**
R: En v1.0, no (asume uso personal). Para múltiples usuarios, ver `docs/01-SRS-Especificacion-Requisitos.md` (RF-029).

### 9.4 Rendimiento

**P: ¿Por qué el primer comando es lento (~10s)?**
R: El modelo LLM se carga en memoria en el primer comando. Comandos subsecuentes serán rápidos (< 2s). Para acelerar, usar:
```bash
ollama run llama3.1  # pre-cargar modelo
```

**P: ¿Cómo acelerar respuestas?**
R: Ver sección [8.4 Latencia Alta](#84-latencia-alta--5-segundos).

### 9.5 Desarrollo

**P: ¿Cómo contribuir al proyecto?**
R: Ver `CONTRIBUTING.md` en el repositorio. Proceso:
1. Fork del repo
2. Crear branch: `git checkout -b feature/mi-funcionalidad`
3. Desarrollar + tests
4. Pull request a `main`

**P: ¿Dónde reportar bugs?**
R: GitHub Issues: https://github.com/YOUR_USERNAME/smart-room-mcp/issues

---

## Apéndices

### Apéndice A: Referencia de Comandos

**Comandos del Sistema:**
```
ayuda                  - Muestra esta ayuda
versión                - Muestra versión de SRCS
salir / exit           - Cierra SRCS
limpiar                - Limpia historial de conversación
modo debug             - Activa modo de depuración
```

**Comandos de Dispositivos:**
```
lista dispositivos               - Muestra todos los dispositivos
registra dispositivo ...         - Registra nuevo dispositivo
elimina dispositivo <id>         - Elimina dispositivo
estado del dispositivo <id>      - Muestra estado de un dispositivo
```

**Comandos de Escenas:**
```
lista escenas                    - Muestra todas las escenas
crea escena ...                  - Crea nueva escena
activa escena <nombre>           - Ejecuta escena
elimina escena <nombre>          - Elimina escena
```

**Comandos MCP:**
```
lista servidores                 - Muestra servidores MCP conectados
reinicia servidor <nombre>       - Reinicia un servidor MCP
tools del servidor <nombre>      - Lista tools disponibles de un servidor
```

### Apéndice B: Ejemplos de Escenas

**Escena "Modo Lectura":**
```json
{
  "name": "Modo Lectura",
  "actions": [
    {"type": "lighting_turn_on", "params": {"device_id": "hue-bulb-sala", "brightness": 100, "color": "warm_white"}},
    {"type": "entertainment_pause", "params": {"device_id": "tv-sala"}},
    {"type": "climate_set_temperature", "params": {"zone": "sala", "temperature": 20}}
  ]
}
```

**Escena "Salir de Casa":**
```json
{
  "name": "Salir de Casa",
  "actions": [
    {"type": "lighting_turn_off", "params": {"device_id": "all"}},
    {"type": "security_arm", "params": {"mode": "away"}},
    {"type": "climate_set_mode", "params": {"zone": "all", "mode": "eco"}}
  ]
}
```

### Apéndice C: Recursos Adicionales

**Documentación Oficial:**
- Model Context Protocol: https://modelcontextprotocol.io/
- LangChain Docs: https://python.langchain.com/
- Ollama: https://ollama.ai/

**APIs de Dispositivos:**
- Philips Hue: https://developers.meethue.com/
- Nest: https://developers.google.com/nest/device-access
- ONVIF (cámaras): https://www.onvif.org/

**Comunidad:**
- GitHub Discussions: https://github.com/YOUR_USERNAME/smart-room-mcp/discussions
- Discord (si existe): [Enlace]

---

## Licencia

Este manual es parte del proyecto Smart Room Control System (SRCS), desarrollado como Trabajo de Graduación en la Universidad Tecnológica de Panamá.

**Autores:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC
**Año:** 2025

---

**Última actualización:** Octubre 2025
**Versión del Manual:** 1.0
**Versión de SRCS:** 1.0.0
