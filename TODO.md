# TODO - Smart Room Control System (SRCS)
## Sistema Integral de Control Inteligente para Smart Rooms mediante MCP

**Proyecto:** Trabajo de Graduación - UTP 2025
**Autores:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC

**Última actualización:** Octubre 2025

---

## Estado del Proyecto

### Fase Actual: Ingeniería de Software - Documentación

**Progreso General:** 100% (13/13 documentos principales completados) ✅

### 🎯 **DECISIÓN ARQUITECTÓNICA IMPORTANTE**

El proyecto utiliza **[mcp-client-cli](https://github.com/adhikasp/mcp-client-cli)** como **base tecnológica** (ver `docs/00-ADR-Base-Tecnologica.md`).

**Componentes Ya Implementados en mcp-client (~40% de requisitos):**
- ✅ Cliente Coordinador MCP (RF-007, RF-008, RF-011)
- ✅ Agente LLM con LangChain/LangGraph (RF-001, RF-002, RF-004, RF-006)
- ✅ Sistema de Memoria Persistente (RF-032)
- ✅ Interfaz STT con Whisper (RF-019)
- ✅ Interfaz CLI con Rich (RF-020, RF-022)
- ✅ Configuración de Servidores MCP (RF-028 parcial)
- ✅ Cache de Herramientas (RF-011)
- ✅ Historial de Conversaciones

**Componentes a Crear (~60% restante):**
- ❌ Servidores MCP IoT (RF-012 a RF-015) - CRÍTICO
- ❌ Conectores IoT (RF-016 a RF-018) - CRÍTICO
- ❌ TTS para voz (RF-021)
- ❌ Gestión de Escenas (RF-024 a RF-026)
- ❌ Administración Sistema (RF-027, RF-029, RF-030)
- ❌ Aprendizaje de Preferencias (RF-031, RF-033)

**Ahorro Estimado:** ~90 horas de desarrollo (37.5%)

---

## 📋 Checklist de Documentación

### ✅ Documentos Completados

- [x] **Estructura de Directorios** - Organización completa del proyecto
  - [x] `/docs/` - Documentación del proyecto
  - [x] `/docs/diagrams/` - Diagramas (arquitectura, casos-uso, secuencia, ER)
  - [x] `/src/` - Código fuente
  - [x] `/tests/` - Pruebas (unit, integration, system, acceptance)
  - [x] `/config/` - Archivos de configuración
  - [x] `/database/` - Scripts de base de datos

- [x] **docs/10-Glosario.md** ✅ COMPLETADO
  - [x] Términos generales (Smart Room, Computación Ubicua, etc.)
  - [x] Términos de IA (LLM, Agente AI, NLP, Inferencia Local, etc.)
  - [x] Términos de MCP (Servidor MCP, Cliente MCP, Tool, Resource, etc.)
  - [x] Términos de IoT (Dispositivos IoT, Conector, Actuador, Sensor, etc.)
  - [x] Términos de HCI (Interfaz de voz, STT, TTS, etc.)
  - [x] Términos de evaluación (Latencia, SUS, Métricas, etc.)
  - [x] 40+ acrónimos definidos
  - [x] Convenciones de nomenclatura
  - [x] Referencias bibliográficas

- [x] **docs/01-SRS-Especificacion-Requisitos.md** ✅ COMPLETADO
  - [x] 1. Introducción (propósito, alcance, definiciones, referencias)
  - [x] 2. Descripción General (perspectiva, funciones, usuarios, restricciones)
  - [x] 3. Requisitos Específicos:
    - [x] 3.1 Requisitos Funcionales (RF-001 a RF-033)
      - [x] RF-001 a RF-006: Agente AI Central (LLM)
      - [x] RF-007 a RF-011: Cliente Coordinador MCP
      - [x] RF-012 a RF-015: Servidores MCP Especializados
      - [x] RF-016 a RF-018: Conectores IoT
      - [x] RF-019 a RF-023: Interfaz de Usuario
      - [x] RF-024 a RF-026: Gestión de Escenas y Rutinas
      - [x] RF-027 a RF-030: Administración del Sistema
      - [x] RF-031 a RF-033: Aprendizaje y Personalización
    - [x] 3.2 Requisitos No Funcionales (RNF-001 a RNF-030)
      - [x] RNF-001 a RNF-005: Rendimiento
      - [x] RNF-006 a RNF-010: Seguridad y Privacidad
      - [x] RNF-011 a RNF-015: Usabilidad
      - [x] RNF-016 a RNF-020: Confiabilidad
      - [x] RNF-021 a RNF-025: Mantenibilidad
      - [x] RNF-026 a RNF-028: Portabilidad
      - [x] RNF-029 a RNF-030: Escalabilidad
    - [x] 3.3 Requisitos del Sistema (Hardware y Software)
  - [x] 4. Apéndices (mapeo, priorización MoSCoW, supuestos)

- [x] **docs/04-Arquitectura-Sistema.md** ✅ COMPLETADO
  - [x] 1. Introducción (objetivos, principios de diseño)
  - [x] 2. Diagrama de Contexto (C4 Level 1) - PlantUML
  - [x] 3. Diagrama de Contenedores (C4 Level 2) - PlantUML
  - [x] 4. Diagrama de Componentes (C4 Level 3) - PlantUML
  - [x] 5. Diagrama de Despliegue - PlantUML
  - [x] 6. Patrones Arquitectónicos (6 patrones documentados)
  - [x] 7. Decisiones Arquitectónicas (5 ADRs)
  - [x] 8. Flujo de Datos (2 flujos detallados)
  - [x] ✅ Actualizado con componentes de mcp-client (Sección 9)

- [x] **docs/00-ADR-Base-Tecnologica.md** ✅ COMPLETADO
  - [x] ADR-001: Uso de mcp-client-cli como base del proyecto
  - [x] ADR-002: Stack tecnológico Python + LangChain
  - [x] ADR-003: SQLite como base de datos
  - [x] Mapeo de componentes mcp-client → SRCS
  - [x] Estrategia de implementación (Fases 0-6)
  - [x] Análisis de ahorro de tiempo (~90h)

- [x] **docs/02-Historias-Usuario.md** ✅ COMPLETADO
  - [x] HU-001 a HU-015: Como Usuario del Smart Room (15 historias)
  - [x] HU-016 a HU-025: Como Administrador (10 historias)
  - [x] HU-026 a HU-035: Como Desarrollador (10 historias)
  - [x] HU-036 a HU-040: Como Sistema (5 historias)
  - [x] Priorización MoSCoW y puntos de historia
  - [x] Criterios de aceptación para cada historia
  - [x] ✅ Sección 7: Estado de implementación en mcp-client (40 historias mapeadas)

- [x] **docs/03-Casos-Uso.md** ✅ COMPLETADO
  - [x] Diagrama general de casos de uso (PlantUML)
  - [x] CU-001 a CU-015: Casos de uso detallados (15 casos)
  - [x] Formato completo: precondiciones, flujo principal, alternos, postcondiciones
  - [x] ✅ Sección 6: Estado de implementación en mcp-client (18 casos mapeados)

- [x] **docs/05-Modelo-Datos.md** ✅ COMPLETADO
  - [x] Diagrama Entidad-Relación (Mermaid)
  - [x] Esquema completo de base de datos SQLite (8 tablas)
  - [x] JSON Schemas de configuración
  - [x] Script SQL de creación (`database/schema.sql`)
  - [x] Estrategia de migrations con Alembic
  - [x] ✅ Sección 2: Schema existente de mcp-client (6 tablas documentadas)

- [x] **docs/06-APIs-Interfaces.md** ✅ COMPLETADO
  - [x] API del Cliente Coordinador MCP
  - [x] Especificación de 4 Servidores MCP (Lighting, Climate, Security, Entertainment)
  - [x] Tools de cada servidor (20+ herramientas documentadas)
  - [x] Interfaces de Conectores IoT (Philips Hue, Nest, Cameras, Sonos)
  - [x] Interfaz de Voz (Whisper STT, Bark/Piper TTS)
  - [x] ✅ Sección 2: APIs existentes de mcp-client (5 componentes documentados)

- [x] **docs/07-Diagramas-Secuencia.md** ✅ COMPLETADO
  - [x] DS-001 a DS-010: 10 diagramas de secuencia (PlantUML)
  - [x] Flujos completos desde usuario hasta dispositivo
  - [x] Manejo de errores y casos alternativos
  - [x] Notas de timing y rendimiento

- [x] **docs/08-Plan-Pruebas.md** ✅ COMPLETADO
  - [x] Estrategia de pruebas (niveles, herramientas, criterios)
  - [x] 50 casos de prueba funcionales (CP-001 a CP-050)
  - [x] Casos de prueba no funcionales (rendimiento, seguridad, usabilidad)
  - [x] 5 escenarios de evaluación con usuarios
  - [x] Métricas cuantitativas y cualitativas (SUS, latencia, tasa de éxito)
  - [x] Plantillas y criterios de entrada/salida

---

### ✅ Documentación Completa (100%)

#### Actualizaciones Completadas

- [x] **Actualizar Documentación Existente** ✅ COMPLETADO (6/6)
  - [x] **docs/04-Arquitectura-Sistema.md**: Sección 9 sobre componentes de mcp-client ✅
  - [x] **docs/05-Modelo-Datos.md**: Sección 2 con schema de mcp-client (6 tablas) ✅
  - [x] **docs/02-Historias-Usuario.md**: Sección 7 con estado en mcp-client (40 HU) ✅
  - [x] **docs/03-Casos-Uso.md**: Sección 6 con flujos implementados (18 CU) ✅
  - [x] **docs/06-APIs-Interfaces.md**: Sección 2 con APIs de mcp-client (5 APIs) ✅
  - [x] **docs/01-SRS-Especificacion-Requisitos.md**: Sección 2.1.1 ampliada ✅

#### Nuevos Documentos Completados

- [x] **docs/09-Matriz-Trazabilidad.md** ✅ COMPLETADO
  - [x] Tabla: Objetivos Anteproyecto → Requisitos Funcionales (100% cobertura)
  - [x] Tabla: Requisitos Funcionales → Historias de Usuario (33 RF mapeados)
  - [x] Tabla: Historias de Usuario → Casos de Uso (40 HU mapeadas)
  - [x] Tabla: Casos de Uso → Casos de Prueba (15 CU mapeados)
  - [x] Tabla: Requisitos No Funcionales → Casos de Prueba (30 RNF mapeados)
  - [x] Análisis de cobertura completo (sin brechas identificadas)
  - [x] Estado de implementación en mcp-client documentado

- [x] **docs/11-Planificacion-Detallada.md** ✅ COMPLETADO
  - [x] Descomposición de tareas ajustada para mcp-client
  - [x] Sprint 0: Fork y setup (1 semana, 6h)
  - [x] Sprint 1-2: Servidores MCP IoT y Conectores (4 semanas, 48h)
  - [x] Sprint 3-4: Gestión de Escenas y TTS (4 semanas, 40h)
  - [x] Sprint 5: Administración y Aprendizaje (2 semanas, 28h)
  - [x] Sprint 6: Pruebas, Validación y Documentación (4 semanas, 28h)
  - [x] Estimación ACTUALIZADA: 150 horas (ahorro de 90h)
  - [x] Asignación de tareas a Alejandro y Victor
  - [x] Diagrama de dependencias y ruta crítica
  - [x] 6 hitos principales (M0 a M6)
  - [x] Gestión de riesgos (8 riesgos identificados)

- [x] **docs/12-Manual-Usuario.md** ✅ COMPLETADO
  - [x] 1. Introducción al SRCS (características y funcionamiento)
  - [x] 2. Requisitos del Sistema (hardware, software, IoT)
  - [x] 3. Instalación (Linux, macOS, Windows WSL2)
  - [x] 4. Configuración Inicial (config.json, credenciales IoT, dispositivos)
  - [x] 5. Uso Básico (comandos texto y voz, ejemplos detallados)
  - [x] 6. Gestión de Escenas (crear, ejecutar, triggers, condiciones)
  - [x] 7. Configuración Avanzada (LLM, prompts, memoria, multi-ubicación)
  - [x] 8. Solución de Problemas (7 problemas comunes resueltos)
  - [x] 9. FAQ (15+ preguntas frecuentes)
  - [x] Apéndices (comandos, escenas ejemplo, recursos)

#### Baja Prioridad (Opcional - Especificaciones Técnicas Detalladas)

- [ ] **docs/tech-specs/MCP-Lighting-Server-Spec.md**
- [ ] **docs/tech-specs/MCP-Climate-Server-Spec.md**
- [ ] **docs/tech-specs/MCP-Security-Server-Spec.md**
- [ ] **docs/tech-specs/MCP-Entertainment-Server-Spec.md**
- [ ] **docs/tech-specs/IoT-Connectors-Spec.md**
- [ ] **docs/tech-specs/Scene-Manager-Spec.md**

---

## 🛠️ Tareas de Implementación (Código)

**NOTA IMPORTANTE:** El proyecto se basa en un fork de **mcp-client-cli**. Muchos componentes core ya están implementados.

### Fase 0: Fork y Setup de mcp-client (NUEVO - 4-6 horas)

- [ ] **Fork del Proyecto Base**
  - [ ] Fork de https://github.com/adhikasp/mcp-client-cli
  - [ ] Clonar fork localmente
  - [ ] Renombrar proyecto a `smart-room-mcp`
  - [ ] Actualizar README.md con contexto SRCS
  - [ ] Actualizar pyproject.toml (nombre, autores, descripción)
  - [ ] Crear branch `srcs-development`

- [ ] **Análisis de Componentes Existentes**
  - [ ] Estudiar `cli.py` (agente principal y CLI)
  - [ ] Estudiar `tool.py` (McpToolkit - Cliente MCP)
  - [ ] Estudiar `config.py` (sistema de configuración)
  - [ ] Estudiar `memory.py` (SqliteStore)
  - [ ] Estudiar `storage.py` (cache de herramientas)
  - [ ] Estudiar `input.py` y `output.py` (UI)
  - [ ] Documentar en memoria qué se reutiliza y qué se crea

- [ ] **Setup del Entorno**
  - [ ] Crear virtual environment con Python 3.12+
  - [ ] Instalar dependencias existentes de mcp-client
  - [ ] Configurar Ollama y descargar Llama 3.1
  - [ ] Probar CLI básico de mcp-client
  - [ ] Configurar pre-commit hooks (black, flake8, mypy)

### Fase 1: Extensión de Base de Datos (8 horas)

- [ ] **Migrations con Alembic**
  - [ ] Inicializar Alembic en el proyecto
  - [ ] Crear migration que extiende schema de mcp-client:
    - [ ] Nueva tabla `devices` (dispositivos IoT)
    - [ ] Nueva tabla `scenes` (escenas y rutinas)
    - [ ] Nueva tabla `action_logs` (historial de acciones)
    - [ ] Nueva tabla `system_metrics` (métricas de rendimiento)
    - [ ] Extender tabla existente de memoria para preferencias Smart Room
  - [ ] Aplicar migrations y verificar schema
  - [ ] Crear fixtures de datos de prueba

- [ ] **SQLAlchemy Models**
  - [ ] Crear `src/models/device.py`
  - [ ] Crear `src/models/scene.py`
  - [ ] Crear `src/models/action_log.py`
  - [ ] Crear `src/models/metric.py`

### Fase 2: Servidores MCP IoT (40 horas) - CRÍTICO

**NOTA:** Estos son componentes NUEVOS que NO existen en mcp-client

- [ ] **Módulo: src/mcp-servers/lighting/**
  - [ ] Implementar `server.py` (RF-012) - 10h
  - [ ] Tool: `lighting_turn_on(device_id, brightness?, color?)`
  - [ ] Tool: `lighting_turn_off(device_id)`
  - [ ] Tool: `lighting_set_brightness(device_id, level)`
  - [ ] Tool: `lighting_set_color(device_id, color)`
  - [ ] Tool: `lighting_get_status(device_id?)`
  - [ ] Tests unitarios para cada tool

- [ ] **Módulo: src/mcp-servers/climate/**
  - [ ] Implementar `server.py` (RF-013) - 10h
  - [ ] Tool: `climate_set_temperature(zone, temperature)`
  - [ ] Tool: `climate_set_mode(zone, mode)`
  - [ ] Tool: `climate_get_current_temperature(zone?)`
  - [ ] Tool: `climate_get_humidity(zone?)`
  - [ ] Tool: `climate_get_status(zone?)`
  - [ ] Tests unitarios

- [ ] **Módulo: src/mcp-servers/security/**
  - [ ] Implementar `server.py` (RF-014) - 10h
  - [ ] Tool: `security_arm(mode)`
  - [ ] Tool: `security_disarm()`
  - [ ] Tool: `security_get_status()`
  - [ ] Tool: `security_get_camera_feed(camera_id)`
  - [ ] Tool: `security_get_motion_events(since?)`
  - [ ] Tests unitarios

- [ ] **Módulo: src/mcp-servers/entertainment/**
  - [ ] Implementar `server.py` (RF-015) - 10h
  - [ ] Tool: `entertainment_play(device_id)`
  - [ ] Tool: `entertainment_pause(device_id)`
  - [ ] Tool: `entertainment_set_volume(device_id, level)`
  - [ ] Tool: `entertainment_select_source(device_id, source)`
  - [ ] Tool: `entertainment_get_status(device_id?)`
  - [ ] Tests unitarios

### Fase 3: Conectores IoT (30 horas) - CRÍTICO

- [ ] **Módulo: src/mcp-servers/**
  - [ ] **lighting/**
    - [ ] Implementar `server.py` (RF-012)
    - [ ] Implementar tools: turn_on, turn_off, set_brightness, set_color, get_status
  - [ ] **climate/**
    - [ ] Implementar `server.py` (RF-013)
    - [ ] Implementar tools: set_temperature, set_mode, get_current_temp, get_status
  - [ ] **security/**
    - [ ] Implementar `server.py` (RF-014)
    - [ ] Implementar tools: arm, disarm, get_status, get_camera_feed
  - [ ] **entertainment/**
    - [ ] Implementar `server.py` (RF-015)
    - [ ] Implementar tools: play, pause, set_volume, select_source

- [ ] **Módulo: src/iot-connectors/**
  - [ ] Implementar `base_connector.py` (abstract base class)
  - [ ] Implementar `philips_hue_connector.py`
  - [ ] Implementar `nest_connector.py` o `ecobee_connector.py`
  - [ ] Implementar `generic_camera_connector.py` (ONVIF)
  - [ ] Implementar `sonos_connector.py` (opcional)
  - [ ] Implementar error handling común (RF-018)

- [ ] **Módulo: src/ui/**
  - [ ] Implementar `voice_interface.py` (STT con Whisper) (RF-019)
  - [ ] Implementar `text_interface.py` (CLI con Rich) (RF-020)
  - [ ] Implementar `speech_output.py` (TTS con Bark/Piper) (RF-021)
  - [ ] Implementar `text_output.py` (RF-022)
  - [ ] Implementar `web_admin.py` (FastAPI, opcional) (RF-023)

- [ ] **Módulo: src/shared/**
  - [ ] Implementar `models.py` (Pydantic models compartidos)
  - [ ] Implementar `database.py` (SQLAlchemy session management)
  - [ ] Implementar `logging_config.py` (RNF-025)
  - [ ] Implementar `utils.py` (funciones utilitarias)
  - [ ] Implementar `exceptions.py` (custom exceptions)

### Fase 3: Funcionalidades Avanzadas

- [ ] **Gestión de Escenas**
  - [ ] Implementar `scene_manager.py` (RF-024, RF-025, RF-026)
  - [ ] CRUD de escenas en base de datos
  - [ ] Ejecución coordinada de escenas

- [ ] **Administración**
  - [ ] Implementar `device_registry.py` (RF-027)
  - [ ] Implementar `server_manager.py` (RF-028)
  - [ ] Implementar `user_manager.py` (RF-029)
  - [ ] Implementar `metrics_collector.py` (RF-030)

- [ ] **Aprendizaje de Preferencias**
  - [ ] Implementar análisis de patrones (RF-031)
  - [ ] Implementar almacenamiento de preferencias (RF-032)
  - [ ] Implementar sugerencias proactivas (RF-033)

### Fase 4: Testing

- [ ] **Unit Tests**
  - [ ] Tests para llm-agent (>70% coverage)
  - [ ] Tests para mcp-coordinator (>70% coverage)
  - [ ] Tests para mcp-servers (>70% coverage)
  - [ ] Tests para iot-connectors (>70% coverage)
  - [ ] Tests para ui (>70% coverage)

- [ ] **Integration Tests**
  - [ ] Tests LLM Agent ↔ MCP Coordinator
  - [ ] Tests MCP Coordinator ↔ MCP Servers
  - [ ] Tests MCP Servers ↔ IoT Connectors
  - [ ] Tests end-to-end con mocks de dispositivos

- [ ] **System Tests**
  - [ ] Tests con dispositivos IoT reales (mínimo 3)
  - [ ] Tests de latencia y rendimiento (RNF-001, RNF-002)
  - [ ] Tests de seguridad (RNF-006 a RNF-010)
  - [ ] Tests de escalabilidad (RNF-029, RNF-030)

- [ ] **Acceptance Tests**
  - [ ] Escenarios de usuario según doc 08 (Plan de Pruebas)
  - [ ] Evaluación con usuarios reales (máximo 10)
  - [ ] Recopilación de métricas cualitativas (SUS)

### Fase 5: Optimización y Pulido

- [ ] **Optimizaciones de Rendimiento**
  - [ ] Profiling de código con cProfile
  - [ ] Optimización de queries de DB
  - [ ] Implementación de caché para respuestas comunes
  - [ ] Optimización de carga del LLM

- [ ] **Mejoras de UX**
  - [ ] Refinamiento de respuestas del LLM
  - [ ] Mejora de manejo de errores comprensibles
  - [ ] Implementación de feedback visual/auditivo

- [ ] **Documentación de Código**
  - [ ] Docstrings en todas las funciones públicas (>90%)
  - [ ] Type hints completos
  - [ ] README.md en cada módulo
  - [ ] Comentarios en código complejo

---

## 📊 Diagramas Pendientes

- [ ] **Diagrama de Casos de Uso** (doc 03)
- [ ] **Diagrama Entidad-Relación** (doc 05)
- [ ] **10 Diagramas de Secuencia** (doc 07)
- [ ] **Diagramas de arquitectura en PlantUML** (ya creados en doc 04, pero revisar si se generan correctamente)

---

## 📚 Referencias y Recursos

### Documentos Creados
- `docs/10-Glosario.md` - Términos y definiciones
- `docs/01-SRS-Especificacion-Requisitos.md` - Requisitos completos
- `docs/04-Arquitectura-Sistema.md` - Arquitectura C4 y decisiones

### Documentos del Anteproyecto
- `tesis/AlejandroMosquera_VictorRodríguez_Anteproyecto V.3.pdf` - Documento fuente

### Enlaces Útiles
- Model Context Protocol: https://modelcontextprotocol.io/
- LangChain Docs: https://python.langchain.com/
- LangGraph Docs: https://langchain-ai.github.io/langgraph/
- Ollama: https://ollama.ai/
- Llama Models: https://ai.meta.com/llama/

---

## 🎯 Próximos Pasos Inmediatos

### ✅ Fase de Documentación: COMPLETADA

**Logros:**
- ✅ 13/13 documentos principales completados (100%)
- ✅ Actualizaciones para reflejar uso de mcp-client (6 documentos)
- ✅ Nuevos documentos creados (Matriz Trazabilidad, Planificación, Manual Usuario)
- ✅ Trazabilidad completa: Objetivos → RF → HU → CU → Casos de Prueba
- ✅ Plan de desarrollo detallado (7 sprints, 150 horas)

### 📋 Siguiente Fase: IMPLEMENTACIÓN

**Sprint 0 - Fork y Setup de mcp-client (Semana 3, Enero 2025)**

Tareas inmediatas:
1. **Fork de mcp-client-cli** (0.5h)
   - Fork del repositorio https://github.com/adhikasp/mcp-client-cli
   - Clonar localmente
   - Renombrar a `smart-room-mcp`

2. **Configuración Inicial** (1h)
   - Actualizar `pyproject.toml` (nombre, autores, descripción)
   - Actualizar `README.md` con contexto SRCS
   - Crear branch `srcs-development`

3. **Análisis de Componentes** (2h)
   - Estudiar `cli.py`, `tool.py`, `config.py`, `memory.py`
   - Documentar en memoria qué se reutiliza y qué se crea
   - Identificar puntos de extensión

4. **Setup del Entorno** (2.5h)
   - Crear virtual environment Python 3.12+
   - Instalar dependencias de mcp-client
   - Configurar Ollama y descargar Llama 3.1
   - Probar CLI básico
   - Configurar pre-commit hooks (black, flake8, mypy)

**Criterio de Aceptación Sprint 0:**
- [ ] Fork funcional en GitHub
- [ ] CLI básico de mcp-client responde a comandos
- [ ] Llama 3.1 configurado en Ollama
- [ ] Documentación de componentes heredados completada

**Siguiente:** Sprint 1 - Servidores MCP IoT Parte 1 (Semanas 4-5)

---

## 📈 Métricas de Progreso

**Documentación:**
- **Completados: 13/13 (100%)** ✅ **FASE COMPLETADA**
  - Documentos base: 01-SRS, 02-HU, 03-CU, 04-Arq, 05-Datos, 06-APIs, 07-Secuencia, 08-Pruebas, 10-Glosario
  - ADR de base tecnológica: 00-ADR-Base-Tecnologica ✅
  - Documentos nuevos: 09-Matriz-Trazabilidad, 11-Planificacion-Detallada, 12-Manual-Usuario ✅
  - Actualizaciones: 6 documentos actualizados con estado de mcp-client ✅
- **Tiempo Invertido:** ~12 horas
- **Calidad:** 100% de trazabilidad desde objetivos hasta casos de prueba

**Implementación (Pendiente - Ajustado con mcp-client):**
- **Sprint 0: 0%** - Fork y setup de mcp-client (6h)
- **Sprint 1: 0%** - Servidores MCP Lighting + Climate (24h) - CRÍTICO
- **Sprint 2: 0%** - Servidores MCP Security + Entertainment + Conectores (24h) - CRÍTICO
- **Sprint 3: 0%** - Scene Manager + TTS Parte 1 (20h)
- **Sprint 4: 0%** - Escenas Avanzadas + TTS Parte 2 (20h)
- **Sprint 5: 0%** - Administración + Aprendizaje (28h)
- **Sprint 6: 0%** - Testing + Validación + Documentación Final (28h)

**Estimación de Tiempo FINAL:**
- **Documentación:** ✅ 12 horas (COMPLETADO)
- **Implementación:** ⏳ 150 horas (PENDIENTE)
  - Sprint 0: 6h
  - Sprint 1: 24h
  - Sprint 2: 24h
  - Sprint 3: 20h
  - Sprint 4: 20h
  - Sprint 5: 28h
  - Sprint 6: 28h
- **TOTAL: ~162 horas** (dentro de cronograma de 6 meses)
- **AHORRO por mcp-client:** ~90 horas (37.5% del tiempo original)

**Componentes Reutilizados de mcp-client (~40% del sistema):**
- ✅ Cliente MCP (tool.py)
- ✅ Agente LLM (cli.py + LangGraph)
- ✅ Configuración (config.py)
- ✅ Memoria (memory.py)
- ✅ Cache (storage.py)
- ✅ UI - STT/CLI (input.py, output.py, whisperVoiceInterface.py)
- ✅ Historial (AsyncSqliteSaver)

---

## 💡 Notas Importantes

1. **Priorizar según MoSCoW** (ver Apéndice B en doc 01):
   - Must Have: RF-001, RF-002, RF-004, RF-006, RF-007, RF-008, RF-012, RF-016, RF-019, RF-020, RF-022, RF-027
   - Should Have: Resto de RF principales
   - Could Have: Funcionalidades opcionales (RF-017, RF-021, RF-026)

2. **Validar con asesor** antes de continuar con implementación

3. **Mantener documentación sincronizada** con código

4. **Iterar**: No esperar a documentación perfecta antes de implementar

5. **Testing desde el inicio**: TDD cuando sea posible

---

**Última actualización:** Octubre 2025
**Responsables:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC
