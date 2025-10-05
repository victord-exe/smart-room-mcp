# APIs e Interfaces
## Smart Room Control System (SRCS)

**Universidad Tecnológica de Panamá**
**Facultad de Ingeniería de Sistemas Computacionales**

**Autores:** Alejandro Mosquera, Victor Rodríguez
**Versión:** 1.0
**Fecha:** Octubre 2025

---

## Tabla de Contenido

1. [Introducción](#1-introducción)
2. [APIs Existentes de mcp-client (Base)](#2-apis-existentes-de-mcp-client-base)
3. [API REST del Coordinador (Opcional)](#3-api-rest-del-coordinador-opcional)
4. [Herramientas MCP - Especificación Detallada](#4-herramientas-mcp---especificación-detallada)
5. [Interfaces de Conectores IoT](#5-interfaces-de-conectores-iot)
6. [Interfaz de Voz](#6-interfaz-de-voz)
7. [Especificación OpenAPI](#7-especificación-openapi)

---

## 1. Introducción

Este documento especifica todas las **interfaces y APIs** del Smart Room Control System (SRCS), incluyendo:

- API REST opcional para control programático del sistema
- Herramientas MCP (tools) de cada servidor especializado
- Interfaces de conectores IoT
- Interfaz de procesamiento de voz (STT/TTS)
- Especificación OpenAPI completa

### 1.1 Propósito

- Documentar todas las interfaces públicas del sistema
- Facilitar la integración de nuevos componentes
- Proveer referencia para desarrollo de extensiones
- Especificar contratos de comunicación entre componentes

### 1.2 Audiencia

- Desarrolladores del sistema SRCS
- Integradores de dispositivos IoT
- Creadores de servidores MCP personalizados
- Evaluadores académicos

### 1.3 Convenciones

- **Endpoints REST**: Notación HTTP (GET, POST, PUT, DELETE)
- **Herramientas MCP**: JSON-RPC 2.0 sobre stdio
- **Tipos de datos**: JSON Schema Draft 7
- **Códigos de error**: HTTP status codes + códigos personalizados MCP

---

## 2. APIs Existentes de mcp-client (Base)

### 2.1 Introducción

Como se documenta en [00-ADR-Base-Tecnologica.md](./00-ADR-Base-Tecnologica.md#adr-001-uso-de-mcp-client-cli-como-base-del-proyecto), SRCS hereda varias APIs y componentes de **mcp-client-cli**. Esta sección documenta las **interfaces existentes** que SRCS reutiliza sin modificación o con extensiones mínimas.

**Componentes Base con APIs:**
1. **McpToolkit** - API para integración de servidores MCP
2. **SqliteStore** - API de almacenamiento key-value con vectores
3. **AppConfig** - API de configuración del sistema
4. **Tools del Agente** - Herramientas LangChain integradas

---

### 2.2 API de McpToolkit (Cliente MCP)

**Módulo**: `tool.py`
**Clase**: `McpToolkit`
**Propósito**: Toolkit de LangChain para integrar servidores MCP con el agente LLM

#### Métodos Principales

```python
class McpToolkit(BaseToolkit):
    """Toolkit para integrar servidores MCP como LangChain tools."""

    def __init__(
        self,
        name: str,
        server_param: StdioServerParameters,
        exclude_tools: list[str] = []
    ):
        """Inicializa el toolkit con configuración de servidor MCP.

        Args:
            name: Nombre identificador del servidor
            server_param: Parámetros de conexión stdio (command, args, env)
            exclude_tools: Lista de nombres de tools a excluir
        """
        pass

    async def initialize(self, force_refresh: bool = False) -> None:
        """Inicializa conexión con servidor MCP y descubre tools.

        Args:
            force_refresh: Si True, ignora cache y redescubre tools

        Effects:
            - Conecta al servidor MCP via stdio
            - Lista tools disponibles (MCP list_tools)
            - Crea LangChain BaseTool para cada tool
            - Guarda tools en cache (24h TTL)
        """
        pass

    def get_tools(self) -> List[BaseTool]:
        """Retorna lista de LangChain tools descubiertos.

        Returns:
            Lista de BaseTool listos para uso en agente
        """
        pass

    async def close(self) -> None:
        """Cierra conexión con servidor MCP y libera recursos."""
        pass
```

**Uso en SRCS:**
```python
# Configurar servidor MCP IoT
toolkit = McpToolkit(
    name="lighting",
    server_param=StdioServerParameters(
        command="python",
        args=["-m", "mcp_lighting_server"],
        env={"LOG_LEVEL": "INFO"}
    ),
    exclude_tools=[]
)

# Inicializar y obtener tools
await toolkit.initialize()
tools = toolkit.get_tools()  # Lista de LangChain BaseTool

# Usar con agente LangGraph
agent = create_react_agent(llm, tools)
```

**SRCS Extiende**: Sin cambios en API, solo se agregan nuevos servidores MCP (lighting, climate, security, entertainment)

---

### 2.3 API de SqliteStore (Memoria Persistente)

**Módulo**: `memory.py`
**Clase**: `SqliteStore`
**Propósito**: Almacenamiento key-value con namespaces y búsqueda semántica vectorial

#### Métodos Principales (BaseStore Interface)

```python
class SqliteStore(BaseStore):
    """SQLite-based store with vector search."""

    def __init__(
        self,
        db_path: Union[str, Path],
        *,
        index: Optional[IndexConfig] = None
    ):
        """Inicializa store con path a DB y config de índice vectorial.

        Args:
            db_path: Ruta a archivo SQLite
            index: Configuración opcional para embeddings (campos, modelo)
        """
        pass

    async def aput(
        self,
        namespace: Tuple[str, ...],
        key: str,
        value: Dict[str, Any],
        index: Optional[Union[bool, List[str]]] = None
    ) -> None:
        """Guarda item en el store.

        Args:
            namespace: Namespace jerárquico (ej: ("memories", "user123"))
            key: Clave única en el namespace
            value: Valor JSON-serializable
            index: Campos a indexar para búsqueda vectorial
        """
        pass

    async def aget(
        self,
        namespace: Tuple[str, ...],
        key: str
    ) -> Optional[Item]:
        """Recupera item del store.

        Returns:
            Item con value, created_at, updated_at, o None si no existe
        """
        pass

    async def asearch(
        self,
        namespace_prefix: Tuple[str, ...],
        *,
        filter: Optional[Dict[str, Any]] = None,
        query: Optional[str] = None,
        limit: int = 10,
        offset: int = 0
    ) -> List[SearchItem]:
        """Busca items con filtro opcional y búsqueda semántica.

        Args:
            namespace_prefix: Prefijo de namespace (ej: ("memories",))
            filter: Filtro JSON sobre campos del value
            query: Texto para búsqueda semántica (si index configurado)
            limit/offset: Paginación

        Returns:
            Lista de SearchItem con score de similaridad (si query)
        """
        pass
```

**Tools Expuestos al Agente:**

```python
@tool
async def save_memory(
    memories: List[str],
    *,
    config: RunnableConfig,
    store: Annotated[BaseStore, InjectedStore()]
) -> str:
    """Tool del agente para guardar memorias de usuario.

    Args:
        memories: Lista de strings a recordar
        config: Config con user_id
        store: SqliteStore inyectado automáticamente

    Returns:
        Confirmación de memorias guardadas
    """
    pass
```

**Uso en SRCS:**
```python
# Inicializar store
store = SqliteStore(
    db_path="database/smart_room.db",
    index=IndexConfig(fields=["$"], embed=OpenAIEmbeddings())
)

# Guardar preferencia Smart Room
await store.aput(
    namespace=("smart_room_prefs", "user123"),
    key="evening_temperature",
    value={"temp": 22, "time": "18:00-22:00", "confidence": 0.9}
)

# Buscar preferencias
prefs = await store.asearch(
    namespace_prefix=("smart_room_prefs", "user123"),
    query="temperatura preferida tarde"
)
```

**SRCS Extiende**: Usa nuevos namespaces `smart_room_prefs`, `smart_room_scenes` sin modificar API

---

### 2.4 API de AppConfig (Configuración)

**Módulo**: `config.py`
**Clases**: `LLMConfig`, `ServerConfig`, `AppConfig`
**Propósito**: Gestión de configuración del sistema desde JSON con comentarios

#### Estructura de Clases

```python
class LLMConfig(BaseModel):
    """Configuración del proveedor LLM."""
    provider: str  # "openai", "anthropic", "ollama", etc.
    model: str
    api_key: Optional[str] = None
    base_url: Optional[str] = None
    temperature: float = 0.7
    max_tokens: int = 1000

class ServerConfig(BaseModel):
    """Configuración de un servidor MCP."""
    command: str
    args: List[str]
    env: Dict[str, str] = {}
    enabled: bool = True
    exclude_tools: List[str] = []
    requires_confirmation: List[str] = []

class AppConfig(BaseModel):
    """Configuración principal de la aplicación."""
    systemPrompt: str
    llm: LLMConfig
    mcpServers: Dict[str, ServerConfig]

    @classmethod
    def load(cls, path: Optional[str] = None) -> "AppConfig":
        """Carga config desde JSON (con soporte de comentarios).

        Args:
            path: Ruta al config.json, o None para usar default (~/.llm/config.json)

        Returns:
            AppConfig validado con Pydantic

        Raises:
            FileNotFoundError: Si config no existe
            ValidationError: Si config inválido
        """
        pass
```

**Uso en SRCS:**
```python
# Cargar config (automático en startup)
config = AppConfig.load()

# Acceder a configuración LLM
llm = init_chat_model(
    model=config.llm.model,
    model_provider=config.llm.provider,
    temperature=config.llm.temperature
)

# Acceder a servidores MCP configurados
for name, server_config in config.mcpServers.items():
    if server_config.enabled:
        toolkit = McpToolkit(name=name, server_param=server_config)
        # ...
```

**SRCS Extiende**: Agrega campos opcionales `voice`, `web`, `logging` al AppConfig

---

### 2.5 Herramientas del Agente (LangChain Tools)

**Módulo**: Integrado en `cli.py` y `memory.py`
**Propósito**: Tools nativos disponibles para el agente LLM

#### Tool: save_memory

```python
@tool
async def save_memory(
    memories: List[str],
    *,
    config: RunnableConfig,
    store: Annotated[BaseStore, InjectedStore()]
) -> str:
    """Guarda memorias para el usuario actual.

    El agente LLM usa este tool cuando el usuario expresa preferencias
    o información importante que debe recordarse.

    Args:
        memories: Lista de hechos/preferencias a guardar

    Returns:
        Confirmación con número de memorias guardadas

    Example:
        User: "Me gusta que la temperatura esté a 22 grados por las tardes"
        Agent: <usa save_memory(["Usuario prefiere 22°C en tardes"])>
    """
    user_id = config.get("configurable", {}).get("user_id")
    namespace = ("memories", user_id)
    for memory in memories:
        id = uuid.uuid4().hex
        await store.aput(namespace, f"memory_{id}", {"data": memory})
    return f"Saved memories: {memories}"
```

**Uso Interno en Agente:**
```python
# El agente LLM decide automáticamente usar el tool
agent_state = {
    "messages": [HumanMessage(content="Me gusta 22 grados")],
    "memories": await get_memories(store, user_id)
}

result = await agent.ainvoke(agent_state, config={"user_id": "myself"})
# Agent internamente llama save_memory si detecta preferencia
```

**SRCS Extiende**: Sin cambios, se usa tal cual

---

### 2.6 Resumen de APIs Heredadas

| API/Componente | Módulo | Modificación en SRCS | Uso en SRCS |
|----------------|--------|----------------------|-------------|
| `McpToolkit` | tool.py | ✅ Sin cambios | Integrar servidores MCP IoT |
| `SqliteStore` | memory.py | ➕ Nuevos namespaces | Guardar preferencias/escenas |
| `AppConfig` | config.py | ➕ Campos opcionales | Config unificada |
| `save_memory` tool | memory.py | ✅ Sin cambios | Aprendizaje de preferencias |
| `AsyncSqliteSaver` | LangGraph | ✅ Sin cambios | Checkpoints del agente |

**Total de APIs reutilizadas**: 5 componentes principales

**Beneficio**: ~60% del código de integración LLM↔MCP ya implementado

---

## 3. API REST del Coordinador (Opcional)

### 3.1 Introducción

La API REST es **opcional** y proporciona acceso programático al sistema para:
- Interfaces web de administración
- Integraciones externas
- Aplicaciones móviles futuras

**Base URL**: `http://localhost:8080/api/v1`

**Autenticación**: API Key en header `X-API-Key` (para versión futura)

---

### 2.2 Endpoints

#### 2.2.1 POST /llm/prompt

**Descripción**: Envía un comando en texto al LLM Agent para procesamiento.

**Request**:
```http
POST /api/v1/llm/prompt
Content-Type: application/json

{
  "prompt": "Enciende las luces de la sala",
  "user_id": 1,
  "context": {
    "session_id": "abc123",
    "previous_messages": []
  }
}
```

**Response (200 OK)**:
```json
{
  "response": "He encendido las luces de la sala",
  "actions_executed": [
    {
      "tool": "lighting_turn_on",
      "device_id": "luz_sala",
      "result": "success"
    }
  ],
  "latency_ms": 450
}
```

**Response (400 Bad Request)**:
```json
{
  "error": "Invalid request",
  "message": "Prompt is required"
}
```

**Response (500 Internal Server Error)**:
```json
{
  "error": "LLM error",
  "message": "Ollama service is not available"
}
```

---

#### 2.2.2 GET /mcp/servers

**Descripción**: Lista todos los servidores MCP configurados.

**Request**:
```http
GET /api/v1/mcp/servers
```

**Response (200 OK)**:
```json
{
  "servers": [
    {
      "id": 1,
      "name": "lighting",
      "status": "running",
      "tools_count": 5,
      "enabled": true
    },
    {
      "id": 2,
      "name": "climate",
      "status": "running",
      "tools_count": 4,
      "enabled": true
    },
    {
      "id": 3,
      "name": "security",
      "status": "error",
      "tools_count": 0,
      "enabled": true,
      "error_message": "Connection timeout"
    }
  ]
}
```

---

#### 2.2.3 GET /mcp/servers/{name}/tools

**Descripción**: Obtiene las herramientas disponibles de un servidor MCP específico.

**Request**:
```http
GET /api/v1/mcp/servers/lighting/tools
```

**Response (200 OK)**:
```json
{
  "server": "lighting",
  "tools": [
    {
      "name": "lighting_turn_on",
      "description": "Turn on a light device",
      "input_schema": {
        "type": "object",
        "properties": {
          "device_id": {"type": "string"},
          "brightness": {"type": "integer", "minimum": 0, "maximum": 100},
          "color": {"type": "string"}
        },
        "required": ["device_id"]
      }
    },
    {
      "name": "lighting_turn_off",
      "description": "Turn off a light device",
      "input_schema": {
        "type": "object",
        "properties": {
          "device_id": {"type": "string"}
        },
        "required": ["device_id"]
      }
    }
  ]
}
```

---

#### 2.2.4 GET /devices

**Descripción**: Lista todos los dispositivos IoT registrados.

**Query Parameters**:
- `type` (opcional): Filtrar por tipo de dispositivo (light, thermostat, camera, etc.)
- `enabled` (opcional): Filtrar por estado (true/false)

**Request**:
```http
GET /api/v1/devices?type=light&enabled=true
```

**Response (200 OK)**:
```json
{
  "devices": [
    {
      "id": 1,
      "name": "Luz Sala Principal",
      "type": "light",
      "server_mcp": "lighting",
      "enabled": true,
      "state": {
        "power": "on",
        "brightness": 75,
        "color": "warm"
      },
      "last_updated": "2025-01-15T10:30:00Z"
    },
    {
      "id": 2,
      "name": "Luz Escritorio",
      "type": "light",
      "server_mcp": "lighting",
      "enabled": true,
      "state": {
        "power": "off"
      },
      "last_updated": "2025-01-15T09:15:00Z"
    }
  ],
  "total": 2
}
```

---

#### 2.2.5 POST /devices/{id}/control

**Descripción**: Envía un comando directo a un dispositivo específico.

**Request**:
```http
POST /api/v1/devices/1/control
Content-Type: application/json

{
  "action": "set_brightness",
  "parameters": {
    "brightness": 50
  }
}
```

**Response (200 OK)**:
```json
{
  "device_id": 1,
  "action": "set_brightness",
  "result": "success",
  "new_state": {
    "power": "on",
    "brightness": 50,
    "color": "warm"
  },
  "latency_ms": 120
}
```

**Response (404 Not Found)**:
```json
{
  "error": "Device not found",
  "message": "Device with ID 1 does not exist"
}
```

**Response (503 Service Unavailable)**:
```json
{
  "error": "Device offline",
  "message": "Cannot connect to device"
}
```

---

#### 2.2.6 GET /scenes

**Descripción**: Lista todas las escenas disponibles.

**Query Parameters**:
- `user_id` (opcional): Filtrar por usuario propietario
- `system` (opcional): Si es `true`, solo muestra escenas del sistema

**Request**:
```http
GET /api/v1/scenes?user_id=1
```

**Response (200 OK)**:
```json
{
  "scenes": [
    {
      "id": 1,
      "name": "Modo Cine",
      "user_id": null,
      "is_system": true,
      "description": "Escena para ver películas",
      "devices_count": 4
    },
    {
      "id": 5,
      "name": "Modo Estudio",
      "user_id": 1,
      "is_system": false,
      "description": "Luces brillantes para estudiar",
      "devices_count": 2
    }
  ],
  "total": 2
}
```

---

#### 2.2.7 POST /scenes/{id}/activate

**Descripción**: Activa una escena predefinida.

**Request**:
```http
POST /api/v1/scenes/1/activate
```

**Response (200 OK)**:
```json
{
  "scene_id": 1,
  "scene_name": "Modo Cine",
  "result": "success",
  "actions_executed": [
    {
      "device": "Luz Sala Principal",
      "action": "set_brightness",
      "result": "success"
    },
    {
      "device": "Termostato Sala",
      "action": "set_temperature",
      "result": "success"
    },
    {
      "device": "Proyector",
      "action": "turn_on",
      "result": "success"
    }
  ],
  "total_latency_ms": 850
}
```

**Response (207 Multi-Status)** (activación parcial):
```json
{
  "scene_id": 1,
  "scene_name": "Modo Cine",
  "result": "partial",
  "actions_executed": [
    {
      "device": "Luz Sala Principal",
      "action": "set_brightness",
      "result": "success"
    },
    {
      "device": "Proyector",
      "action": "turn_on",
      "result": "error",
      "error_message": "Device offline"
    }
  ],
  "total_latency_ms": 450
}
```

---

## 4. Herramientas MCP - Especificación Detallada (Nuevas para SRCS)

### 3.1 Introducción

Las herramientas MCP (tools) son funciones que los servidores MCP exponen al LLM Agent mediante el protocolo MCP. El LLM las invoca para ejecutar acciones en dispositivos IoT.

**Protocolo**: JSON-RPC 2.0 sobre stdio (stdin/stdout)

**Formato de Mensaje MCP**:
```json
{
  "jsonrpc": "2.0",
  "id": "unique_request_id",
  "method": "tools/call",
  "params": {
    "name": "tool_name",
    "arguments": {
      "param1": "value1"
    }
  }
}
```

---

### 3.2 MCP Lighting Server

**Descripción**: Controla dispositivos de iluminación.

**Servidor**: `mcp_lighting_server`

**Comando**: `python -m mcp_lighting_server`

---

#### Tool: lighting_turn_on

**Descripción**: Enciende un dispositivo de iluminación.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string",
      "description": "ID or name of the light device"
    },
    "brightness": {
      "type": "integer",
      "minimum": 0,
      "maximum": 100,
      "description": "Brightness level (0-100%). Optional, default: 100"
    },
    "color": {
      "type": "string",
      "enum": ["white", "warm", "cool", "red", "green", "blue", "yellow"],
      "description": "Color of the light. Optional, default: current color"
    },
    "transition_time": {
      "type": "integer",
      "minimum": 0,
      "description": "Transition time in milliseconds. Optional, default: 1000"
    }
  },
  "required": ["device_id"]
}
```

**Output Schema**:
```json
{
  "type": "object",
  "properties": {
    "result": {
      "type": "string",
      "enum": ["success", "error"]
    },
    "device_id": {
      "type": "string"
    },
    "new_state": {
      "type": "object",
      "properties": {
        "power": {"type": "string", "enum": ["on", "off"]},
        "brightness": {"type": "integer"},
        "color": {"type": "string"}
      }
    },
    "error_message": {
      "type": "string",
      "description": "Present only if result is error"
    }
  }
}
```

**Ejemplo de Invocación**:
```json
{
  "jsonrpc": "2.0",
  "id": "req_001",
  "method": "tools/call",
  "params": {
    "name": "lighting_turn_on",
    "arguments": {
      "device_id": "luz_sala",
      "brightness": 75,
      "color": "warm"
    }
  }
}
```

**Ejemplo de Respuesta Exitosa**:
```json
{
  "jsonrpc": "2.0",
  "id": "req_001",
  "result": {
    "content": [
      {
        "type": "text",
        "text": "{\"result\":\"success\",\"device_id\":\"luz_sala\",\"new_state\":{\"power\":\"on\",\"brightness\":75,\"color\":\"warm\"}}"
      }
    ]
  }
}
```

**Códigos de Error**:
- `DEVICE_NOT_FOUND`: El dispositivo no existe
- `DEVICE_OFFLINE`: El dispositivo no responde
- `INVALID_BRIGHTNESS`: Valor de brillo fuera de rango
- `INVALID_COLOR`: Color no soportado

---

#### Tool: lighting_turn_off

**Descripción**: Apaga un dispositivo de iluminación.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string",
      "description": "ID or name of the light device"
    },
    "transition_time": {
      "type": "integer",
      "minimum": 0,
      "description": "Transition time in milliseconds. Optional, default: 1000"
    }
  },
  "required": ["device_id"]
}
```

**Output Schema**: Similar a `lighting_turn_on`

---

#### Tool: lighting_set_brightness

**Descripción**: Ajusta el brillo de un dispositivo de iluminación.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string",
      "description": "ID or name of the light device"
    },
    "level": {
      "type": "integer",
      "minimum": 0,
      "maximum": 100,
      "description": "Brightness level (0-100%)"
    },
    "transition_time": {
      "type": "integer",
      "minimum": 0,
      "description": "Transition time in milliseconds. Optional, default: 1000"
    }
  },
  "required": ["device_id", "level"]
}
```

---

#### Tool: lighting_set_color

**Descripción**: Cambia el color de un dispositivo de iluminación.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string",
      "description": "ID or name of the light device"
    },
    "color": {
      "type": "string",
      "enum": ["white", "warm", "cool", "red", "green", "blue", "yellow", "purple", "orange"],
      "description": "Color to set"
    },
    "transition_time": {
      "type": "integer",
      "minimum": 0,
      "description": "Transition time in milliseconds. Optional, default: 1000"
    }
  },
  "required": ["device_id", "color"]
}
```

---

#### Tool: lighting_get_status

**Descripción**: Obtiene el estado actual de dispositivos de iluminación.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string",
      "description": "ID or name of the light device. If not provided, returns status of all lights"
    }
  }
}
```

**Output Schema**:
```json
{
  "type": "object",
  "properties": {
    "devices": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "device_id": {"type": "string"},
          "name": {"type": "string"},
          "state": {
            "type": "object",
            "properties": {
              "power": {"type": "string", "enum": ["on", "off"]},
              "brightness": {"type": "integer"},
              "color": {"type": "string"}
            }
          },
          "online": {"type": "boolean"}
        }
      }
    }
  }
}
```

---

### 3.3 MCP Climate Server

**Descripción**: Controla dispositivos de climatización (termostatos).

**Servidor**: `mcp_climate_server`

**Comando**: `python -m mcp_climate_server`

---

#### Tool: climate_set_temperature

**Descripción**: Ajusta la temperatura objetivo de un termostato.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "zone": {
      "type": "string",
      "description": "Zone name (e.g., 'sala', 'bedroom'). Default: 'default'"
    },
    "temperature": {
      "type": "number",
      "minimum": 16,
      "maximum": 30,
      "description": "Target temperature in Celsius"
    }
  },
  "required": ["temperature"]
}
```

**Output Schema**:
```json
{
  "type": "object",
  "properties": {
    "result": {
      "type": "string",
      "enum": ["success", "error"]
    },
    "zone": {"type": "string"},
    "current_temperature": {"type": "number"},
    "target_temperature": {"type": "number"},
    "mode": {"type": "string"},
    "error_message": {"type": "string"}
  }
}
```

**Códigos de Error**:
- `TEMPERATURE_OUT_OF_RANGE`: Temperatura fuera del rango seguro (16-30°C)
- `THERMOSTAT_OFFLINE`: Termostato no responde
- `ZONE_NOT_FOUND`: Zona no existe

---

#### Tool: climate_set_mode

**Descripción**: Cambia el modo de operación del termostato.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "zone": {
      "type": "string",
      "description": "Zone name. Default: 'default'"
    },
    "mode": {
      "type": "string",
      "enum": ["heat", "cool", "auto", "fan", "off"],
      "description": "Operating mode"
    }
  },
  "required": ["mode"]
}
```

---

#### Tool: climate_get_current_temperature

**Descripción**: Obtiene la temperatura actual de una zona.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "zone": {
      "type": "string",
      "description": "Zone name. If not provided, returns all zones"
    }
  }
}
```

**Output Schema**:
```json
{
  "type": "object",
  "properties": {
    "zones": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "zone": {"type": "string"},
          "current_temperature": {"type": "number"},
          "target_temperature": {"type": "number"},
          "mode": {"type": "string"},
          "online": {"type": "boolean"}
        }
      }
    }
  }
}
```

---

#### Tool: climate_get_status

**Descripción**: Obtiene el estado completo del sistema de climatización.

Similar a `climate_get_current_temperature` pero incluye información adicional como humedad, estado del ventilador, etc.

---

### 3.4 MCP Security Server

**Descripción**: Controla dispositivos de seguridad (alarmas, cámaras).

**Servidor**: `mcp_security_server`

**Comando**: `python -m mcp_security_server`

---

#### Tool: security_arm

**Descripción**: Arma el sistema de alarma.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "mode": {
      "type": "string",
      "enum": ["away", "home", "night"],
      "description": "Arming mode"
    },
    "pin": {
      "type": "string",
      "pattern": "^[0-9]{4,6}$",
      "description": "Security PIN (required for authentication)"
    }
  },
  "required": ["mode", "pin"]
}
```

**Output Schema**:
```json
{
  "type": "object",
  "properties": {
    "result": {
      "type": "string",
      "enum": ["success", "error"]
    },
    "armed": {"type": "boolean"},
    "mode": {"type": "string"},
    "error_message": {"type": "string"}
  }
}
```

**Códigos de Error**:
- `INVALID_PIN`: PIN incorrecto
- `ALREADY_ARMED`: Sistema ya está armado
- `SENSOR_OPEN`: Hay sensores abiertos que impiden armar

---

#### Tool: security_disarm

**Descripción**: Desarma el sistema de alarma.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "pin": {
      "type": "string",
      "pattern": "^[0-9]{4,6}$",
      "description": "Security PIN (required for authentication)"
    }
  },
  "required": ["pin"]
}
```

---

#### Tool: security_get_status

**Descripción**: Obtiene el estado del sistema de seguridad.

**Input Schema**: Vacío `{}`

**Output Schema**:
```json
{
  "type": "object",
  "properties": {
    "armed": {"type": "boolean"},
    "mode": {"type": "string"},
    "sensors": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "sensor_id": {"type": "string"},
          "name": {"type": "string"},
          "type": {"type": "string"},
          "state": {"type": "string", "enum": ["open", "closed", "motion", "clear"]},
          "battery": {"type": "integer"}
        }
      }
    },
    "last_event": {
      "type": "object",
      "properties": {
        "timestamp": {"type": "string"},
        "type": {"type": "string"},
        "sensor": {"type": "string"}
      }
    }
  }
}
```

---

#### Tool: security_get_camera_feed

**Descripción**: Obtiene snapshot o URL de stream de una cámara.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "camera_id": {
      "type": "string",
      "description": "Camera ID or name"
    },
    "type": {
      "type": "string",
      "enum": ["snapshot", "stream_url"],
      "description": "Type of feed to retrieve. Default: snapshot"
    }
  },
  "required": ["camera_id"]
}
```

**Output Schema**:
```json
{
  "type": "object",
  "properties": {
    "camera_id": {"type": "string"},
    "type": {"type": "string"},
    "snapshot_base64": {"type": "string", "description": "Present if type is snapshot"},
    "stream_url": {"type": "string", "description": "Present if type is stream_url"},
    "timestamp": {"type": "string"}
  }
}
```

---

### 3.5 MCP Entertainment Server

**Descripción**: Controla dispositivos de audio y video.

**Servidor**: `mcp_entertainment_server`

**Comando**: `python -m mcp_entertainment_server`

---

#### Tool: entertainment_play

**Descripción**: Reproduce contenido multimedia.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string",
      "description": "Audio/video device ID"
    }
  },
  "required": ["device_id"]
}
```

---

#### Tool: entertainment_pause

**Descripción**: Pausa la reproducción.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string",
      "description": "Audio/video device ID"
    }
  },
  "required": ["device_id"]
}
```

---

#### Tool: entertainment_set_volume

**Descripción**: Ajusta el volumen.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string",
      "description": "Audio/video device ID"
    },
    "level": {
      "type": "integer",
      "minimum": 0,
      "maximum": 100,
      "description": "Volume level (0-100%)"
    }
  },
  "required": ["device_id", "level"]
}
```

---

#### Tool: entertainment_select_source

**Descripción**: Selecciona fuente de entrada.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string",
      "description": "Audio/video device ID"
    },
    "source": {
      "type": "string",
      "enum": ["HDMI1", "HDMI2", "HDMI3", "USB", "Bluetooth", "Chromecast"],
      "description": "Input source"
    }
  },
  "required": ["device_id", "source"]
}
```

---

#### Tool: entertainment_get_status

**Descripción**: Obtiene el estado de dispositivos de entretenimiento.

**Input Schema**:
```json
{
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string",
      "description": "Audio/video device ID. If not provided, returns all devices"
    }
  }
}
```

**Output Schema**:
```json
{
  "type": "object",
  "properties": {
    "devices": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "device_id": {"type": "string"},
          "name": {"type": "string"},
          "type": {"type": "string"},
          "state": {
            "type": "object",
            "properties": {
              "power": {"type": "string"},
              "playback": {"type": "string", "enum": ["playing", "paused", "stopped"]},
              "volume": {"type": "integer"},
              "source": {"type": "string"}
            }
          },
          "online": {"type": "boolean"}
        }
      }
    }
  }
}
```

---

## 5. Interfaces de Conectores IoT

### 4.1 BaseConnector (Clase Abstracta)

**Descripción**: Clase base abstracta que todos los conectores IoT deben implementar.

**Ubicación**: `src/iot-connectors/base_connector.py`

**Interfaz Python**:

```python
from abc import ABC, abstractmethod
from typing import Dict, Any, Optional

class BaseConnector(ABC):
    """
    Base abstract class for IoT device connectors.

    All connector implementations must inherit from this class
    and implement the required abstract methods.
    """

    def __init__(self, config: Dict[str, Any]):
        """
        Initialize the connector with configuration.

        Args:
            config: Dictionary with connector-specific configuration
                   (e.g., IP address, API keys, credentials)
        """
        self.config = config
        self._connected = False

    @abstractmethod
    async def connect(self) -> bool:
        """
        Establish connection with the IoT device or service.

        Returns:
            bool: True if connection successful, False otherwise

        Raises:
            ConnectionError: If connection cannot be established
        """
        pass

    @abstractmethod
    async def disconnect(self) -> None:
        """
        Close connection with the IoT device or service.
        """
        pass

    @abstractmethod
    async def send_command(self, command: str, parameters: Dict[str, Any]) -> Dict[str, Any]:
        """
        Send a command to the IoT device.

        Args:
            command: Command name (e.g., "turn_on", "set_brightness")
            parameters: Command parameters

        Returns:
            dict: Result of the command execution with 'result' and 'data' keys

        Raises:
            DeviceOfflineError: If device is not reachable
            InvalidCommandError: If command is not supported
            CommandExecutionError: If command fails
        """
        pass

    @abstractmethod
    async def get_status(self, device_id: Optional[str] = None) -> Dict[str, Any]:
        """
        Get current status of device(s).

        Args:
            device_id: Specific device ID, or None for all devices

        Returns:
            dict: Device status information

        Raises:
            DeviceNotFoundError: If device_id is not found
        """
        pass

    @abstractmethod
    async def discover_devices(self) -> list[Dict[str, Any]]:
        """
        Discover available devices in the network.

        Returns:
            list: List of discovered devices with metadata
        """
        pass

    async def health_check(self) -> bool:
        """
        Check if the connector is healthy and can communicate with devices.

        Returns:
            bool: True if healthy, False otherwise
        """
        try:
            if not self._connected:
                await self.connect()
            # Attempt to get status as health check
            await self.get_status()
            return True
        except Exception:
            return False

    @property
    def is_connected(self) -> bool:
        """Check if connector is currently connected."""
        return self._connected
```

---

### 4.2 Philips Hue Connector

**Descripción**: Conector para dispositivos Philips Hue.

**Protocolo**: API REST (Philips Hue Bridge API v2)

**Ubicación**: `src/iot-connectors/philips_hue_connector.py`

**Configuración**:
```json
{
  "protocol": "philips_hue",
  "bridge_ip": "192.168.1.2",
  "api_key": "your_hue_api_key_here",
  "port": 80
}
```

**Métodos Específicos**:

```python
class PhilipsHueConnector(BaseConnector):
    """Connector for Philips Hue smart lights."""

    async def connect(self) -> bool:
        """Connect to Philips Hue Bridge."""
        # Implementation: Verify bridge is reachable and API key is valid

    async def send_command(self, command: str, parameters: Dict[str, Any]) -> Dict[str, Any]:
        """
        Send command to Hue lights.

        Supported commands:
        - turn_on: {"light_id": "1", "brightness": 100, "color": "warm"}
        - turn_off: {"light_id": "1"}
        - set_brightness: {"light_id": "1", "brightness": 50}
        - set_color: {"light_id": "1", "color": "red"}
        """
        # Implementation: Translate to Hue API calls

    async def get_status(self, device_id: Optional[str] = None) -> Dict[str, Any]:
        """Get status of Hue lights."""
        # Implementation: Query Hue Bridge API for light states

    async def discover_devices(self) -> list[Dict[str, Any]]:
        """Discover all Hue lights connected to the bridge."""
        # Implementation: Query Hue Bridge for all lights
```

**API Calls Ejemplo**:

```python
# Turn on light
POST http://192.168.1.2/api/{api_key}/lights/1/state
{
  "on": true,
  "bri": 191,  # 0-254 (convertir desde 0-100%)
  "ct": 366    # Color temperature
}

# Get light status
GET http://192.168.1.2/api/{api_key}/lights/1
```

---

### 4.3 Nest/Ecobee Connector

**Descripción**: Conector para termostatos Nest o Ecobee.

**Protocolo**: API REST (Nest API v3 o Ecobee API)

**Ubicación**: `src/iot-connectors/nest_connector.py`

**Configuración**:
```json
{
  "protocol": "nest",
  "api_key": "your_nest_api_key",
  "access_token": "your_oauth_token",
  "device_id": "nest_device_id"
}
```

**Métodos Específicos**:

```python
class NestConnector(BaseConnector):
    """Connector for Nest thermostats."""

    async def send_command(self, command: str, parameters: Dict[str, Any]) -> Dict[str, Any]:
        """
        Send command to Nest thermostat.

        Supported commands:
        - set_temperature: {"temperature": 22}
        - set_mode: {"mode": "heat"}  # heat, cool, heat-cool, off
        """
        # Implementation: Use Nest API
```

---

### 4.4 Home Assistant Connector

**Descripción**: Conector genérico para Home Assistant.

**Protocolo**: WebSocket API + REST API

**Ubicación**: `src/iot-connectors/home_assistant_connector.py`

**Configuración**:
```json
{
  "protocol": "home_assistant",
  "host": "192.168.1.5",
  "port": 8123,
  "access_token": "your_long_lived_access_token",
  "use_websocket": true
}
```

**Métodos Específicos**:

```python
class HomeAssistantConnector(BaseConnector):
    """Connector for Home Assistant hub."""

    async def connect(self) -> bool:
        """Connect to Home Assistant via WebSocket."""
        # Implementation: Establish WebSocket connection

    async def send_command(self, command: str, parameters: Dict[str, Any]) -> Dict[str, Any]:
        """
        Send command via Home Assistant service calls.

        Supported commands:
        - call_service: {"domain": "light", "service": "turn_on", "entity_id": "light.sala", "data": {}}
        """
        # Implementation: Use Home Assistant WebSocket or REST API
```

---

### 4.5 Generic Camera Connector (ONVIF)

**Descripción**: Conector genérico para cámaras IP compatibles con ONVIF.

**Protocolo**: ONVIF (Web Services)

**Ubicación**: `src/iot-connectors/onvif_camera_connector.py`

**Configuración**:
```json
{
  "protocol": "onvif",
  "camera_ip": "192.168.1.20",
  "port": 8080,
  "username": "admin",
  "password": "encrypted_password",
  "rtsp_port": 554
}
```

**Métodos Específicos**:

```python
class OnvifCameraConnector(BaseConnector):
    """Connector for ONVIF-compatible IP cameras."""

    async def send_command(self, command: str, parameters: Dict[str, Any]) -> Dict[str, Any]:
        """
        Send command to camera.

        Supported commands:
        - get_snapshot: {}
        - get_stream_url: {"profile": "main"}
        - ptz_move: {"direction": "up", "speed": 0.5}
        """
        # Implementation: Use ONVIF protocol

    async def get_status(self, device_id: Optional[str] = None) -> Dict[str, Any]:
        """Get camera status (online, recording, motion detected)."""
        # Implementation: Query ONVIF status
```

---

## 6. Interfaz de Voz

### 5.1 Speech-to-Text (Whisper)

**Descripción**: Conversión de audio a texto usando Whisper de OpenAI.

**Ubicación**: `src/ui/voice_interface.py`

**Interfaz Python**:

```python
class WhisperSTT:
    """Speech-to-Text using OpenAI Whisper."""

    def __init__(self, model_name: str = "base", language: str = "es"):
        """
        Initialize Whisper STT.

        Args:
            model_name: Whisper model size (tiny, base, small, medium, large)
            language: Language code (es, en, etc.)
        """
        self.model_name = model_name
        self.language = language
        self.model = None

    async def load_model(self) -> None:
        """Load Whisper model into memory."""
        import whisper
        self.model = whisper.load_model(self.model_name)

    async def transcribe_audio(self, audio_file_path: str) -> Dict[str, Any]:
        """
        Transcribe audio file to text.

        Args:
            audio_file_path: Path to audio file (wav, mp3, etc.)

        Returns:
            dict: {
                "text": "transcribed text",
                "language": "es",
                "confidence": 0.95
            }
        """
        if not self.model:
            await self.load_model()

        result = self.model.transcribe(
            audio_file_path,
            language=self.language
        )

        return {
            "text": result["text"],
            "language": result["language"],
            "confidence": result.get("confidence", 1.0)
        }

    async def transcribe_audio_stream(self, audio_stream: bytes) -> Dict[str, Any]:
        """
        Transcribe audio from byte stream.

        Args:
            audio_stream: Audio data in bytes

        Returns:
            dict: Transcription result
        """
        # Implementation: Save stream to temp file, then transcribe
        pass
```

**Uso Ejemplo**:

```python
stt = WhisperSTT(model_name="base", language="es")
await stt.load_model()

result = await stt.transcribe_audio("user_voice.wav")
print(result["text"])  # "Enciende las luces de la sala"
```

---

### 5.2 Text-to-Speech (Piper)

**Descripción**: Conversión de texto a voz usando Piper.

**Ubicación**: `src/ui/voice_interface.py`

**Interfaz Python**:

```python
class PiperTTS:
    """Text-to-Speech using Piper."""

    def __init__(self, model_name: str = "es_ES-mls_10246-medium", voice: str = "female"):
        """
        Initialize Piper TTS.

        Args:
            model_name: Piper model name
            voice: Voice style (female, male)
        """
        self.model_name = model_name
        self.voice = voice

    async def synthesize_speech(self, text: str, output_file: str) -> str:
        """
        Convert text to speech and save to file.

        Args:
            text: Text to synthesize
            output_file: Path to output audio file (wav)

        Returns:
            str: Path to generated audio file
        """
        # Implementation: Use Piper to generate speech
        pass

    async def synthesize_speech_stream(self, text: str) -> bytes:
        """
        Convert text to speech and return as byte stream.

        Args:
            text: Text to synthesize

        Returns:
            bytes: Audio data in WAV format
        """
        # Implementation: Generate audio to byte stream
        pass
```

**Uso Ejemplo**:

```python
tts = PiperTTS(model_name="es_ES-mls_10246-medium")

audio_file = await tts.synthesize_speech(
    "He encendido las luces de la sala",
    "response.wav"
)
# Play audio_file
```

---

## 7. Especificación OpenAPI

### 6.1 OpenAPI 3.0 Schema Completo

```yaml
openapi: 3.0.3
info:
  title: Smart Room Control System API
  description: API REST para control programático del sistema SRCS
  version: 1.0.0
  contact:
    name: Alejandro Mosquera, Victor Rodríguez
    email: srcs@utp.ac.pa

servers:
  - url: http://localhost:8080/api/v1
    description: Servidor local de desarrollo

security:
  - ApiKeyAuth: []

paths:
  /llm/prompt:
    post:
      summary: Enviar comando al LLM
      operationId: sendPrompt
      tags:
        - LLM
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PromptRequest'
      responses:
        '200':
          description: Comando procesado exitosamente
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PromptResponse'
        '400':
          $ref: '#/components/responses/BadRequest'
        '500':
          $ref: '#/components/responses/InternalError'

  /mcp/servers:
    get:
      summary: Listar servidores MCP
      operationId: listMcpServers
      tags:
        - MCP
      responses:
        '200':
          description: Lista de servidores MCP
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/McpServersList'

  /mcp/servers/{name}/tools:
    get:
      summary: Obtener herramientas de un servidor MCP
      operationId: getMcpServerTools
      tags:
        - MCP
      parameters:
        - name: name
          in: path
          required: true
          schema:
            type: string
          example: lighting
      responses:
        '200':
          description: Lista de herramientas del servidor
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/McpToolsList'
        '404':
          $ref: '#/components/responses/NotFound'

  /devices:
    get:
      summary: Listar dispositivos IoT
      operationId: listDevices
      tags:
        - Devices
      parameters:
        - name: type
          in: query
          schema:
            type: string
            enum: [light, thermostat, camera, speaker, sensor, lock, switch]
        - name: enabled
          in: query
          schema:
            type: boolean
      responses:
        '200':
          description: Lista de dispositivos
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/DevicesList'

  /devices/{id}/control:
    post:
      summary: Controlar un dispositivo
      operationId: controlDevice
      tags:
        - Devices
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/DeviceControlRequest'
      responses:
        '200':
          description: Comando ejecutado
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/DeviceControlResponse'
        '404':
          $ref: '#/components/responses/NotFound'
        '503':
          $ref: '#/components/responses/DeviceOffline'

  /scenes:
    get:
      summary: Listar escenas
      operationId: listScenes
      tags:
        - Scenes
      parameters:
        - name: user_id
          in: query
          schema:
            type: integer
        - name: system
          in: query
          schema:
            type: boolean
      responses:
        '200':
          description: Lista de escenas
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ScenesList'

  /scenes/{id}/activate:
    post:
      summary: Activar una escena
      operationId: activateScene
      tags:
        - Scenes
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: Escena activada exitosamente
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SceneActivationResponse'
        '207':
          description: Escena activada parcialmente
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SceneActivationResponse'
        '404':
          $ref: '#/components/responses/NotFound'

components:
  securitySchemes:
    ApiKeyAuth:
      type: apiKey
      in: header
      name: X-API-Key

  schemas:
    PromptRequest:
      type: object
      required:
        - prompt
      properties:
        prompt:
          type: string
          example: "Enciende las luces de la sala"
        user_id:
          type: integer
          example: 1
        context:
          type: object
          properties:
            session_id:
              type: string
            previous_messages:
              type: array
              items:
                type: string

    PromptResponse:
      type: object
      properties:
        response:
          type: string
        actions_executed:
          type: array
          items:
            type: object
            properties:
              tool:
                type: string
              device_id:
                type: string
              result:
                type: string
        latency_ms:
          type: integer

    McpServersList:
      type: object
      properties:
        servers:
          type: array
          items:
            type: object
            properties:
              id:
                type: integer
              name:
                type: string
              status:
                type: string
                enum: [running, stopped, error]
              tools_count:
                type: integer
              enabled:
                type: boolean

    McpToolsList:
      type: object
      properties:
        server:
          type: string
        tools:
          type: array
          items:
            type: object
            properties:
              name:
                type: string
              description:
                type: string
              input_schema:
                type: object

    DevicesList:
      type: object
      properties:
        devices:
          type: array
          items:
            type: object
            properties:
              id:
                type: integer
              name:
                type: string
              type:
                type: string
              server_mcp:
                type: string
              enabled:
                type: boolean
              state:
                type: object
              last_updated:
                type: string
                format: date-time
        total:
          type: integer

    DeviceControlRequest:
      type: object
      required:
        - action
      properties:
        action:
          type: string
        parameters:
          type: object

    DeviceControlResponse:
      type: object
      properties:
        device_id:
          type: integer
        action:
          type: string
        result:
          type: string
          enum: [success, error]
        new_state:
          type: object
        latency_ms:
          type: integer

    ScenesList:
      type: object
      properties:
        scenes:
          type: array
          items:
            type: object
            properties:
              id:
                type: integer
              name:
                type: string
              user_id:
                type: integer
                nullable: true
              is_system:
                type: boolean
              description:
                type: string
              devices_count:
                type: integer
        total:
          type: integer

    SceneActivationResponse:
      type: object
      properties:
        scene_id:
          type: integer
        scene_name:
          type: string
        result:
          type: string
          enum: [success, partial, error]
        actions_executed:
          type: array
          items:
            type: object
            properties:
              device:
                type: string
              action:
                type: string
              result:
                type: string
              error_message:
                type: string
        total_latency_ms:
          type: integer

    Error:
      type: object
      properties:
        error:
          type: string
        message:
          type: string

  responses:
    BadRequest:
      description: Solicitud inválida
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'

    NotFound:
      description: Recurso no encontrado
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'

    InternalError:
      description: Error interno del servidor
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'

    DeviceOffline:
      description: Dispositivo no disponible
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
```

---

## Notas Finales

Este documento especifica todas las interfaces públicas del sistema SRCS. Durante la implementación:

1. **Validar schemas** con herramientas como Swagger Editor
2. **Implementar versionado** de APIs (v1, v2, etc.)
3. **Documentar cambios** en changelog
4. **Proveer ejemplos** de uso para cada endpoint/tool
5. **Testing exhaustivo** de todas las interfaces

**Próximos pasos:**
1. Implementar servidores MCP según especificación
2. Implementar conectores IoT según interfaces
3. Implementar endpoints REST según OpenAPI spec
4. Crear documentación interactiva (Swagger UI)

---

**Última actualización:** Octubre 2025
**Autores:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC
