# Architectural Decision Records (ADRs)
## Decisiones de Arquitectura Base

**Universidad Tecnológica de Panamá**

**Facultad de Ingeniería de Sistemas Computacionales**

**Autores:** Alejandro Mosquera, Victor Rodríguez

**Versión:** 1.0

**Fecha:** Octubre 2025

---

## Tabla de Contenido

1. [Introducción](#1-introducción)
2. [ADR-001: Uso de mcp-client-cli como Base del Proyecto](#adr-001-uso-de-mcp-client-cli-como-base-del-proyecto)
3. [ADR-002: Stack Tecnológico Python + LangChain](#adr-002-stack-tecnológico-python--langchain)
4. [ADR-003: SQLite como Base de Datos](#adr-003-sqlite-como-base-de-datos)
5. [Resumen de Decisiones](#resumen-de-decisiones)

---

## 1. Introducción

Este documento registra las **Decisiones Arquitectónicas (Architectural Decision Records - ADRs)** más importantes tomadas durante el diseño del Smart Room Control System (SRCS). Cada ADR sigue el formato estándar que documenta el contexto, la decisión tomada, las alternativas consideradas y las consecuencias.

### 1.1 Propósito de los ADRs

- Documentar decisiones arquitectónicas críticas con su justificación
- Proporcionar contexto histórico para futuras modificaciones
- Facilitar la comprensión del diseño del sistema
- Prevenir la repetición de discusiones ya resueltas

### 1.2 Formato de ADRs

Cada ADR contiene:
- **Título**: Nombre descriptivo de la decisión
- **Estado**: Propuesto / Aceptado / Rechazado / Deprecado / Supersedido
- **Contexto**: Fuerzas y factores que motivaron la decisión
- **Decisión**: Qué se decidió hacer
- **Alternativas Consideradas**: Otras opciones evaluadas
- **Consecuencias**: Impactos positivos y negativos de la decisión
- **Fecha**: Cuándo se tomó la decisión
- **Participantes**: Quiénes participaron en la decisión

---

## ADR-001: Uso de mcp-client-cli como Base del Proyecto

### Metadata

- **Estado**: ✅ **Aceptado**
- **Fecha**: Enero 2025
- **Participantes**: Alejandro Mosquera, Victor Rodríguez, Ing. Aris Castillo
- **Supersede**: N/A

### Contexto

Al iniciar el diseño del Smart Room Control System (SRCS), nos enfrentamos a la necesidad de implementar:

1. **Cliente MCP Coordinador** capaz de conectarse a múltiples servidores MCP
2. **Integración con LLM** local (Llama) mediante LangChain/LangGraph
3. **Sistema de memoria persistente** para contexto de conversación y preferencias
4. **Interfaz de usuario** con soporte para voz (STT) y texto
5. **Configuración flexible** de servidores MCP y dispositivos

Durante la investigación, descubrimos **mcp-client-cli** (https://github.com/adhikasp/mcp-client-cli), un proyecto open-source que implementa un cliente CLI para MCP con las siguientes características:

**Componentes existentes en mcp-client:**
- ✅ Cliente Coordinador MCP completo (`tool.py` - McpToolkit)
- ✅ Integración con LangChain/LangGraph (ReAct agent)
- ✅ Sistema de configuración JSON con comentarios (`config.py`)
- ✅ Gestión de memoria con SQLite (`memory.py` - SqliteStore)
- ✅ Interfaz STT con Whisper (`whisperVoiceInterface.py`)
- ✅ Interfaz CLI con Rich (`cli.py`, `output.py`)
- ✅ Cache de herramientas MCP (24h TTL en `storage.py`)
- ✅ Sistema de confirmación de tools (`requires_confirmation`)
- ✅ Historial de conversaciones (LangGraph checkpoint)
- ✅ Soporte para modelos locales (vía Ollama)

**Componentes faltantes para SRCS:**
- ❌ Servidores MCP especializados para IoT (lighting, climate, security, entertainment)
- ❌ Conectores IoT (Philips Hue, Nest, cámaras, etc.)
- ❌ TTS (Text-to-Speech) para respuestas de voz
- ❌ Gestión de escenas y rutinas
- ❌ Aprendizaje de preferencias específicas para Smart Rooms
- ❌ Base de datos extendida para dispositivos y escenas
- ❌ API REST de administración

### Decisión

**Decisión tomada:** Usar **mcp-client-cli** como **base del proyecto**, mediante un **fork y extensión** del código existente.

**Justificación:**
1. **Reutilización de código probado**: mcp-client implementa ~40% de nuestros requisitos funcionales (13/33 RF)
2. **Ahorro de tiempo**: Estimamos ahorro de ~90 horas de desarrollo
3. **Stack tecnológico alineado**: Python 3.12+, LangChain, LangGraph, MCP SDK, SQLite
4. **Arquitectura compatible**: El diseño modular de mcp-client se alinea con nuestra arquitectura C4
5. **Licencia permisiva**: MIT License permite fork y modificación
6. **Código de calidad**: Proyecto bien estructurado con separación de responsabilidades

### Alternativas Consideradas

#### Alternativa 1: Implementar desde Cero
**Ventajas:**
- Control total sobre la arquitectura
- Código específicamente diseñado para Smart Rooms
- No hay código innecesario

**Desventajas:**
- Requiere ~90 horas adicionales de desarrollo
- Reinventar la rueda en Cliente MCP, memoria, configuración
- Mayor riesgo de bugs en componentes core
- Retraso en cronograma del proyecto

**Veredicto:** ❌ Rechazado (no justificable para un proyecto de 6 meses)

#### Alternativa 2: Usar mcp-client como Librería/Dependencia
**Ventajas:**
- Separación limpia entre base y extensión
- Actualizaciones automáticas del upstream

**Desventajas:**
- mcp-client no está diseñado como librería
- Difícil extender componentes internos sin fork
- Menos control sobre flujo de ejecución
- Complicado adaptar CLI a dominio Smart Room

**Veredicto:** ❌ Rechazado (poco práctico técnicamente)

#### Alternativa 3: Fork y Extensión (SELECCIONADA)
**Ventajas:**
- Reutilización de ~60% del código base
- Libertad para modificar y extender componentes
- Mantener créditos y licencia MIT
- Posibilidad de contribuir mejoras al upstream

**Desventajas:**
- Desincronización con upstream (no crítico para proyecto de investigación)
- Código que no se usa en SRCS (puede limpiarse opcionalmente)
- Necesidad de entender arquitectura existente

**Veredicto:** ✅ **ACEPTADO**

#### Alternativa 4: Inspirarse sin Reusar Código
**Ventajas:**
- Código limpio específico para SRCS
- Aprender de patrones sin depender del proyecto

**Desventajas:**
- Similar a "desde cero" en tiempo de desarrollo
- Perdemos implementaciones probadas de Cliente MCP

**Veredicto:** ❌ Rechazado (no maximiza eficiencia)

### Consecuencias

#### Consecuencias Positivas ✅

1. **Reducción de Tiempo de Desarrollo**
   - Estimación original: ~240 horas total
   - Con fork de mcp-client: ~150 horas total
   - **Ahorro: ~90 horas (37.5%)**

2. **Componentes Core Ya Implementados**
   - Cliente MCP Coordinador (RF-007, RF-008, RF-011) ✅
   - Agente LLM con LangChain/LangGraph (RF-001, RF-002, RF-004) ✅
   - Sistema de Memoria (RF-032) ✅
   - Interfaz STT (RF-019) ✅
   - Configuración flexible ✅

3. **Código Probado en Producción**
   - mcp-client tiene tests de integración en CI/CD (GitHub Actions)
   - Usado por comunidad de MCP

4. **Fundación Sólida para Extensión**
   - Arquitectura modular facilita agregar:
     - Nuevos servidores MCP (IoT)
     - Nuevos conectores
     - TTS
     - Gestión de escenas

5. **Alineación con Mejores Prácticas**
   - Uso de type hints y Pydantic
   - Logging comprehensivo
   - Async/await para I/O

#### Consecuencias Negativas ⚠️

1. **Curva de Aprendizaje Inicial**
   - Necesidad de entender arquitectura de mcp-client (~4-6 horas)
   - Lectura de código existente en `cli.py`, `tool.py`, `memory.py`, etc.
   - **Mitigación**: Documentación disponible (README.md, CLAUDE.md, CONFIG.md)

2. **Código No Utilizado**
   - mcp-client incluye funcionalidades que SRCS no necesita:
     - Templates de prompts (`review`, `commit`, `yt`)
     - Soporte de clipboard
     - Algunos flags de CLI
   - **Mitigación**: Puede dejarse sin afectar funcionalidad, o limpiarse opcionalmente

3. **Desincronización con Upstream**
   - Nuestro fork divergirá del proyecto original
   - No recibiremos actualizaciones automáticas
   - **Mitigación**: No crítico para proyecto de investigación (6 meses); se puede hacer merge manual si necesario

4. **Necesidad de Extender Base de Datos**
   - mcp-client tiene SQLite para conversaciones y memoria
   - SRCS necesita tablas adicionales (devices, scenes, action_logs, system_metrics)
   - **Mitigación**: Usar Alembic para migrations, mantener compatibilidad con schema base

5. **Dependencia de Arquitectura Externa**
   - Acoplamiento a decisiones de diseño de mcp-client
   - Cambios profundos requerirían refactoring significativo
   - **Mitigación**: Análisis mostró que arquitectura es compatible con SRCS

### Mapeo de Componentes: mcp-client → SRCS

| Componente mcp-client | Uso en SRCS | Modificación Necesaria |
|----------------------|-------------|------------------------|
| `cli.py` | Base del agente principal | ✏️ Extender comandos administrativos |
| `tool.py` (McpToolkit) | Cliente Coordinador MCP | ✅ Reutilizar sin cambios |
| `config.py` | Sistema de configuración | ✏️ Extender schema para dispositivos IoT |
| `memory.py` (SqliteStore) | Gestión de memoria | ✏️ Extender para preferencias Smart Room |
| `storage.py` | Cache de herramientas | ✅ Reutilizar sin cambios |
| `input.py` | Entrada de voz/texto | ✅ Reutilizar (STT con Whisper) |
| `output.py` | Salida de texto | ✏️ Agregar TTS para voz |
| `prompt.py` | Templates de prompts | ❌ Reemplazar con templates Smart Room |
| `const.py` | Constantes | ✏️ Ajustar paths y timeouts |
| `whisperVoiceInterface.py` | STT | ✅ Reutilizar sin cambios |

**Leyenda:**
- ✅ Reutilizar sin cambios
- ✏️ Extender/modificar
- ❌ No usar / reemplazar
- ➕ Crear nuevo

### Nuevos Componentes a Crear

Para completar SRCS, crearemos los siguientes módulos:

#### 1. Servidores MCP IoT (`src/mcp-servers/`)
- `lighting/server.py` - RF-012
- `climate/server.py` - RF-013
- `security/server.py` - RF-014
- `entertainment/server.py` - RF-015

#### 2. Conectores IoT (`src/iot-connectors/`)
- `base_connector.py` - Clase abstracta base
- `philips_hue_connector.py` - RF-016
- `nest_connector.py` - RF-016
- `generic_camera_connector.py` - RF-017

#### 3. Gestión de Escenas (`src/scenes/`)
- `scene_manager.py` - RF-024, RF-025, RF-026

#### 4. Administración (`src/admin/`)
- `device_registry.py` - RF-027
- `server_manager.py` - RF-028
- `user_manager.py` - RF-029
- `metrics_collector.py` - RF-030

#### 5. Aprendizaje (`src/learning/`)
- `preference_learner.py` - RF-031, RF-033

#### 6. Extensiones de UI (`src/ui/`)
- `tts_interface.py` - RF-021 (Bark/Piper)

### Estrategia de Implementación

1. **Fase 0: Fork y Setup** (4-6 horas)
   - Fork de https://github.com/adhikasp/mcp-client-cli
   - Renombrar proyecto a `smart-room-mcp`
   - Actualizar README.md con contexto SRCS
   - Configurar entorno de desarrollo

2. **Fase 1: Extensión de Base de Datos** (8 horas)
   - Crear migrations con Alembic
   - Agregar tablas: devices, scenes, action_logs, system_metrics
   - Extender user_preferences

3. **Fase 2: Servidores MCP IoT** (40 horas)
   - Implementar 4 servidores MCP especializados
   - Cada servidor: ~10 horas (tools + testing)

4. **Fase 3: Conectores IoT** (30 horas)
   - Implementar base_connector + 3 conectores específicos
   - Cada conector: ~7-10 horas

5. **Fase 4: Gestión de Escenas** (15 horas)
   - Scene manager con CRUD
   - Integración con LLM agent

6. **Fase 5: Features Adicionales** (25 horas)
   - TTS (RF-021): 8h
   - Administración (RF-027-030): 10h
   - Aprendizaje de preferencias (RF-031): 7h

7. **Fase 6: Testing e Integración** (28 horas)
   - Unit tests: 15h
   - Integration tests: 10h
   - Documentación de código: 3h

**Total Estimado:** ~150 horas (vs ~240h desde cero)

### Referencias

- **Proyecto Base**: https://github.com/adhikasp/mcp-client-cli
- **Licencia**: MIT License (permite fork y modificación comercial)
- **Documentación**:
  - README.md del proyecto
  - CLAUDE.md (guía para desarrollo)
  - CONFIG.md (formato de configuración)
- **Análisis de Cobertura**: Ver sección 1 de este documento

### Aprobación

- ✅ **Aprobado por**: Alejandro Mosquera, Victor Rodríguez
- ✅ **Revisado por**: Ing. Aris Castillo, MSC
- **Fecha de Aprobación**: Enero 2025

---

## ADR-002: Stack Tecnológico Python + LangChain

### Metadata

- **Estado**: ✅ **Aceptado**
- **Fecha**: Enero 2025
- **Participantes**: Alejandro Mosquera, Victor Rodríguez, Ing. Aris Castillo

### Contexto

El proyecto requiere:
1. Procesamiento de lenguaje natural con LLMs
2. Orquestación de agentes AI con estado
3. Integración con Model Context Protocol
4. Ejecución local de modelos (Llama)
5. Rápido desarrollo de prototipo (6 meses)

### Decisión

Usar **Python 3.12+** con **LangChain** y **LangGraph** como stack principal.

**Componentes del Stack:**
- **Lenguaje**: Python 3.12+
- **Framework LLM**: LangChain 0.3+
- **Agentes con Estado**: LangGraph 0.2+
- **MCP SDK**: mcp >= 1.0.0
- **Ejecución Local LLM**: Ollama
- **Base de Datos**: SQLite 3.x + SQLAlchemy 2.x
- **Migrations**: Alembic
- **Testing**: pytest + pytest-cov
- **Linting**: black, flake8, mypy
- **CLI UI**: Rich
- **STT**: OpenAI Whisper
- **TTS**: Bark o Piper

### Alternativas Consideradas

#### Alternativa 1: TypeScript + LangChain.js
**Ventajas:**
- LangChain disponible en JS/TS
- Alto rendimiento con Node.js

**Desventajas:**
- Ecosistema ML/AI menos maduro que Python
- Whisper/Bark requieren wrappers
- Menos experiencia del equipo con TS avanzado

**Veredicto:** ❌ Rechazado

#### Alternativa 2: Python sin LangChain (LlamaIndex o custom)
**Ventajas:**
- Menor overhead
- Mayor control

**Desventajas:**
- Necesidad de implementar orquestación custom
- LangGraph es ideal para agentes con estado
- Mayor tiempo de desarrollo

**Veredicto:** ❌ Rechazado

#### Alternativa 3: Python + LangChain (SELECCIONADA)
**Ventajas:**
- Ecosistema maduro de ML/AI
- LangChain soporta MCP nativamente
- LangGraph ideal para agentes conversacionales
- Whisper, Bark, Ollama tienen bindings Python
- Rápido desarrollo de prototipos
- Gran comunidad y documentación

**Desventajas:**
- Python más lento que lenguajes compilados (no crítico para proyecto)

**Veredicto:** ✅ **ACEPTADO**

### Consecuencias

#### Positivas ✅
- Desarrollo ágil de prototipo
- Integración directa con Ollama, Whisper, Bark
- Uso de type hints (Python 3.12) para calidad de código
- Compatibilidad con mcp-client-cli (mismo stack)

#### Negativas ⚠️
- Rendimiento limitado por GIL de Python (mitigado con async/await)
- Mayor consumo de memoria vs lenguajes compilados

---

## ADR-003: SQLite como Base de Datos

### Metadata

- **Estado**: ✅ **Aceptado**
- **Fecha**: Enero 2025
- **Participantes**: Alejandro Mosquera, Victor Rodríguez

### Contexto

El sistema requiere persistencia de:
- Configuración de usuarios y preferencias
- Historial de conversaciones
- Registro de dispositivos IoT
- Escenas y rutinas
- Logs de acciones y métricas

### Decisión

Usar **SQLite 3.x** como base de datos embebida.

**Justificación:**
1. **Zero-configuration**: No requiere servidor separado
2. **Portabilidad**: Un solo archivo `.db`
3. **Suficiente para alcance**: Máximo 10 usuarios concurrentes
4. **Ya usado en mcp-client**: `conversations.db` para LangGraph
5. **Ideal para investigación**: Fácil backup y análisis

### Alternativas Consideradas

#### Alternativa 1: PostgreSQL
**Ventajas:**
- Mayor escalabilidad
- Mejor soporte de concurrencia

**Desventajas:**
- Requiere servidor separado (overhead)
- Overkill para 10 usuarios máximo
- Mayor complejidad de despliegue

**Veredicto:** ❌ Rechazado (sobredimensionado)

#### Alternativa 2: SQLite (SELECCIONADA)
**Ventajas:**
- Simplicidad de setup
- Ideal para prototipo de investigación
- Usado exitosamente por mcp-client
- Soporte excelente en Python (stdlib + aiosqlite)

**Desventajas:**
- Limitaciones de concurrencia (no crítico para SRCS)

**Veredicto:** ✅ **ACEPTADO**

### Consecuencias

#### Positivas ✅
- Despliegue simplificado (un archivo)
- Compatibilidad con base existente de mcp-client
- Fácil backup para análisis

#### Negativas ⚠️
- Escalabilidad limitada (aceptable para alcance del proyecto)

---

## Resumen de Decisiones

| ID | Decisión | Estado | Impacto | Fecha |
|----|----------|--------|---------|-------|
| ADR-001 | Usar mcp-client-cli como base | ✅ Aceptado | **Alto** - Ahorra ~90h desarrollo | Ene 2025 |
| ADR-002 | Stack Python + LangChain | ✅ Aceptado | Alto - Define toda la implementación | Ene 2025 |
| ADR-003 | SQLite como base de datos | ✅ Aceptado | Medio - Simplicidad vs escalabilidad | Ene 2025 |

---

## Próximas Decisiones a Documentar

Decisiones arquitectónicas pendientes de formalizar:

- **ADR-004**: Selección de TTS (Bark vs Piper)
- **ADR-005**: Estrategia de testing (unitarios vs integración)
- **ADR-006**: Uso de Home Assistant como capa de integración (opcional)
- **ADR-007**: Estrategia de deployment (Docker vs venv nativo)

---

**Fin del Documento ADR**
