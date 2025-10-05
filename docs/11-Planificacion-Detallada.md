# Planificación Detallada
## Smart Room Control System (SRCS)

**Universidad Tecnológica de Panamá**
**Facultad de Ingeniería de Sistemas Computacionales**

**Autores:** Alejandro Mosquera, Victor Rodríguez
**Versión:** 1.0
**Fecha:** Octubre 2025

---

## Tabla de Contenido

1. [Introducción](#1-introducción)
2. [Contexto y Base Tecnológica](#2-contexto-y-base-tecnológica)
3. [Cronograma General](#3-cronograma-general)
4. [Planificación por Sprints](#4-planificación-por-sprints)
5. [Asignación de Recursos](#5-asignación-de-recursos)
6. [Dependencias y Ruta Crítica](#6-dependencias-y-ruta-crítica)
7. [Gestión de Riesgos](#7-gestión-de-riesgos)
8. [Criterios de Aceptación y Hitos](#8-criterios-de-aceptación-y-hitos)

---

## 1. Introducción

### 1.1 Propósito

Este documento establece la planificación detallada para el desarrollo del Smart Room Control System (SRCS), definiendo la descomposición de tareas, asignación de recursos, cronograma y gestión de riesgos.

### 1.2 Alcance del Plan

El plan cubre el desarrollo completo del SRCS desde el fork de mcp-client hasta la entrega final, incluyendo:

- 11 sprints de desarrollo semanales (Sprint 0 a Sprint 10)
- ~162 horas de trabajo estimadas
- 11 semanas de duración (Octubre - Diciembre 2025)
- Documentación técnica completa
- Pruebas y validación con usuarios reales

### 1.3 Metodología

**Metodología Ágil - Scrum Adaptado:**
- Sprints de 2 semanas (excepto Sprint 0: 1 semana)
- Daily standups asincrónicos (por chat)
- Revisión semanal con asesor
- Retrospectivas al final de cada sprint
- Desarrollo iterativo e incremental

**Priorización MoSCoW:**
- **Must Have**: Funcionalidades críticas para MVP (Sprints 0-2)
- **Should Have**: Funcionalidades importantes (Sprints 3-4)
- **Could Have**: Funcionalidades opcionales (Sprint 5)
- **Won't Have**: Fuera del alcance inicial

---

## 2. Contexto y Base Tecnológica

### 2.1 Decisión Arquitectónica: Uso de mcp-client-cli

El proyecto se basa en un **fork de [mcp-client-cli](https://github.com/adhikasp/mcp-client-cli)**, lo que proporciona:

**Componentes Ya Implementados (~40% del sistema):**
- ✅ Cliente Coordinador MCP (McpToolkit)
- ✅ Agente LLM con LangChain/LangGraph
- ✅ Sistema de Memoria Persistente (SqliteStore)
- ✅ Interfaz STT con Whisper
- ✅ Interfaz CLI con Rich
- ✅ Sistema de Configuración (AppConfig)
- ✅ Cache de Herramientas MCP
- ✅ Historial de Conversaciones (AsyncSqliteSaver)

**Componentes Nuevos a Desarrollar (~60% del sistema):**
- ❌ 4 Servidores MCP IoT (lighting, climate, security, entertainment)
- ❌ 4 Conectores IoT (Philips Hue, Nest, Cameras, Sonos)
- ❌ Scene Manager (gestión de escenas)
- ❌ TTS (Text-to-Speech)
- ❌ Módulos de Administración
- ❌ Extensión de Base de Datos (4 tablas nuevas)

### 2.2 Impacto en Planificación

**Ahorro Estimado:**
- ~90 horas de desarrollo (37.5% del tiempo original)
- Reducción de riesgo técnico en componentes core
- Código base probado y documentado

**Nueva Estimación:**
- **Original (desde cero):** ~240 horas
- **Con mcp-client:** ~150 horas
- **Documentación adicional:** ~12 horas
- **TOTAL:** ~162 horas

---

## 3. Cronograma General

### 3.1 Línea de Tiempo del Proyecto

| Sprint | Período | Duración | Horas Est. | Objetivo Principal |
|--------|---------|----------|------------|--------------------|
| **Documentación** | Agosto-Octubre 2025 | 10 semanas | 12h | Documentación técnica completa ✅ |
| **Sprint 0** | Oct 7-13, 2025 | 1 semana | 6h | Fork y setup de mcp-client |
| **Sprint 1** | Oct 14-20, 2025 | 1 semana | 20h | BD + Servidor Lighting |
| **Sprint 2** | Oct 21-27, 2025 | 1 semana | 20h | Servidor Climate |
| **Sprint 3** | Oct 28 - Nov 3, 2025 | 1 semana | 20h | Servidor Security |
| **Sprint 4** | Nov 4-10, 2025 | 1 semana | 20h | Servidor Entertainment + IoT |
| **Sprint 5** | Nov 11-17, 2025 | 1 semana | 18h | Scene Manager |
| **Sprint 6** | Nov 18-24, 2025 | 1 semana | 18h | TTS con Piper |
| **Sprint 7** | Nov 25 - Dic 1, 2025 | 1 semana | 16h | Features avanzadas |
| **Sprint 8** | Dic 2-8, 2025 | 1 semana | 16h | Admin + Metrics |
| **Sprint 9** | Dic 9-15, 2025 | 1 semana | 12h | Testing completo |
| **Sprint 10** | Dic 16-22, 2025 | 1 semana | 12h | Validación usuarios |
| **Buffer Final** | Dic 23-25, 2025 | 3 días | 4h | Ajustes y entrega |

**Duración Total Desarrollo:** 11 semanas (Oct 7 - Dic 25, 2025)
**Duración Total Proyecto:** 6 meses (Agosto - Diciembre 2025)

### 3.2 Distribución de Esfuerzo por Sprint

```
Sprint 0:   6h  [====]
Sprint 1:  20h  [==============]
Sprint 2:  20h  [==============]
Sprint 3:  20h  [==============]
Sprint 4:  20h  [==============]
Sprint 5:  18h  [=============]
Sprint 6:  18h  [=============]
Sprint 7:  16h  [============]
Sprint 8:  16h  [============]
Sprint 9:  12h  [=========]
Sprint 10: 12h  [=========]
Buffer:     4h  [===]
Total:    182h (incluye 20h de buffer integrado)
```

### 3.3 Hitos Principales

| Hito | Fecha Objetivo | Entregable |
|------|---------------|------------|
| **M0** | Oct 5, 2025 | Documentación completa aprobada ✅ |
| **M1** | Oct 13, 2025 | Fork de mcp-client configurado y funcional |
| **M2** | Oct 27, 2025 | 2 servidores MCP IoT funcionando |
| **M3** | Nov 10, 2025 | 4 servidores MCP + IoT integrados |
| **M4** | Nov 24, 2025 | Scenes + TTS implementados |
| **M5** | Dic 8, 2025 | Features avanzadas + Admin completo |
| **M6** | Dic 25, 2025 | Sistema validado y entrega final |

---

## 4. Planificación por Sprints

### Sprint 0: Fork y Setup de mcp-client (Oct 7-13, 2025)

**Objetivo:** Configurar el entorno de desarrollo basado en mcp-client como fundación del SRCS.

**Duración:** 1 semana | **Esfuerzo:** 6 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S0.1 | Fork de repositorio mcp-client-cli y renombrar a `smart-room-mcp` | Alejandro | 1h |
| S0.2 | Actualizar pyproject.toml y README.md con contexto SRCS | Victor | 1h |
| S0.3 | Análisis profundo de código mcp-client (cli.py, tool.py, config.py, memory.py) | Ambos | 2h |
| S0.4 | Configurar entorno Python 3.12+ e instalar dependencias | Victor | 1h |
| S0.5 | Configurar Ollama, descargar Llama 3.1 y probar CLI básico | Alejandro | 1h |

#### Entregables & Criterios de Aceptación

- [ ] Repositorio `smart-room-mcp` funcional en GitHub con documentación actualizada
- [ ] Entorno Python 3.12+ configurado, todas las dependencias instaladas
- [ ] CLI básico responde a comandos simples
- [ ] Llama 3.1 configurado en Ollama y accesible desde el sistema

---

### Sprint 1: BD + Servidor Lighting (Oct 14-20, 2025)

**Objetivo:** Extender base de datos e implementar primer servidor MCP (Lighting).

**Duración:** 1 semana | **Esfuerzo:** 20 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S1.1 | Extender schema BD: tablas `devices`, `action_logs` + Alembic migrations | Alejandro | 4h |
| S1.2 | Crear modelos SQLAlchemy (Device, ActionLog) | Alejandro | 2h |
| S1.3 | Implementar `mcp-servers/lighting/server.py` con 5 tools (turn_on, turn_off, set_brightness, set_color, get_status) | Victor | 7h |
| S1.4 | Configurar servidor en `~/.llm/config.json` | Victor | 1h |
| S1.5 | Pruebas de integración con McpToolkit + Agente LLM | Ambos | 3h |
| S1.6 | Tests unitarios (>65% coverage) | Ambos | 3h |

#### Entregables & Criterios de Aceptación

- [ ] BD extendida con tablas nuevas + migraciones Alembic funcionales
- [ ] Servidor MCP Lighting completo con 5 tools funcionando
- [ ] Agente LLM puede descubrir y usar tools de lighting
- [ ] Acciones se registran en `action_logs` y dispositivos en `devices`
- [ ] Comando de voz "enciende la luz" funciona end-to-end

---

### Sprint 2: Servidor Climate (Oct 21-27, 2025)

**Objetivo:** Implementar segundo servidor MCP (Climate) y validar patrón de servidores.

**Duración:** 1 semana | **Esfuerzo:** 20 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S2.1 | Implementar `mcp-servers/climate/server.py` con 4 tools (set_temperature, set_mode, get_current_temp, get_status) | Alejandro | 7h |
| S2.2 | Configurar servidor Climate en config MCP | Alejandro | 1h |
| S2.3 | Pruebas de integración con 2 servidores simultáneos | Ambos | 4h |
| S2.4 | Tests unitarios Climate + tests multi-servidor | Ambos | 4h |
| S2.5 | Documentar patrón de creación de servidores MCP | Victor | 2h |
| S2.6 | Refactoring y optimización (DRY, code reuse) | Victor | 2h |

#### Entregables & Criterios de Aceptación

- [ ] Servidor MCP Climate completo y funcionando
- [ ] Sistema coordina 2 servidores MCP simultáneamente
- [ ] Comando "sube temperatura a 23°C y enciende luces" ejecuta correctamente
- [ ] Patrón de servidores MCP documentado para siguientes sprints
- [ ] Coverage de tests >65%

---

### Sprint 3: Servidor Security (Oct 28 - Nov 3, 2025)

**Objetivo:** Implementar tercer servidor MCP (Security) con funcionalidades de seguridad.

**Duración:** 1 semana | **Esfuerzo:** 20 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S3.1 | Implementar `mcp-servers/security/server.py` con 4 tools (arm, disarm, get_status, get_camera_feed) | Victor | 8h |
| S3.2 | Configurar servidor Security en config MCP | Victor | 1h |
| S3.3 | Implementar manejo de estados de seguridad (armed/disarmed/alarm) | Victor | 3h |
| S3.4 | Pruebas de integración con 3 servidores | Ambos | 3h |
| S3.5 | Tests unitarios Security | Ambos | 3h |
| S3.6 | Validar seguridad de comandos (autenticación básica) | Victor | 2h |

#### Entregables & Criterios de Aceptación

- [ ] Servidor MCP Security completo con gestión de estados
- [ ] Sistema coordina 3 servidores MCP de forma robusta
- [ ] Comandos de seguridad tienen validación de autenticación
- [ ] Comando "activa seguridad en modo noche" funciona
- [ ] Tests de seguridad (intentos no autorizados) pasan

---

### Sprint 4: Servidor Entertainment + Conectores IoT (Nov 4-10, 2025)

**Objetivo:** Completar 4to servidor MCP e integrar primer conector IoT real.

**Duración:** 1 semana | **Esfuerzo:** 20 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S4.1 | Implementar `mcp-servers/entertainment/server.py` con 4 tools (play/pause, set_volume, select_source, get_status) | Alejandro | 6h |
| S4.2 | Implementar `BaseConnector` (clase abstracta para conectores IoT) | Victor | 2h |
| S4.3 | Implementar `PhilipsHueConnector` (conector IoT real) | Victor | 5h |
| S4.4 | Integrar PhilipsHueConnector con servidor Lighting | Victor | 2h |
| S4.5 | Pruebas E2E con dispositivo Philips Hue real | Ambos | 2h |
| S4.6 | Tests unitarios Entertainment + conectores | Ambos | 3h |

#### Entregables & Criterios de Aceptación

- [ ] 4 servidores MCP completos e integrados
- [ ] `BaseConnector` define interfaz estándar para conectores IoT
- [ ] PhilipsHueConnector controla bombillo Hue real
- [ ] Sistema maneja errores de conectividad IoT gracefully
- [ ] Comando "pon las luces en azul" cambia color de Hue real
- [ ] **HITO M3**: Sistema MCP + IoT completamente integrado

### Sprint 5: Scene Manager (Nov 11-17, 2025)

**Objetivo:** Implementar gestión completa de escenas (crear, ejecutar, listar, eliminar).

**Duración:** 1 semana | **Esfuerzo:** 18 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S5.1 | Extender schema BD: tabla `scenes` + modelo SQLAlchemy | Alejandro | 2h |
| S5.2 | Implementar `scene_manager.py` - CRUD completo (create, get, list, update, delete) | Victor | 6h |
| S5.3 | Implementar ejecución coordinada de escenas (orquestación multi-servidor) | Victor | 4h |
| S5.4 | Crear servidor MCP `scene-manager` con tools MCP | Victor | 3h |
| S5.5 | Tests unitarios + integración (escenas con múltiples dispositivos) | Ambos | 3h |

#### Entregables & Criterios de Aceptación

- [ ] Scene Manager funcional con persistencia en BD
- [ ] Servidor MCP `scene-manager` integrado al sistema
- [ ] Usuario puede crear escena "Modo Cine" por voz (luces off, TV on)
- [ ] Escena ejecuta múltiples acciones coordinadas en orden correcto
- [ ] Escenas sobreviven reinicio del sistema
- [ ] Latencia de ejecución de escena < 3s

---

### Sprint 6: TTS con Piper (Nov 18-24, 2025)

**Objetivo:** Implementar Text-to-Speech para respuestas de voz del sistema.

**Duración:** 1 semana | **Esfuerzo:** 18 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S6.1 | Configurar Piper TTS en el sistema | Alejandro | 2h |
| S6.2 | Implementar `speech_output.py` - integración con output.py de mcp-client | Alejandro | 4h |
| S6.3 | Crear flag `--voice` para habilitar/deshabilitar TTS | Alejandro | 2h |
| S6.4 | Optimizar latencia de TTS (target <1.5s) | Alejandro | 3h |
| S6.5 | Implementar modo mixto (TTS + texto simultáneo) | Alejandro | 2h |
| S6.6 | Tests de audio (latencia, calidad, errores) | Ambos | 2h |
| S6.7 | Ajustar calidad de voz (prosody, velocidad) | Alejandro | 2h |
| S6.8 | Documentar uso de TTS en manual de usuario | Victor | 1h |

#### Entregables & Criterios de Aceptación

- [ ] TTS funcional con Piper configurado
- [ ] Flag `--voice` habilita respuestas por voz
- [ ] Latencia de TTS < 1.5s para respuestas típicas
- [ ] Calidad de voz es comprensible y natural
- [ ] Usuario puede elegir modo texto, voz, o ambos
- [ ] **HITO M4**: Scenes + TTS completamente funcionales

---

### Sprint 7: Features Avanzadas (Nov 25 - Dic 1, 2025)

**Objetivo:** Implementar funcionalidades avanzadas (triggers, condiciones, parámetros).

**Duración:** 1 semana | **Esfuerzo:** 16 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S7.1 | Implementar triggers básicos para escenas (tiempo programado) | Victor | 4h |
| S7.2 | Implementar condiciones simples (if-then) para escenas | Victor | 4h |
| S7.3 | Implementar escenas parametrizadas (scene_execute_with_params) | Victor | 3h |
| S7.4 | Optimizar TTS: caché de respuestas comunes | Alejandro | 2h |
| S7.5 | Tests de features avanzadas | Ambos | 2h |
| S7.6 | Documentar features avanzadas | Victor | 1h |

#### Entregables & Criterios de Aceptación

- [ ] Escenas pueden ejecutarse automáticamente (ej: a las 8 PM)
- [ ] Escenas con condiciones (ej: si temp < 18°C, subir calefacción)
- [ ] Escenas aceptan parámetros (ej: "modo cine" con volumen variable)
- [ ] TTS responde <1s para frases cacheadas
- [ ] Documentación explica cómo usar features avanzadas

---

### Sprint 8: Admin + Metrics (Dic 2-8, 2025)

**Objetivo:** Implementar módulos de administración y métricas del sistema.

**Duración:** 1 semana | **Esfuerzo:** 16 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S8.1 | Extender schema BD: tabla `system_metrics` | Alejandro | 1h |
| S8.2 | Implementar `device_registry.py` - CRUD de dispositivos | Victor | 4h |
| S8.3 | Implementar `metrics_collector.py` - latencia y uso | Alejandro | 5h |
| S8.4 | Implementar `user_preferences.py` - persistencia de preferencias | Alejandro | 2h |
| S8.5 | Crear servidor MCP `admin-tools` | Victor | 2h |
| S8.6 | Tests unitarios admin + metrics | Ambos | 2h |

#### Entregables & Criterios de Aceptación

- [ ] Device Registry con CRUD funcional
- [ ] Metrics Collector registra latencia de cada comando
- [ ] Preferencias de usuario se persisten y usan en contexto
- [ ] Admin puede ver dispositivos y métricas
- [ ] Reporte de métricas disponible (JSON)
- [ ] **HITO M5**: Sistema completo con admin y métricas

---

### Sprint 9: Testing Completo (Dic 9-15, 2025)

**Objetivo:** Testing exhaustivo del sistema (unitarios, integración, rendimiento, seguridad).

**Duración:** 1 semana | **Esfuerzo:** 12 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S9.1 | Completar tests unitarios (objetivo: >65% coverage) | Ambos | 4h |
| S9.2 | Tests de integración E2E (voz → LLM → MCP → IoT → respuesta) | Ambos | 3h |
| S9.3 | Tests de rendimiento (latencia <2s comandos simples) | Alejandro | 2h |
| S9.4 | Tests de seguridad (SQL injection, inputs maliciosos) | Victor | 1h |
| S9.5 | Tests de resiliencia (dispositivos offline, errores LLM) | Victor | 1h |
| S9.6 | Documentar resultados de testing | Ambos | 1h |

#### Entregables & Criterios de Aceptación

- [ ] Coverage de tests >65% en componentes críticos
- [ ] Todos los tests E2E pasan (5+ escenarios completos)
- [ ] Latencia promedio comandos simples <2s (20+ pruebas)
- [ ] Sistema maneja errores gracefully
- [ ] Informe de testing documentado

---

### Sprint 10: Validación con Usuarios (Dic 16-22, 2025)

**Objetivo:** Evaluar sistema con usuarios reales y finalizar documentación.

**Duración:** 1 semana | **Esfuerzo:** 12 horas

#### Tareas Principales

| ID | Tarea | Responsable | Horas |
|----|-------|-------------|-------|
| S10.1 | Reclutar 3-5 usuarios de prueba | Ambos | 0.5h |
| S10.2 | Preparar 5 escenarios de evaluación | Alejandro | 1h |
| S10.3 | Realizar sesiones de evaluación con usuarios | Ambos | 3h |
| S10.4 | Aplicar cuestionario SUS | Alejandro | 0.5h |
| S10.5 | Analizar resultados y hacer ajustes críticos | Ambos | 2h |
| S10.6 | Completar manual de usuario | Victor | 2h |
| S10.7 | Crear video demo (5-10 min) | Alejandro | 2h |
| S10.8 | Preparar presentación de defensa | Ambos | 1h |

#### Entregables & Criterios de Aceptación

- [ ] 3-5 usuarios completaron evaluación
- [ ] Puntaje SUS promedio >68
- [ ] Tasa de éxito comandos >80%
- [ ] Manual de usuario completo
- [ ] Video demo muestra funcionalidades principales
- [ ] Presentación de defensa lista

---

### Buffer Final (Dic 23-25, 2025)

**Objetivo:** Ajustes finales y entrega.

**Duración:** 3 días | **Esfuerzo:** 4 horas

#### Tareas

- Fixes de bugs críticos encontrados en evaluación
- Actualizar README.md final
- Revisión final de documentación
- Preparación para defensa
- **HITO M6**: ENTREGA FINAL - Dic 25, 2025

---

## 5. Asignación de Recursos

### 5.1 Equipo de Desarrollo

| Rol | Responsable | Dedicación | Horas/Semana |
|-----|-------------|------------|--------------|
| **Desarrollador Backend** | Alejandro Mosquera | 50% | ~10h/semana |
| **Desarrollador Full-Stack** | Victor Rodríguez | 50% | ~10h/semana |
| **Asesor Técnico** | Ing. Aris Castillo, MSC | Consultoría | ~1h/semana |

### 5.2 Distribución de Tareas por Integrante

#### Alejandro Mosquera (~81 horas)

**Áreas de Especialización:**
- Backend y base de datos
- Servidores MCP (Climate, Entertainment)
- TTS con Piper
- Métricas y administración

**Asignación Detallada:**
| Sprint | Tareas Principales | Horas |
|--------|-------------------|-------|
| Sprint 0 | Fork, setup, análisis de mcp-client | 3h |
| Sprint 1 | BD schema, migrations, modelos SQLAlchemy | 6h |
| Sprint 2 | Servidor Climate completo | 10h |
| Sprint 3 | Servidor Security (parcial) | 4h |
| Sprint 4 | Servidor Entertainment completo | 10h |
| Sprint 5 | Scene Manager - BD y soporte | 4h |
| Sprint 6 | **TTS con Piper - implementación completa** | 15h |
| Sprint 7 | Optimización TTS (caché) | 4h |
| Sprint 8 | Metrics Collector + User Preferences | 11h |
| Sprint 9 | Tests rendimiento | 4h |
| Sprint 10 | Evaluación usuarios + video demo | 6h |
| Buffer | Ajustes finales | 2h |
| **TOTAL** | | **~81h** |

#### Victor Rodríguez (~81 horas)

**Áreas de Especialización:**
- Servidores MCP (Lighting, Security)
- Conectores IoT (PhilipsHue)
- Scene Manager completo
- Testing y QA

**Asignación Detallada:**
| Sprint | Tareas Principales | Horas |
|--------|-------------------|-------|
| Sprint 0 | Setup entorno, documentación | 3h |
| Sprint 1 | Servidor Lighting completo + tests | 11h |
| Sprint 2 | Documentación patrones + refactoring | 8h |
| Sprint 3 | Servidor Security completo | 12h |
| Sprint 4 | BaseConnector + PhilipsHueConnector | 9h |
| Sprint 5 | **Scene Manager CRUD + ejecución** | 13h |
| Sprint 6 | Documentación TTS | 3h |
| Sprint 7 | Triggers + condiciones para escenas | 11h |
| Sprint 8 | Device Registry + Admin tools | 8h |
| Sprint 9 | Tests E2E + seguridad | 6h |
| Sprint 10 | Manual usuario + presentación defensa | 5h |
| Buffer | Ajustes finales | 2h |
| **TOTAL** | | **~81h** |

### 5.3 Responsabilidades Compartidas

**Ambos Integrantes:**
- Revisión de código (code reviews)
- Testing de integración
- Evaluación con usuarios
- Documentación final
- Preparación de defensa

---

## 6. Dependencias y Ruta Crítica

### 6.1 Diagrama de Dependencias

```
[Sprint 0: Fork Setup] (CRÍTICO)
         ↓
    ┌────┴────┐
    ↓         ↓
[S1: Servers 1-2] [S1: BD Extension] (CRÍTICO)
    ↓         ↓
    └────┬────┘
         ↓
[S2: Servers 3-4 + IoT Connectors] (CRÍTICO)
         ↓
    ┌────┴────┐
    ↓         ↓
[S3: Scenes] [S3: TTS] (IMPORTANTE)
    ↓         ↓
[S4: Advanced Scenes] [S4: TTS Optimization]
    ↓         ↓
    └────┬────┘
         ↓
    [S5: Admin + Learning]
         ↓
    [S6: Testing + Validation] (CRÍTICO)
```

### 6.2 Ruta Crítica (Critical Path)

La ruta crítica del proyecto es:

1. **Sprint 0** → 2. **Sprint 1** → 3. **Sprint 2** → 4. **Sprint 6**

**Justificación:**
- Sin Sprint 0, no hay base de código
- Sin Sprint 1, no hay servidores MCP ni BD
- Sin Sprint 2, no hay integración IoT real (requisito mínimo)
- Sprint 6 es obligatorio para entrega

**Sprints 3, 4, 5** son importantes pero no críticos para MVP:
- Escenas pueden ser implementadas manualmente vía config
- TTS es opcional (Could Have)
- Admin puede ser básico vía SQL directo

### 6.3 Dependencias Entre Tareas

| Tarea | Depende De | Tipo |
|-------|------------|------|
| S1.4 (Servidor Lighting) | S0.5 (Análisis mcp-client) | Dura |
| S1.6 (Config servidores) | S1.4, S1.5 (Servidores implementados) | Dura |
| S1.7 (Pruebas integración) | S1.6 | Dura |
| S2.6 (Integrar conectores) | S2.3, S2.4, S1.4, S1.5 | Dura |
| S3.4 (Ejecución escenas) | S2.6 (Servidores + conectores) | Dura |
| S5.4 (Análisis patrones) | S3.4 (Escenas ejecutándose) | Blanda |
| S6.2 (Tests E2E) | S2.6 (Sistema integrado) | Dura |
| S6.8 (Evaluación usuarios) | S6.2 (Tests pasando) | Dura |

**Dependencia Dura:** No se puede comenzar hasta que termine la tarea previa
**Dependencia Blanda:** Se puede comenzar, pero se completa mejor con la tarea previa

### 6.4 Holgura (Slack) por Sprint

| Sprint | Duración Planificada | Holgura | Total Disponible |
|--------|---------------------|---------|------------------|
| Sprint 0 | 1 semana | 0 días | 1 semana |
| Sprint 1 | 2 semanas | 2 días | 12 días |
| Sprint 2 | 2 semanas | 2 días | 12 días |
| Sprint 3 | 2 semanas | 3 días | 14 días |
| Sprint 4 | 2 semanas | 3 días | 14 días |
| Sprint 5 | 2 semanas | 3 días | 14 días |
| Sprint 6 | 4 semanas | 5 días | 23 días |

**Buffer Total:** ~18 días (~3.6 semanas) distribuidos a lo largo del proyecto

---

## 7. Gestión de Riesgos

### 7.1 Identificación de Riesgos

| ID | Riesgo | Probabilidad | Impacto | Severidad |
|----|--------|--------------|---------|-----------|
| R1 | Incompatibilidad de versiones de dependencias de mcp-client | Media | Alto | **ALTO** |
| R2 | Conectores IoT no funcionan con dispositivos reales | Alta | Alto | **CRÍTICO** |
| R3 | Latencia del LLM excede 2s consistentemente | Media | Medio | **MEDIO** |
| R4 | Dificultad para reclutar usuarios de prueba | Media | Medio | **MEDIO** |
| R5 | Retraso en entregas por carga académica | Alta | Medio | **MEDIO** |
| R6 | TTS consume demasiados recursos (CPU/RAM) | Media | Bajo | **BAJO** |
| R7 | Cambios en API de dispositivos IoT (Hue, Nest) | Baja | Alto | **MEDIO** |
| R8 | Pérdida de datos por error en migrations | Baja | Alto | **MEDIO** |

### 7.2 Estrategias de Mitigación

#### R1: Incompatibilidad de Dependencias

**Mitigación:**
- ✅ Usar `poetry` o `pipenv` para lock de versiones exactas
- ✅ Crear contenedor Docker con entorno reproducible
- ✅ Probar fork de mcp-client en Sprint 0 antes de continuar

**Contingencia:**
- Si incompatibilidad crítica: Re-implementar componentes afectados
- Tiempo buffer: 5-10 horas adicionales

#### R2: Conectores IoT No Funcionan

**Mitigación:**
- ✅ Adquirir dispositivos IoT ANTES de Sprint 2 (semana 5)
- ✅ Probar APIs de fabricantes con curl/Postman primero
- ✅ Implementar mocks para desarrollo sin hardware
- ✅ Tener plan B: usar simuladores IoT (Home Assistant)

**Contingencia:**
- Si Philips Hue falla: Cambiar a bombillos Tuya/Wyze
- Si todo falla: Demo con simuladores (reduce nota pero es aceptable)

#### R3: Latencia del LLM Excede 2s

**Mitigación:**
- ✅ Usar modelo Llama 3.1 (7B) en vez de 13B/70B
- ✅ Probar alternativas: Mistral, Phi-3
- ✅ Implementar caché de respuestas comunes
- ✅ Optimizar prompts para reducir tokens

**Contingencia:**
- Relaxar requisito a < 3s en casos complejos
- Documentar limitación en sección de RNF
- Usar Claude API en demo final (fast, pero requiere internet)

#### R4: Dificultad para Reclutar Usuarios

**Mitigación:**
- ✅ Comenzar reclutamiento en Semana 10 (no esperar a Sprint 6)
- ✅ Ofrecer incentivos (café, reconocimiento en tesis)
- ✅ Reclutar en clases de UTP, grupos de Facebook, familia

**Contingencia:**
- Mínimo aceptable: 5 usuarios (vs 10 ideal)
- Auto-evaluación exhaustiva si < 5 usuarios

#### R5: Retraso por Carga Académica

**Mitigación:**
- ✅ Planificar sprints considerando calendarios de exámenes
- ✅ Adelantar trabajo en semanas ligeras
- ✅ Comunicar delays al asesor proactivamente

**Contingencia:**
- Usar holgura de 18 días
- Reducir alcance de Sprints 3-4 (escenas avanzadas)
- Extender Sprint 6 si necesario (aún dentro de 6 meses)

#### R6: TTS Consume Muchos Recursos

**Mitigación:**
- ✅ Probar Piper (ligero) antes que Bark (pesado)
- ✅ Hacer TTS opcional (`--voice` flag)
- ✅ Usar servicios cloud (Google TTS) como alternativa

**Contingencia:**
- TTS marcado como "Could Have" - no crítico para aprobación
- Demo sin voz si recursos limitados

#### R7: Cambios en APIs de IoT

**Mitigación:**
- ✅ Usar librerías oficiales (phue, nest_thermostat) en vez de REST directo
- ✅ Monitorear changelogs de fabricantes

**Contingencia:**
- Actualizar conectores si cambio ocurre
- Documentar limitación temporal

#### R8: Pérdida de Datos en Migrations

**Mitigación:**
- ✅ Probar migrations en BD de prueba primero
- ✅ Backup de BD antes de cada migration
- ✅ Usar Alembic upgrade/downgrade

**Contingencia:**
- Restaurar desde backup
- Re-crear datos de prueba

### 7.3 Monitoreo de Riesgos

**Frecuencia:** Semanal en retrospectiva de sprint

**Responsable:** Ambos integrantes

**Métricas:**
- Velocidad de sprint (horas completadas vs planificadas)
- Cobertura de tests (target: >70%)
- Número de bugs críticos abiertos
- Latencia promedio de comandos

---

## 8. Criterios de Aceptación y Hitos

### 8.1 Definición de "Done" (DoD)

Una tarea se considera completa cuando:

- [ ] Código implementado y funciona según requisitos
- [ ] Tests unitarios escritos y pasando (>70% coverage)
- [ ] Code review completado por otro integrante
- [ ] Documentación actualizada (docstrings, README)
- [ ] Sin errores de linting (black, flake8, mypy)
- [ ] Integrado en rama `srcs-development` sin conflictos

### 8.2 Hitos y Entregables

#### M0: Documentación Completa (Semana 2)

**Entregables:**
- ✅ 10 documentos principales completados (01-SRS a 10-Glosario)
- ✅ ADR-001 de base tecnológica
- ✅ docs/09-Matriz-Trazabilidad.md
- ✅ docs/11-Planificacion-Detallada.md (este documento)
- ⏳ docs/12-Manual-Usuario.md

**Criterio de Aceptación:**
- Asesor aprueba documentación como base sólida para desarrollo

#### M1: Fork Funcional (Semana 3)

**Entregables:**
- ✅ Repositorio `smart-room-mcp` en GitHub
- ✅ CLI básico de mcp-client funcionando
- ✅ Documentación de componentes heredados

**Criterio de Aceptación:**
- CLI responde a comandos básicos
- Llama 3.1 en Ollama funciona

#### M2: Primer Servidor MCP Funcionando (Semana 7)

**Entregables:**
- ✅ Al menos 1 servidor MCP (Lighting) completamente funcional
- ✅ Integración con McpToolkit
- ✅ Tests unitarios pasando

**Criterio de Aceptación:**
- Usuario puede controlar luz con comando de voz
- Acción se registra en BD

#### M3: Sistema Integrado (Semana 11)

**Entregables:**
- ✅ 4 servidores MCP completos
- ✅ 2+ conectores IoT funcionando
- ✅ Control de dispositivos IoT reales
- ✅ Scene Manager básico

**Criterio de Aceptación:**
- Sistema controla 3+ dispositivos IoT reales
- Usuario puede crear y ejecutar escenas
- Latencia < 3s en comandos simples

#### M4: Funcionalidades Avanzadas (Semana 13)

**Entregables:**
- ✅ Scene Manager con triggers y condiciones
- 🔄 TTS funcional (opcional)
- ✅ Device Registry
- ✅ Metrics Collector

**Criterio de Aceptación:**
- Escenas se ejecutan automáticamente
- Métricas se recopilan y almacenan
- TTS responde en < 2s (si implementado)

#### M5: Sistema Validado (Semana 17)

**Entregables:**
- ✅ Suite de tests completa (>70% coverage)
- ✅ Evaluación con 5+ usuarios completada
- ✅ Informe de evaluación con métricas SUS
- ✅ Manual de usuario terminado

**Criterio de Aceptación:**
- SUS promedio > 68
- Tasa de éxito de comandos > 85%
- Latencia promedio < 2s
- Manual permite instalación autónoma

#### M6: Entrega Final (Semana 22)

**Entregables:**
- ✅ Código fuente completo en GitHub
- ✅ Documentación completa (13 documentos)
- ✅ Video demo (5-10 min)
- ✅ Presentación de defensa
- ✅ Informe final de tesis

**Criterio de Aceptación:**
- Sistema cumple con todos los requisitos "Must Have"
- Documentación aprobada por asesor
- Presentación preparada y ensayada

---

## 9. Métricas de Seguimiento

### 9.1 Métricas de Proceso

| Métrica | Objetivo | Frecuencia | Responsable |
|---------|----------|------------|-------------|
| Velocidad de Sprint (horas) | 20-28h/sprint | Semanal | Ambos |
| Burndown de tareas | Tendencia descendente | Diaria | Ambos |
| Bugs críticos abiertos | < 3 | Semanal | Ambos |
| Cobertura de tests | >70% | Por sprint | Ambos |
| Revisión de código (días) | < 2 días | Por PR | Ambos |

### 9.2 Métricas de Producto

| Métrica | Objetivo | Frecuencia | Herramienta |
|---------|----------|------------|-------------|
| Latencia comando simple | < 2s | Por sprint | Custom timer |
| Latencia escena | < 5s | Por sprint | Custom timer |
| Tasa de éxito de comandos | >85% | Por sprint | Logs de action_logs |
| Uptime de servidores MCP | >95% | Continua | Health checks |
| Uso de memoria (MB) | < 500MB | Por sprint | psutil |

### 9.3 Métricas de Calidad

| Métrica | Objetivo | Frecuencia | Herramienta |
|---------|----------|------------|-------------|
| Complejidad ciclomática | < 10 | Por commit | radon |
| Duplicación de código | < 3% | Semanal | pylint |
| Type hints coverage | >80% | Por sprint | mypy |
| Docstring coverage | >90% | Por sprint | interrogate |
| SUS Score | >68 | Sprint 6 | Cuestionario |

---

## 10. Comunicación y Colaboración

### 10.1 Canales de Comunicación

| Canal | Propósito | Frecuencia |
|-------|-----------|------------|
| WhatsApp/Telegram | Coordinación diaria | Diaria |
| Google Meet | Revisión semanal | Semanal |
| Email | Comunicación con asesor | Semanal |
| GitHub Issues | Tracking de bugs y features | Continua |
| GitHub PRs | Code review | Por feature |

### 10.2 Ceremonias Ágiles

**Daily Standup (Asincrónico):**
- Cada integrante reporta en chat:
  - ¿Qué hice ayer?
  - ¿Qué haré hoy?
  - ¿Tengo bloqueos?

**Sprint Review (Semanal):**
- Demostración de funcionalidades completadas
- Feedback del asesor
- Ajuste de plan si necesario

**Sprint Retrospective (Bi-semanal):**
- ¿Qué salió bien?
- ¿Qué salió mal?
- ¿Qué mejoraremos?

---

## 11. Herramientas y Tecnologías

### 11.1 Stack Tecnológico

**Heredado de mcp-client:**
- Python 3.12+
- LangChain + LangGraph
- SQLite + Alembic
- Rich (CLI)
- Whisper (STT)
- Ollama + Llama 3.1

**Nuevas Tecnologías:**
- Piper (TTS)
- phue (Philips Hue SDK)
- nest_thermostat (Nest SDK)
- pytest + pytest-asyncio (testing)
- black + flake8 + mypy (linting)

### 11.2 Herramientas de Desarrollo

- **IDE:** VS Code / PyCharm
- **Control de Versiones:** Git + GitHub
- **CI/CD:** GitHub Actions (opcional)
- **Gestión de Proyecto:** GitHub Projects / Notion
- **Documentación:** Markdown + PlantUML + Mermaid

---

## 12. Conclusiones

### 12.1 Resumen del Plan

Este plan de desarrollo detalla la implementación del SRCS en **7 sprints** (150 horas) aprovechando **mcp-client como base** (ahorro de 90 horas).

**Puntos Clave:**
- ✅ Fork de mcp-client reduce tiempo de desarrollo en 37.5%
- ✅ Ruta crítica: Sprint 0 → 1 → 2 → 6 (mínimo viable)
- ✅ Sprints 3-5 agregan funcionalidades avanzadas (Should/Could Have)
- ✅ 18 días de holgura distribuidos para manejar riesgos
- ✅ Evaluación con usuarios en Sprint 6 (requisito académico)

### 12.2 Próximos Pasos Inmediatos

1. **Semana 2 (actual):** Completar documentación restante (docs/12-Manual-Usuario.md)
2. **Semana 3:** Ejecutar Sprint 0 (fork y setup)
3. **Semana 4:** Iniciar Sprint 1 (primeros servidores MCP)

### 12.3 Compromiso del Equipo

Nos comprometemos a:
- 📅 Seguir el cronograma establecido con flexibilidad razonable
- 🧪 Mantener alta calidad de código (>70% test coverage)
- 📝 Documentar exhaustivamente el desarrollo
- 🔄 Comunicar proactivamente con el asesor
- 🎯 Entregar un sistema funcional y validado

---

## Apéndices

### Apéndice A: Glosario de Términos del Plan

- **Sprint:** Iteración de desarrollo de duración fija (1-4 semanas)
- **DoD (Definition of Done):** Criterios que debe cumplir una tarea para considerarse completa
- **Ruta Crítica:** Secuencia de tareas que determina la duración mínima del proyecto
- **Holgura (Slack):** Tiempo extra disponible en una tarea sin retrasar el proyecto
- **Burndown:** Gráfico que muestra trabajo restante vs tiempo
- **MoSCoW:** Priorización Must/Should/Could/Won't Have

### Apéndice B: Referencias

- [Documentación de mcp-client-cli](https://github.com/adhikasp/mcp-client-cli)
- [Scrum Guide](https://scrumguides.org/)
- [Atlassian Agile Coach](https://www.atlassian.com/agile)
- docs/00-ADR-Base-Tecnologica.md
- docs/01-SRS-Especificacion-Requisitos.md
- docs/09-Matriz-Trazabilidad.md

---

**Última actualización:** Octubre 2025
**Autores:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC
**Estado:** ✅ APROBADO PARA EJECUCIÓN - Cronograma Ajustado
