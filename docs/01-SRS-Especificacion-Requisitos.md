# Especificación de Requisitos de Software (SRS)
## Sistema Integral de Control Inteligente para Smart Rooms mediante MCP

**Universidad Tecnológica de Panamá**
**Facultad de Ingeniería de Sistemas Computacionales**
**Trabajo de Graduación - 2025**

**Autores:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC

**Versión:** 1.0
**Fecha:** Oct 2025
**Estado:** Borrador

---

## Historial de Revisiones

| Versión | Fecha | Autor(es) | Descripción |
|---------|-------|-----------|-------------|
| 1.0 | Oct 2025 | A. Mosquera, V. Rodríguez | Versión inicial del documento |

---

## Tabla de Contenido

1. [Introducción](#1-introducción)
   - 1.1 [Propósito](#11-propósito)
   - 1.2 [Alcance](#12-alcance)
   - 1.3 [Definiciones, Acrónimos y Abreviaciones](#13-definiciones-acrónimos-y-abreviaciones)
   - 1.4 [Referencias](#14-referencias)
   - 1.5 [Resumen del Documento](#15-resumen-del-documento)

2. [Descripción General](#2-descripción-general)
   - 2.1 [Perspectiva del Producto](#21-perspectiva-del-producto)
   - 2.2 [Funciones del Producto](#22-funciones-del-producto)
   - 2.3 [Características de los Usuarios](#23-características-de-los-usuarios)
   - 2.4 [Restricciones](#24-restricciones)
   - 2.5 [Supuestos y Dependencias](#25-supuestos-y-dependencias)

3. [Requisitos Específicos](#3-requisitos-específicos)
   - 3.1 [Requisitos Funcionales](#31-requisitos-funcionales)
   - 3.2 [Requisitos No Funcionales](#32-requisitos-no-funcionales)
   - 3.3 [Requisitos del Sistema](#33-requisitos-del-sistema)

4. [Apéndices](#4-apéndices)

---

## 1. Introducción

### 1.1 Propósito

Este documento especifica los requisitos de software para el **Sistema Integral de Control Inteligente para Smart Rooms mediante Agentes AI Intercomunicados con Model Context Protocol (MCP)**. El propósito es proporcionar una descripción completa y detallada de las funcionalidades, características y restricciones del sistema.

Este documento está dirigido a:
- Equipo de desarrollo (Alejandro Mosquera y Victor Rodríguez)
- Asesor del proyecto (Ing. Aris Castillo)
- Evaluadores académicos de la Universidad Tecnológica de Panamá
- Colaboradores de Mälardalen University
- Futuros mantenedores del sistema

### 1.2 Alcance

El sistema, denominado **Smart Room Control System (SRCS)**, será implementado como un prototipo funcional para demostración de concepto en el entorno Smart Room de la Universidad Tecnológica de Panamá o Mälardalen University.

**Objetivos principales del sistema:**

1. **Gestión Unificada**: Proveer control centralizado de dispositivos IoT heterogéneos (iluminación, climatización, seguridad, entretenimiento) mediante una arquitectura basada en MCP.

2. **Procesamiento Local**: Garantizar privacidad mediante el uso de un LLM ejecutado localmente (Llama) para procesamiento de lenguaje natural sin dependencia de servicios en la nube.

3. **Interacción Natural**: Permitir que los usuarios controlen el Smart Room mediante comandos de voz y texto en lenguaje natural, sin necesidad de aprender sintaxis técnica.

4. **Modularidad y Escalabilidad**: Facilitar la adición de nuevos dispositivos y subsistemas sin requerir modificaciones al núcleo del sistema.

5. **Adaptabilidad Contextual**: Aprender preferencias del usuario y ajustar comportamientos basándose en patrones de uso y contexto ambiental.

**Beneficios esperados:**

- Resolver la fragmentación actual en sistemas Smart Room
- Mejorar la experiencia de usuario mediante interacción natural
- Preservar la privacidad de datos personales
- Demostrar la viabilidad de MCP como protocolo estándar para comunicación entre agentes AI
- Establecer base para investigación futura en computación ubicua

**Fuera de alcance:**

- Desarrollo de dispositivos IoT físicos (se utilizarán dispositivos comerciales existentes)
- Integración con todos los dispositivos del Smart Room (mínimo 3 dispositivos)
- Desarrollo de modelos de IA personalizados (se utilizará Llama preentrenado)
- Despliegue en entorno de producción comercial
- Sistemas de alta disponibilidad o redundancia empresarial

### 1.3 Definiciones, Acrónimos y Abreviaciones

Ver documento: [10-Glosario.md](./10-Glosario.md)

Términos clave:
- **MCP**: Model Context Protocol
- **LLM**: Large Language Model (Modelo de Lenguaje Grande)
- **IoT**: Internet of Things (Internet de las Cosas)
- **NLP**: Natural Language Processing (Procesamiento de Lenguaje Natural)
- **HCI**: Human-Computer Interaction (Interacción Humano-Computadora)
- **UTP**: Universidad Tecnológica de Panamá
- **MDU**: Mälardalen University

### 1.4 Referencias

1. **Anteproyecto**: "Desarrollo de Sistema Integral de Control Inteligente para Smart Rooms mediante Agentes AI Intercomunicados con Model Context Protocol" - Mosquera & Rodríguez, 2025

2. **Model Context Protocol Specification** - Anthropic, 2024
   https://modelcontextprotocol.io/

3. **IEEE Std 830-1998** - IEEE Recommended Practice for Software Requirements Specifications

4. Torres-Hernandez, C. M., et al. (2025). Smart Homes: A meta-study on sense of security and home automation. Technologies, 13(8), 320.

5. Waheed, N., et al. (2023). Privacy-enhanced living: A local differential privacy approach to secure smart home data. arXiv:2304.07676

6. **Llama Documentation** - Meta AI

7. **LangChain Documentation** - https://python.langchain.com/

8. **Home Assistant Documentation** - https://www.home-assistant.io/docs/

### 1.5 Resumen del Documento

Este documento está organizado según el estándar IEEE 830-1998:

- **Sección 1** introduce el propósito, alcance y referencias del documento.
- **Sección 2** describe la perspectiva general del producto, sus funciones principales, usuarios y restricciones.
- **Sección 3** detalla los requisitos específicos: funcionales, no funcionales y del sistema.
- **Sección 4** contiene apéndices con información complementaria.

---

## 2. Descripción General

### 2.1 Perspectiva del Producto

El Smart Room Control System (SRCS) es un sistema nuevo que introduce una arquitectura innovadora basada en el Model Context Protocol para la gestión de Smart Rooms. Aunque existen sistemas comerciales como Google Home, Amazon Alexa y Apple HomeKit, este proyecto se diferencia por:

1. **Procesamiento Completamente Local**: A diferencia de los sistemas comerciales que dependen de la nube, SRCS opera enteramente en hardware local, garantizando privacidad.

2. **Protocolo Estandarizado**: Utiliza MCP como capa de abstracción para comunicación entre agentes, en lugar de APIs propietarias fragmentadas.

3. **LLM como Orquestador**: Emplea un modelo de lenguaje grande como cerebro central del sistema, permitiendo comprensión contextual avanzada.

**Relación con otros sistemas:**

- **MILA (2024)**: SRCS evoluciona el concepto de MILA (asistente de voz local desarrollado en UTP-MDU) incorporando arquitectura MCP modular en lugar de integración monolítica con Home Assistant.

- **Home Assistant**: SRCS puede integrarse con Home Assistant como una de sus plataformas de dispositivos IoT, pero no depende exclusivamente de ella.

#### 2.1.1 Base Tecnológica: mcp-client-cli

**Decisión Arquitectónica** (ver [00-ADR-Base-Tecnologica.md](./00-ADR-Base-Tecnologica.md#adr-001-uso-de-mcp-client-cli-como-base-del-proyecto)):

SRCS se construye sobre **[mcp-client-cli](https://github.com/adhikasp/mcp-client-cli)** mediante **fork y extensión**, reutilizando aproximadamente **40% de los requisitos funcionales** (13/33 RF) ya implementados en el proyecto base.

**Componentes Heredados de mcp-client:**

| Componente | Implementado en mcp-client | Requisitos Cubiertos |
|------------|---------------------------|----------------------|
| Cliente Coordinador MCP | ✅ `tool.py` (McpToolkit) | RF-007, RF-008, RF-011 |
| Agente LLM con LangChain/LangGraph | ✅ `cli.py` (create_react_agent) | RF-001, RF-002, RF-004, RF-006 |
| Sistema de Memoria Persistente | ✅ `memory.py` (SqliteStore) | RF-032 |
| Interfaz STT con Whisper | ✅ `whisperVoiceInterface.py` | RF-019 |
| Interfaz CLI con Rich | ✅ `output.py`, `input.py` | RF-020, RF-022 |
| Sistema de Configuración | ✅ `config.py` (AppConfig) | RF-028 (parcial) |
| Cache de Herramientas MCP | ✅ `storage.py` (24h TTL) | RF-011 |
| Historial de Conversaciones | ✅ AsyncSqliteSaver (LangGraph) | Soporte para continuación |

**Componentes Nuevos a Desarrollar en SRCS (~60% del proyecto):**

| Componente | Estado | Requisitos a Implementar |
|------------|--------|-------------------------|
| Servidores MCP IoT | ❌ Pendiente | RF-012 a RF-015 (CRÍTICO) |
| Conectores IoT | ❌ Pendiente | RF-016 a RF-018 (CRÍTICO) |
| TTS para voz | ❌ Pendiente | RF-021 |
| Gestión de Escenas | ❌ Pendiente | RF-024 a RF-026 |
| Administración Sistema | ❌ Pendiente | RF-027, RF-029, RF-030 |
| Aprendizaje de Preferencias | ❌ Pendiente | RF-031, RF-033 |
| Extensión de Base de Datos | ❌ Pendiente | Tablas: devices, scenes, action_logs, system_metrics |

**Impacto en Requisitos:**

- **Requisitos Funcionales Implementados**: RF-001, RF-002, RF-004, RF-006, RF-007, RF-008, RF-011, RF-019, RF-020, RF-022, RF-028 (parcial), RF-032
- **Requisitos Funcionales Pendientes**: RF-003, RF-005, RF-009, RF-010, RF-012 a RF-018, RF-021, RF-023 a RF-027, RF-029 a RF-031, RF-033
- **Ahorro Estimado**: ~90 horas de desarrollo (37.5% del tiempo total)
- **Estrategia**: Fork del repositorio + creación de servidores MCP especializados para IoT

**Arquitectura de alto nivel:**

```
┌─────────────────────────────────────────────────────────────┐
│                     Usuario                                 │
│              (Voz / Texto / Interfaz Web)                   │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│            Interfaz de Usuario (UI Module)                  │
│         ┌───────────────┬───────────────────────┐           │
│         │ STT (Whisper) │ TTS (Bark/Piper)      │           │
│         └───────────────┴───────────────────────┘           │ 
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│          Agente AI Central (LLM - Llama Local)              │
│   ┌──────────────────────────────────────────────────┐      │
│   │  • Procesamiento de Lenguaje Natural (NLP)│      │      │
│   │  • Toma de decisiones contextuales               │      │
│   │  • Integración de información multi-fuente       │      │
│   │  • Coordinación de acciones complejas            │      │
│   └──────────────────────────────────────────────────┘      │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌───────────────────────────────────────────────────────────┐
│         Cliente Coordinador MCP                           │
│   ┌──────────────────────────────────────────────────┐    │
│   │  • Descubrimiento de servidores MCP              │    │
│   │  • Invocación de herramientas (tools)            │    │
│   │  • Consolidación de respuestas                   │    │
│   │  • Gestión de estado y contexto                  │    │
│   └──────────────────────────────────────────────────┘    │
└────────────┬──────────────────┬─────────────┬────────────────┘
             │                  │             │
    ┌────────┴───┐          ┌───┴───────┐     └─────────┐
    │            │          │           │               │
┌───▼─────┐ ┌────▼─────┐ ┌──▼────┐ ┌────▼──────┐ ┌──────▼─────┐
│  MCP    │ │   MCP    │ │  MCP  │ │   MCP     │ │    MCP     │
│ Lighting│ │ Climate  │ │ Secur.│ │ Entertain │ │ Custom...  │
│ Server  │ │ Server   │ │ Server│ │  Server   │ │  Server    │
└───┬─────┘ └───┬──────┘ └──┬────┘ └───┬────────┘ └────┬──────┘
    │           │           │          │               │
┌───▼───────────▼───────────▼──────────▼───────────────▼───┐
│            Conectores IoT (Adapters)                     │
│  ┌──────────┐  ┌──────────┐  ┌────────┐  ┌──────────┐    │
│  │Philips   │  │  Nest/   │  │ Camera │  │  Sonos   │    │
│  │  Hue     │  │ Ecobee   │  │ System │  │  /Spotify│    │
│  └────┬─────┘  └────┬─────┘  └───┬────┘  └────┬─────┘    │
└───────┼─────────────┼────────────┼────────────┼──────────┘
        │             │            │            │
┌───────▼─────────────▼────────────▼────────────▼──────────┐
│          Dispositivos IoT Físicos                        │
│  (Luces, Termostatos, Cámaras, Speakers, etc.)           │
└──────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│            Capa de Persistencia                         │
│  ┌──────────────┬────────────────┬──────────────────┐   │
│  │ SQLite DB    │ Config Files   │ Conversation Log │   │
│  │ (user prefs) │ (MCP servers)  │ (LangGraph)      │   │
│  └──────────────┴────────────────┴──────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

### 2.2 Funciones del Producto

El sistema proporciona las siguientes funciones principales:

**F1. Control de Dispositivos por Lenguaje Natural**
- Interpretación de comandos de voz o texto en español/inglés
- Ejecución de acciones en dispositivos IoT (encender/apagar, ajustar niveles, cambiar modos)
- Confirmación de acciones ejecutadas

**F2. Gestión de Escenas y Rutinas**
- Creación de escenas predefinidas (ej: "modo cine", "modo lectura")
- Activación de múltiples dispositivos coordinadamente
- Personalización de escenas por usuario

**F3. Consulta de Estado**
- Obtención de estado actual de dispositivos y ambiente
- Consulta de consumo energético
- Historial de activaciones y uso

**F4. Aprendizaje de Preferencias**
- Identificación de patrones de uso recurrentes
- Sugerencias proactivas basadas en contexto (hora, día, actividad)
- Ajuste automático según preferencias aprendidas

**F5. Gestión de Dispositivos**
- Registro y configuración de nuevos dispositivos IoT
- Descubrimiento automático de dispositivos compatibles
- Actualización de configuraciones

**F6. Administración del Sistema**
- Configuración de servidores MCP
- Monitoreo de rendimiento y logs
- Gestión de usuarios y permisos

### 2.3 Características de los Usuarios

El sistema está diseñado para tres perfiles de usuario principales:

#### Usuario Final (Ocupante del Smart Room)

**Características:**
- **Nivel técnico**: No requiere conocimientos técnicos
- **Frecuencia de uso**: Diario, múltiples veces al día
- **Edad**: 18-65 años
- **Idioma**: Español o Inglés
- **Experiencia**: Puede o no tener experiencia previa con asistentes de voz

**Objetivos:**
- Controlar ambiente de forma natural y rápida
- Crear ambientes personalizados
- No preocuparse por configuraciones técnicas

**Tareas típicas:**
- "Enciende las luces del salón"
- "Sube la temperatura a 22 grados"
- "Activa modo cine"

#### Administrador del Sistema

**Características:**
- **Nivel técnico**: Conocimientos intermedios-avanzados en sistemas
- **Frecuencia de uso**: Ocasional (configuración inicial y mantenimiento)
- **Edad**: 20-50 años
- **Experiencia**: Familiaridad con conceptos de IoT y redes

**Objetivos:**
- Configurar y mantener el sistema operativo
- Agregar nuevos dispositivos
- Resolver problemas técnicos

**Tareas típicas:**
- Registrar nuevo dispositivo Philips Hue
- Configurar servidor MCP para subsistema de seguridad
- Revisar logs de errores

#### Desarrollador / Investigador

**Características:**
- **Nivel técnico**: Avanzado en desarrollo de software e IA
- **Frecuencia de uso**: Durante desarrollo y experimentación
- **Experiencia**: Conocimientos de Python, APIs REST, LLMs

**Objetivos:**
- Extender funcionalidad del sistema
- Experimentar con nuevos modelos de IA
- Integrar nuevos protocolos de dispositivos

**Tareas típicas:**
- Crear nuevo servidor MCP para subsistema personalizado
- Afinar el LLM con comandos específicos del dominio
- Desarrollar conectores para nuevas marcas de dispositivos

### 2.4 Restricciones

**Restricciones Tecnológicas:**

- **RT-1**: El sistema debe operar completamente offline sin requerir conexión a internet para funcionalidades core.
- **RT-2**: El procesamiento del LLM debe ejecutarse en hardware local con especificaciones mínimas definidas (ver sección 3.3).
- **RT-3**: Debe usar Model Context Protocol según especificación oficial de Anthropic.
- **RT-4**: El LLM debe ser un modelo open-source (preferentemente Llama de Meta).
- **RT-5**: La arquitectura debe ser modular permitiendo reemplazo de componentes individuales.

**Restricciones de Hardware:**

- **RH-1**: El sistema debe funcionar en un único servidor físico (no arquitectura distribuida).
- **RH-2**: Debe soportar mínimo 3 dispositivos IoT simultáneos.
- **RH-3**: GPU NVIDIA con mínimo 12GB VRAM para inferencia del LLM.

**Restricciones de Tiempo:**

- **RTe-1**: El proyecto debe completarse en 6 meses (según cronograma del anteproyecto).
- **RTe-2**: La latencia de procesamiento de comandos no debe exceder 2 segundos.

**Restricciones Regulatorias:**

- **RR-1**: Cumplimiento con principios de privacidad (no envío de datos personales a la nube).
- **RR-2**: Conformidad con regulaciones de dispositivos IoT en espacios educativos.

**Restricciones de Alcance (según anteproyecto):**

- **RA-1**: Prototipo para demostración de concepto, no producto comercial.
- **RA-2**: Pruebas con máximo 10 usuarios.
- **RA-3**: Evaluación limitada a escenarios de uso básicos predefinidos.
- **RA-4**: No incluye desarrollo de dispositivos IoT físicos.

### 2.5 Supuestos y Dependencias

**Supuestos:**

- **S-1**: La infraestructura Smart Room de UTP será instalada según lo planificado por el programa Erasmus+.
- **S-2**: Como plan B, la infraestructura de MDU estará disponible para desarrollo y pruebas.
- **S-3**: Los dispositivos IoT comerciales tienen APIs públicas documentadas.
- **S-4**: El modelo Llama puede ejecutar inferencia con latencia aceptable en hardware disponible.
- **S-5**: Los usuarios finales hablan español o inglés con fluidez.
- **S-6**: Existe conectividad de red local confiable entre dispositivos IoT y servidor.

**Dependencias:**

- **D-1**: **Llama (Meta AI)** - Modelo de lenguaje grande open-source
- **D-2**: **Ollama** - Framework para ejecución local de LLMs
- **D-3**: **LangChain** - Framework para orquestación de LLMs
- **D-4**: **LangGraph** - Framework para agentes con estado
- **D-5**: **Model Context Protocol SDK** - Librería oficial de MCP
- **D-6**: **Whisper (OpenAI)** - Modelo STT para reconocimiento de voz
- **D-7**: **Bark/Piper** - Modelos TTS para síntesis de voz
- **D-8**: **SQLite** - Base de datos para persistencia
- **D-9**: **Python 3.12+** - Lenguaje de implementación principal
- **D-10**: **Home Assistant** (opcional) - Como plataforma de integración de dispositivos
- **D-11**: **Dispositivos IoT compatibles** - Philips Hue, Nest/Ecobee, cámaras IP, sistemas de audio inteligentes

---

## 3. Requisitos Específicos

### 3.1 Requisitos Funcionales

Los requisitos funcionales están organizados por subsistema del Smart Room Control System.

#### 3.1.1 Agente AI Central (LLM)

**RF-001: Procesamiento de Lenguaje Natural**
- **Descripción**: El sistema debe interpretar comandos en lenguaje natural (español e inglés) y extraer intención y entidades.
- **Entrada**: Texto o transcripción de voz con comando del usuario
- **Procesamiento**:
  - Análisis sintáctico y semántico
  - Identificación de intención (controlar dispositivo, consultar estado, crear escena, etc.)
  - Extracción de entidades (dispositivo, acción, parámetros)
- **Salida**: Estructura de comando con intención y parámetros
- **Prioridad**: Alta
- **Dependencias**: Llama, LangChain

**RF-002: Toma de Decisiones Contextuales**
- **Descripción**: El LLM debe tomar decisiones considerando contexto temporal, ambiental y preferencias del usuario.
- **Entrada**: Comando del usuario + contexto (hora, fecha, estado actual, historial)
- **Procesamiento**:
  - Recuperación de contexto relevante
  - Aplicación de reglas de negocio
  - Consideración de preferencias aprendidas
- **Salida**: Plan de acción con dispositivos y acciones a ejecutar
- **Prioridad**: Alta
- **Dependencias**: RF-001, RF-014 (gestión de memoria)

**RF-003: Manejo de Ambigüedad**
- **Descripción**: El sistema debe detectar comandos ambiguos y solicitar aclaración al usuario.
- **Entrada**: Comando ambiguo (ej: "enciende la luz" cuando hay múltiples luces)
- **Procesamiento**:
  - Detección de múltiples interpretaciones posibles
  - Generación de pregunta de aclaración
- **Salida**: Solicitud de aclaración al usuario o selección basada en contexto
- **Ejemplo**:
  - Usuario: "Enciende la luz"
  - Sistema: "¿Cuál luz deseas encender: sala, cocina o habitación?"
- **Prioridad**: Media
- **Dependencias**: RF-001, RF-002

**RF-004: Generación de Respuestas en Lenguaje Natural**
- **Descripción**: El sistema debe generar respuestas conversacionales confirmando acciones o reportando errores.
- **Entrada**: Resultado de ejecución de comando
- **Procesamiento**: Generación de texto natural explicando resultado
- **Salida**: Respuesta en lenguaje natural (texto o voz)
- **Ejemplo**:
  - Éxito: "He encendido las luces del salón al 70%"
  - Error: "No pude ajustar la temperatura porque el termostato no responde"
- **Prioridad**: Alta
- **Dependencias**: RF-001

**RF-005: Coordinación de Acciones Complejas**
- **Descripción**: El sistema debe coordinar múltiples acciones secuenciales o paralelas para comandos compuestos.
- **Entrada**: Comando compuesto (ej: "activa modo cine")
- **Procesamiento**:
  - Descomposición en acciones atómicas
  - Determinación de orden de ejecución (secuencial/paralelo)
  - Coordinación mediante Cliente MCP
- **Salida**: Secuencia de llamadas a herramientas MCP
- **Ejemplo**: "modo cine" → atenuar luces + cerrar cortinas + encender TV + ajustar audio
- **Prioridad**: Alta
- **Dependencias**: RF-002, RF-006

**RF-006: Orquestación de Servidores MCP**
- **Descripción**: El LLM debe seleccionar y orquestar los servidores MCP apropiados para cada tarea.
- **Entrada**: Plan de acción con dispositivos objetivo
- **Procesamiento**:
  - Mapeo de dispositivos a servidores MCP responsables
  - Construcción de solicitudes de herramientas
  - Envío a Cliente Coordinador MCP
- **Salida**: Invocaciones de herramientas en servidores MCP correctos
- **Prioridad**: Alta
- **Dependencias**: RF-002, RF-007

#### 3.1.2 Cliente Coordinador MCP

**RF-007: Descubrimiento de Servidores MCP**
- **Descripción**: El sistema debe descubrir y conectar con todos los servidores MCP configurados al inicio.
- **Entrada**: Archivo de configuración con servidores MCP
- **Procesamiento**:
  - Lectura de configuración
  - Establecimiento de conexión con cada servidor (stdio)
  - Listado de herramientas disponibles
  - Caching de capacidades
- **Salida**: Registro de servidores MCP activos y sus herramientas
- **Prioridad**: Alta
- **Dependencias**: Ninguna

**RF-008: Invocación de Herramientas MCP**
- **Descripción**: El sistema debe invocar herramientas en servidores MCP según indicaciones del LLM.
- **Entrada**: Solicitud de invocación de herramienta con nombre y parámetros
- **Procesamiento**:
  - Validación de parámetros según schema de herramienta
  - Envío de solicitud JSON-RPC 2.0 al servidor MCP
  - Espera de respuesta con timeout
- **Salida**: Resultado de herramienta o error
- **Prioridad**: Alta
- **Dependencias**: RF-007

**RF-009: Gestión de Estado de Conexiones**
- **Descripción**: El sistema debe monitorear estado de conexiones con servidores MCP y reconectar si es necesario.
- **Entrada**: Heartbeat o timeout de servidor MCP
- **Procesamiento**:
  - Detección de desconexión
  - Intento de reconexión con backoff exponencial
  - Notificación al LLM si servidor no disponible
- **Salida**: Estado actualizado de conexiones
- **Prioridad**: Media
- **Dependencias**: RF-007

**RF-010: Consolidación de Respuestas**
- **Descripción**: El sistema debe consolidar respuestas de múltiples servidores MCP en una respuesta unificada.
- **Entrada**: Múltiples respuestas de herramientas MCP
- **Procesamiento**:
  - Agregación de resultados
  - Detección de conflictos o errores parciales
  - Construcción de respuesta consolidada
- **Salida**: Respuesta unificada para el LLM
- **Prioridad**: Media
- **Dependencias**: RF-008

**RF-011: Caché de Capacidades de Servidores**
- **Descripción**: El sistema debe cachear las capacidades (herramientas, recursos) de servidores MCP para optimizar rendimiento.
- **Entrada**: Listado de herramientas de servidor MCP
- **Procesamiento**:
  - Almacenamiento en memoria con TTL
  - Invalidación al detectar cambios en servidor
- **Salida**: Caché de capacidades actualizada
- **Prioridad**: Baja
- **Dependencias**: RF-007

#### 3.1.3 Servidores MCP Especializados

**RF-012: Servidor MCP de Iluminación**
- **Descripción**: Servidor MCP que expone herramientas para control de iluminación.
- **Herramientas requeridas**:
  - `lighting_turn_on(device_id, brightness?, color?)`: Encender luz
  - `lighting_turn_off(device_id)`: Apagar luz
  - `lighting_set_brightness(device_id, level)`: Ajustar brillo (0-100)
  - `lighting_set_color(device_id, color)`: Cambiar color (RGB o nombre)
  - `lighting_get_status(device_id?)`: Obtener estado de luz(es)
- **Recursos**: Estado actual de todas las luces
- **Prioridad**: Alta
- **Dependencias**: RF-016 (conectores IoT)

**RF-013: Servidor MCP de Climatización**
- **Descripción**: Servidor MCP que expone herramientas para control de temperatura y ventilación.
- **Herramientas requeridas**:
  - `climate_set_temperature(zone, temperature)`: Ajustar temperatura objetivo
  - `climate_set_mode(zone, mode)`: Cambiar modo (heat/cool/auto/fan/off)
  - `climate_get_current_temperature(zone?)`: Obtener temperatura actual
  - `climate_get_humidity(zone?)`: Obtener humedad
  - `climate_get_status(zone?)`: Obtener estado completo
- **Recursos**: Estado de termostatos, configuración de zonas
- **Prioridad**: Alta
- **Dependencias**: RF-016

**RF-014: Servidor MCP de Seguridad**
- **Descripción**: Servidor MCP que expone herramientas para sistema de seguridad y cámaras.
- **Herramientas requeridas**:
  - `security_arm(mode)`: Armar sistema (home/away/night)
  - `security_disarm()`: Desarmar sistema
  - `security_get_status()`: Obtener estado del sistema
  - `security_get_camera_feed(camera_id)`: Obtener stream de cámara
  - `security_get_motion_events(since?)`: Obtener eventos de movimiento
- **Recursos**: Estado de alarma, eventos de seguridad, configuración de cámaras
- **Prioridad**: Media
- **Dependencias**: RF-016

**RF-015: Servidor MCP de Entretenimiento**
- **Descripción**: Servidor MCP que expone herramientas para control de sistemas de audio/video.
- **Herramientas requeridas**:
  - `entertainment_play(device_id)`: Reproducir
  - `entertainment_pause(device_id)`: Pausar
  - `entertainment_set_volume(device_id, level)`: Ajustar volumen (0-100)
  - `entertainment_select_source(device_id, source)`: Cambiar fuente (TV/HDMI/Cast)
  - `entertainment_get_status(device_id?)`: Obtener estado
- **Recursos**: Estado de reproductores, playlist, fuentes disponibles
- **Prioridad**: Media
- **Dependencias**: RF-016

#### 3.1.4 Conectores IoT

**RF-016: Conectores para Dispositivos Específicos**
- **Descripción**: El sistema debe incluir conectores (adapters) que traduzcan comandos MCP a APIs de dispositivos específicos.
- **Conectores requeridos**:
  - Philips Hue (API REST)
  - Nest/Ecobee (API REST)
  - Cámaras IP (RTSP/ONVIF)
  - Sonos/Spotify (API REST)
- **Procesamiento**:
  - Traducción de parámetros MCP a formato API nativa
  - Autenticación con dispositivo
  - Manejo de errores específicos de dispositivo
- **Salida**: Respuesta estandarizada al servidor MCP
- **Prioridad**: Alta
- **Dependencias**: Ninguna

**RF-017: Descubrimiento Automático de Dispositivos**
- **Descripción**: El sistema debe poder descubrir automáticamente dispositivos IoT compatibles en la red local.
- **Entrada**: Escaneo de red local
- **Procesamiento**:
  - Escaneo de puertos y protocolos comunes (mDNS, UPnP)
  - Identificación de tipo de dispositivo
  - Registro automático con configuración mínima
- **Salida**: Lista de dispositivos descubiertos
- **Prioridad**: Baja
- **Dependencias**: RF-016

**RF-018: Manejo de Errores de Dispositivos**
- **Descripción**: El sistema debe manejar errores de dispositivos (offline, timeout, comando inválido) y reportarlos apropiadamente.
- **Entrada**: Error de comunicación con dispositivo
- **Procesamiento**:
  - Clasificación de error
  - Reintentos con backoff si aplicable
  - Generación de mensaje de error comprensible
- **Salida**: Error estandarizado al servidor MCP
- **Prioridad**: Media
- **Dependencias**: RF-016

#### 3.1.5 Interfaz de Usuario

**RF-019: Entrada por Voz**
- **Descripción**: El sistema debe aceptar comandos de voz mediante micrófono.
- **Entrada**: Audio del micrófono
- **Procesamiento**:
  - Detección de activación (wake word o botón push-to-talk)
  - Conversión speech-to-text con Whisper
  - Envío de texto al LLM
- **Salida**: Transcripción de comando
- **Prioridad**: Alta
- **Dependencias**: Whisper

**RF-020: Entrada por Texto**
- **Descripción**: El sistema debe aceptar comandos de texto mediante interfaz CLI o web.
- **Entrada**: Texto escrito por usuario
- **Procesamiento**: Envío directo al LLM
- **Salida**: Confirmación de recepción
- **Prioridad**: Alta
- **Dependencias**: RF-001

**RF-021: Salida por Voz**
- **Descripción**: El sistema debe responder al usuario mediante voz sintetizada.
- **Entrada**: Texto de respuesta del LLM
- **Procesamiento**:
  - Conversión text-to-speech con Bark/Piper
  - Reproducción de audio
- **Salida**: Audio de respuesta
- **Prioridad**: Media
- **Dependencias**: Bark/Piper, RF-004

**RF-022: Salida por Texto**
- **Descripción**: El sistema debe mostrar respuestas en texto en interfaz CLI o web.
- **Entrada**: Texto de respuesta del LLM
- **Procesamiento**: Formateo para display
- **Salida**: Texto mostrado al usuario
- **Prioridad**: Alta
- **Dependencias**: RF-004

**RF-023: Interfaz Web de Administración**
- **Descripción**: El sistema debe proveer interfaz web para configuración y monitoreo (opcional).
- **Funcionalidades**:
  - Dashboard con estado de dispositivos
  - Registro de nuevos dispositivos
  - Configuración de escenas
  - Visualización de logs
- **Prioridad**: Baja
- **Dependencias**: RF-027

#### 3.1.6 Gestión de Escenas y Rutinas

**RF-024: Creación de Escenas**
- **Descripción**: El sistema debe permitir crear escenas personalizadas que activen múltiples dispositivos.
- **Entrada**: Comando "crear escena [nombre]" + configuración de dispositivos
- **Procesamiento**:
  - Captura de estados de dispositivos deseados
  - Almacenamiento en base de datos
- **Salida**: Confirmación de escena creada
- **Ejemplo**: "Crear escena 'modo lectura' con luces al 80%, temperatura a 21°C, música ambiental"
- **Prioridad**: Media
- **Dependencias**: RF-029

**RF-025: Activación de Escenas**
- **Descripción**: El sistema debe activar escenas predefinidas mediante comando simple.
- **Entrada**: Comando "activa [nombre escena]"
- **Procesamiento**:
  - Recuperación de configuración de escena
  - Ejecución coordinada de acciones
- **Salida**: Confirmación de escena activada
- **Prioridad**: Alta
- **Dependencias**: RF-005, RF-024

**RF-026: Modificación de Escenas**
- **Descripción**: El sistema debe permitir modificar escenas existentes.
- **Entrada**: Comando "modifica escena [nombre]" + cambios
- **Procesamiento**: Actualización en base de datos
- **Salida**: Confirmación de cambios
- **Prioridad**: Baja
- **Dependencias**: RF-024, RF-029

#### 3.1.7 Administración del Sistema

**RF-027: Registro de Dispositivos**
- **Descripción**: El administrador debe poder registrar manualmente nuevos dispositivos IoT.
- **Entrada**: Información de dispositivo (tipo, IP, credenciales, servidor MCP asociado)
- **Procesamiento**:
  - Validación de conectividad
  - Almacenamiento en configuración
  - Notificación al servidor MCP correspondiente
- **Salida**: Confirmación de registro
- **Prioridad**: Alta
- **Dependencias**: RF-016

**RF-028: Configuración de Servidores MCP**
- **Descripción**: El administrador debe poder habilitar/deshabilitar servidores MCP y configurar parámetros.
- **Entrada**: Archivo de configuración JSON o interfaz web
- **Procesamiento**:
  - Validación de configuración
  - Reinicio de conexiones si necesario
- **Salida**: Confirmación de cambios
- **Prioridad**: Alta
- **Dependencias**: RF-007

**RF-029: Gestión de Usuarios**
- **Descripción**: El sistema debe permitir crear usuarios con perfiles y preferencias individuales.
- **Entrada**: Información de usuario (nombre, voz, preferencias iniciales)
- **Procesamiento**: Almacenamiento en base de datos
- **Salida**: Confirmación de usuario creado
- **Prioridad**: Media
- **Dependencias**: RF-014

**RF-030: Visualización de Logs y Métricas**
- **Descripción**: El administrador debe poder consultar logs de sistema y métricas de rendimiento.
- **Entrada**: Solicitud de logs (filtros de fecha, nivel, componente)
- **Procesamiento**: Consulta en base de datos
- **Salida**: Logs o dashboard con métricas
- **Prioridad**: Media
- **Dependencias**: RF-039 (logging)

#### 3.1.8 Aprendizaje y Personalización

**RF-031: Almacenamiento de Preferencias**
- **Descripción**: El sistema debe registrar preferencias del usuario basándose en patrones de uso.
- **Entrada**: Historial de comandos y acciones del usuario
- **Procesamiento**:
  - Análisis de patrones recurrentes
  - Inferencia de preferencias (ej: siempre atenúa luces a las 20:00)
  - Almacenamiento en perfil de usuario
- **Salida**: Preferencias actualizadas
- **Prioridad**: Baja
- **Dependencias**: RF-029, RF-032

**RF-032: Historial de Conversaciones**
- **Descripción**: El sistema debe mantener historial de interacciones con cada usuario.
- **Entrada**: Cada comando y respuesta
- **Procesamiento**: Almacenamiento en base de datos con timestamp
- **Salida**: Registro persistente de conversación
- **Prioridad**: Media
- **Dependencias**: RF-029

**RF-033: Sugerencias Proactivas**
- **Descripción**: El sistema puede sugerir acciones basándose en contexto y preferencias aprendidas.
- **Entrada**: Contexto actual (hora, día, estado de dispositivos, historial)
- **Procesamiento**:
  - Comparación con patrones históricos
  - Generación de sugerencia si confianza > umbral
- **Salida**: Sugerencia al usuario (opcional, requiere confirmación)
- **Ejemplo**: "Normalmente apagas las luces a esta hora. ¿Deseas que lo haga?"
- **Prioridad**: Baja
- **Dependencias**: RF-031, RF-032

---

### 3.2 Requisitos No Funcionales

Los requisitos no funcionales definen atributos de calidad del sistema.

#### 3.2.1 Rendimiento

**RNF-001: Latencia de Procesamiento**
- **Descripción**: El sistema debe procesar comandos con latencia máxima de 500ms desde recepción hasta inicio de acción.
- **Métrica**: Tiempo entre recepción de comando y primer cambio en dispositivo
- **Objetivo**: ≤ 500ms en el 90% de casos, ≤ 1000ms en el 99% de casos
- **Justificación**: Necesario para interacción natural en tiempo real
- **Método de medición**: Logs con timestamps de alta precisión

**RNF-002: Tiempo de Respuesta End-to-End**
- **Descripción**: El tiempo total desde comando de voz hasta confirmación audible no debe exceder 2 segundos.
- **Métrica**: Tiempo desde inicio de grabación de voz hasta reproducción de confirmación
- **Objetivo**: ≤ 2 segundos en el 90% de casos
- **Componentes**:
  - STT: ≤ 800ms
  - LLM: ≤ 500ms
  - MCP + IoT: ≤ 500ms
  - TTS: ≤ 200ms
- **Método de medición**: Pruebas de usuario con cronometraje

**RNF-003: Throughput de Comandos**
- **Descripción**: El sistema debe procesar al menos 10 comandos por minuto simultáneamente.
- **Métrica**: Comandos procesados exitosamente por minuto
- **Objetivo**: ≥ 10 comandos/min
- **Justificación**: Soportar múltiples usuarios en Smart Room compartido
- **Método de medición**: Pruebas de carga

**RNF-004: Utilización de Recursos**
- **Descripción**: El sistema no debe exceder el 80% de uso de GPU durante inferencia del LLM.
- **Métrica**: Porcentaje de utilización de GPU VRAM
- **Objetivo**: ≤ 80% de 12GB VRAM (≤ 9.6GB)
- **Justificación**: Dejar margen para picos y otras aplicaciones
- **Método de medición**: nvidia-smi durante ejecución

**RNF-005: Tiempo de Inicialización**
- **Descripción**: El sistema debe estar completamente operativo en menos de 60 segundos desde inicio.
- **Métrica**: Tiempo desde ejecución de script hasta aceptación del primer comando
- **Objetivo**: ≤ 60 segundos
- **Componentes**:
  - Carga del LLM: ≤ 30s
  - Inicialización de servidores MCP: ≤ 20s
  - Conexión a dispositivos IoT: ≤ 10s
- **Método de medición**: Logs de inicio

#### 3.2.2 Seguridad y Privacidad

**RNF-006: Procesamiento Local de Datos**
- **Descripción**: Todos los datos de usuario (comandos, preferencias, historial) deben procesarse y almacenarse localmente sin transmisión a servicios externos.
- **Métrica**: 0% de datos enviados a internet
- **Objetivo**: 100% de procesamiento local
- **Justificación**: Garantía de privacidad según alcance del proyecto
- **Método de verificación**: Análisis de tráfico de red

**RNF-007: Encriptación de Datos en Reposo**
- **Descripción**: Los datos sensibles del usuario (historial, preferencias) deben almacenarse encriptados.
- **Métrica**: Porcentaje de datos sensibles encriptados
- **Objetivo**: 100% de datos de usuario encriptados
- **Algoritmo**: AES-256
- **Método de verificación**: Inspección de archivos de base de datos

**RNF-008: Autenticación de Usuarios**
- **Descripción**: El sistema debe autenticar usuarios antes de permitir acceso a preferencias personales o comandos administrativos.
- **Métrica**: Porcentaje de accesos autenticados
- **Objetivo**: 100% de operaciones administrativas autenticadas
- **Métodos**: Reconocimiento de voz o PIN
- **Método de verificación**: Pruebas de penetración

**RNF-009: Aislamiento de Sesiones de Usuario**
- **Descripción**: Las preferencias y historial de un usuario no deben ser accesibles a otros usuarios.
- **Métrica**: 0 violaciones de privacidad entre usuarios
- **Objetivo**: 100% de aislamiento
- **Método de verificación**: Pruebas de compartición de datos

**RNF-010: Auditoría de Accesos**
- **Descripción**: El sistema debe registrar todos los accesos administrativos y cambios de configuración.
- **Métrica**: Porcentaje de acciones administrativas registradas
- **Objetivo**: 100% de acciones auditadas
- **Información registrada**: Usuario, timestamp, acción, resultado
- **Método de verificación**: Revisión de logs de auditoría

#### 3.2.3 Usabilidad

**RNF-011: Naturalidad de Interacción**
- **Descripción**: Los usuarios deben poder interactuar con el sistema usando lenguaje cotidiano sin aprender sintaxis específica.
- **Métrica**: Tasa de comprensión correcta de intención
- **Objetivo**: ≥ 90% de comandos interpretados correctamente en primer intento
- **Método de medición**: Pruebas con usuarios reales, análisis de logs

**RNF-012: Accesibilidad para Usuarios No Técnicos**
- **Descripción**: El sistema debe ser utilizable por personas sin conocimientos técnicos de IoT o sistemas.
- **Métrica**: System Usability Scale (SUS) score
- **Objetivo**: SUS ≥ 70 (por encima del promedio)
- **Método de medición**: Cuestionario SUS post-uso

**RNF-013: Soporte Multiidioma**
- **Descripción**: El sistema debe soportar español e inglés con igual funcionalidad.
- **Métrica**: Paridad de funcionalidad entre idiomas
- **Objetivo**: 100% de funcionalidades disponibles en ambos idiomas
- **Método de verificación**: Pruebas de casos de uso en ambos idiomas

**RNF-014: Feedback de Confirmación**
- **Descripción**: El sistema debe confirmar al usuario cuando una acción se ejecuta exitosamente.
- **Métrica**: Porcentaje de acciones con confirmación explícita
- **Objetivo**: 100% de acciones confirmadas
- **Formato**: Voz + opcional visual
- **Método de verificación**: Evaluación heurística de Nielsen

**RNF-015: Manejo de Errores Comprensible**
- **Descripción**: Los mensajes de error deben ser comprensibles para usuarios no técnicos y sugerir soluciones.
- **Métrica**: Porcentaje de usuarios que resuelven errores sin ayuda externa
- **Objetivo**: ≥ 80% de errores resolubles sin soporte
- **Ejemplo**: "No puedo encender la luz del salón porque parece estar desconectada. ¿Puedes verificar que esté enchufada?"
- **Método de medición**: Pruebas de usabilidad

#### 3.2.4 Confiabilidad

**RNF-016: Disponibilidad del Sistema**
- **Descripción**: El sistema debe estar disponible el 95% del tiempo durante operación normal.
- **Métrica**: Uptime percentage
- **Objetivo**: ≥ 95% uptime
- **Cálculo**: (Tiempo operativo / Tiempo total) * 100
- **Exclusiones**: Mantenimiento planificado (máximo 1 hora/semana)
- **Método de medición**: Monitoreo continuo con heartbeat

**RNF-017: Tasa de Éxito de Comandos**
- **Descripción**: El sistema debe ejecutar exitosamente el 90% de comandos válidos.
- **Métrica**: (Comandos exitosos / Comandos totales) * 100
- **Objetivo**: ≥ 90% tasa de éxito
- **Definición de éxito**: Comando interpretado correctamente y acción ejecutada
- **Método de medición**: Análisis de logs de ejecución

**RNF-018: Recuperación de Fallos**
- **Descripción**: El sistema debe recuperarse automáticamente de fallos de componentes individuales.
- **Métrica**: Tiempo medio de recuperación (MTTR)
- **Objetivo**: MTTR ≤ 10 segundos para fallos recuperables
- **Componentes recuperables**: Servidores MCP, conexiones de dispositivos
- **Método de verificación**: Pruebas de inyección de fallos

**RNF-019: Tolerancia a Fallos de Dispositivos**
- **Descripción**: El fallo de un dispositivo individual no debe afectar la operación del resto del sistema.
- **Métrica**: Porcentaje de funcionalidad retenida al fallar 1 dispositivo
- **Objetivo**: ≥ 95% de funcionalidad no afectada
- **Método de verificación**: Pruebas de desconexión de dispositivos

**RNF-020: Persistencia de Datos**
- **Descripción**: Los datos de configuración y preferencias deben sobrevivir reinicios del sistema.
- **Métrica**: Porcentaje de datos persistidos correctamente
- **Objetivo**: 100% de datos críticos persistidos
- **Método de verificación**: Pruebas de reinicio con verificación de datos

#### 3.2.5 Mantenibilidad

**RNF-021: Modularidad del Código**
- **Descripción**: El código debe estar organizado en módulos independientes con interfaces bien definidas.
- **Métrica**: Cohesión y acoplamiento de módulos
- **Objetivo**: Alta cohesión (>0.8), bajo acoplamiento (<0.3)
- **Método de medición**: Análisis estático de código

**RNF-022: Cobertura de Documentación**
- **Descripción**: Todas las funciones públicas deben tener docstrings explicativos.
- **Métrica**: Porcentaje de funciones documentadas
- **Objetivo**: ≥ 90% de funciones públicas documentadas
- **Formato**: Google style docstrings
- **Método de verificación**: Análisis con herramienta de linting

**RNF-023: Cobertura de Pruebas**
- **Descripción**: El código debe tener pruebas unitarias para componentes críticos.
- **Métrica**: Porcentaje de cobertura de código
- **Objetivo**: ≥ 70% de cobertura para componentes core
- **Método de medición**: pytest-cov

**RNF-024: Facilidad de Extensión**
- **Descripción**: Debe ser posible agregar un nuevo servidor MCP sin modificar código existente.
- **Métrica**: Número de archivos modificados para agregar servidor MCP
- **Objetivo**: ≤ 2 archivos (configuración + nuevo servidor)
- **Método de verificación**: Prueba práctica de extensión

**RNF-025: Logging Comprehensivo**
- **Descripción**: El sistema debe generar logs detallados para debugging y auditoría.
- **Métrica**: Porcentaje de operaciones críticas logueadas
- **Objetivo**: 100% de operaciones críticas logueadas
- **Niveles**: DEBUG, INFO, WARNING, ERROR, CRITICAL
- **Método de verificación**: Revisión de logs durante pruebas

#### 3.2.6 Portabilidad

**RNF-026: Independencia de Plataforma del SO**
- **Descripción**: El sistema debe ejecutarse en Linux y Windows sin cambios de código.
- **Métrica**: Porcentaje de funcionalidades disponibles en ambas plataformas
- **Objetivo**: ≥ 95% de paridad de funcionalidades
- **Método de verificación**: Pruebas de ejecución en Ubuntu 22.04 y Windows 11

**RNF-027: Containerización (Opcional)**
- **Descripción**: El sistema debe poder desplegarse mediante Docker para facilitar instalación.
- **Métrica**: Éxito de despliegue con Docker
- **Objetivo**: Sistema operativo en < 5 minutos con Docker
- **Método de verificación**: Prueba de despliegue desde cero

**RNF-028: Compatibilidad con Múltiples Modelos LLM**
- **Descripción**: El sistema debe permitir reemplazar el LLM (Llama) con otros modelos compatibles.
- **Métrica**: Número de modelos LLM soportados
- **Objetivo**: Al menos 2 modelos (Llama + uno adicional como Mistral)
- **Método de verificación**: Prueba de intercambio de modelos

#### 3.2.7 Escalabilidad

**RNF-029: Escalabilidad de Dispositivos**
- **Descripción**: El sistema debe soportar hasta 20 dispositivos IoT simultáneos sin degradación de rendimiento.
- **Métrica**: Latencia con 3 dispositivos vs 20 dispositivos
- **Objetivo**: Aumento de latencia ≤ 20%
- **Método de medición**: Pruebas de carga incremental

**RNF-030: Escalabilidad de Usuarios Concurrentes**
- **Descripción**: El sistema debe soportar hasta 5 usuarios concurrentes (para Smart Room compartido).
- **Métrica**: Throughput con 1 usuario vs 5 usuarios
- **Objetivo**: Degradación ≤ 30% con 5 usuarios
- **Método de medición**: Pruebas de concurrencia

---

### 3.3 Requisitos del Sistema

#### 3.3.1 Hardware Mínimo (Servidor Principal)

**RSH-001: Procesador**
- CPU de 64 bits con 8 núcleos a 2.4 GHz o superior
- Arquitectura: x86_64 o ARM64
- Ejemplos: Intel Core i7-10700, AMD Ryzen 7 3700X

**RSH-002: GPU**
- GPU NVIDIA con arquitectura compatible con CUDA
- VRAM: Mínimo 12 GB
- Compute Capability: ≥ 7.0
- Ejemplo: NVIDIA RTX 3060 (12GB), RTX 4060 Ti (16GB)

**RSH-003: Memoria RAM**
- Capacidad: Mínimo 32 GB DDR4
- Velocidad: ≥ 2666 MHz

**RSH-004: Almacenamiento**
- Tipo: SSD (preferentemente NVMe)
- Capacidad: Mínimo 2 TB
- Espacio libre requerido:
  - Modelo LLM: ~20 GB
  - Sistema operativo: ~50 GB
  - Base de datos y logs: ~30 GB
  - Margen: ~1.9 TB

**RSH-005: Red**
- Ethernet: Gigabit Ethernet (1000 Mbps)
- WiFi (opcional): WiFi 6 (802.11ax)
- Nota: Dispositivos IoT y servidor deben estar en misma red local

#### 3.3.2 Hardware Recomendado (Servidor Principal)

**RSH-006: Configuración Óptima**
- CPU: 12-16 núcleos a 3.0 GHz o superior (ej: Intel Core i9-12900K, AMD Ryzen 9 5950X)
- GPU: NVIDIA RTX 4070 Ti (16GB VRAM) o superior
- RAM: 64 GB DDR4-3200 o DDR5
- Almacenamiento: 4 TB SSD NVMe Gen4
- Red: Ethernet 10 Gigabit + WiFi 6E
- Fuente de poder: 850W 80+ Gold

#### 3.3.3 Dispositivos IoT Requeridos

**RSH-007: Mínimo de Dispositivos**
- Al menos 3 dispositivos IoT de diferentes categorías:
  - 1 sistema de iluminación (ej: Philips Hue, LIFX)
  - 1 termostato inteligente (ej: Nest, Ecobee)
  - 1 dispositivo adicional (cámara, altavoz, cerradura inteligente)

**RSH-008: Dispositivos Recomendados**
- **Iluminación**:
  - Philips Hue Starter Kit (bridge + 3 bombillas)
  - O LIFX Smart Bulbs (WiFi, sin hub)
- **Climatización**:
  - Nest Learning Thermostat
  - O Ecobee SmartThermostat
- **Seguridad**:
  - Cámara IP compatible ONVIF (ej: Hikvision, Dahua)
  - O sensor de movimiento Zigbee
- **Entretenimiento**:
  - Sonos One o Beam
  - O Chromecast con Google TV

#### 3.3.4 Software del Sistema

**RSS-001: Sistema Operativo**
- **Opción 1 (Recomendada)**: Ubuntu 22.04 LTS o superior
- **Opción 2**: Windows 11 Pro (64-bit)
- Justificación: Soporte para CUDA, Docker, Python 3.12+

**RSS-002: Runtime de Python**
- Python 3.12 o superior
- pip 23.0 o superior
- venv o uv para gestión de entornos virtuales

**RSS-003: Drivers de GPU**
- NVIDIA CUDA Toolkit 12.0 o superior
- cuDNN 8.9 o superior
- NVIDIA Driver ≥ 525.60.13 (Linux) o ≥ 528.33 (Windows)

**RSS-004: Dependencias de Sistema (Linux)**
```bash
sudo apt install -y \
  build-essential \
  git \
  curl \
  ffmpeg \
  portaudio19-dev \
  python3-dev \
  libsqlite3-dev
```

**RSS-005: Dependencias de Sistema (Windows)**
- Visual Studio Build Tools 2022
- Git for Windows
- FFmpeg (para procesamiento de audio)

#### 3.3.5 Librerías de Python Requeridas

**RSS-006: Core del Sistema**
```
langchain>=0.3.8
langchain-openai>=0.2.10
langchain-anthropic>=0.3.0
langgraph>=0.2.53
langgraph-checkpoint-sqlite>=2.0.1
mcp>=1.0.0
```

**RSS-007: LLM y AI**
```
ollama-python>=0.1.0
torch>=2.0.0
transformers>=4.35.0
openai-whisper>=20230314  # STT
bark>=0.1.0 OR piper-tts>=1.0.0  # TTS
```

**RSS-008: Base de Datos y Persistencia**
```
aiosqlite>=0.20.0
sqlalchemy>=2.0.0
alembic>=1.12.0  # migraciones de DB
```

**RSS-009: Utilidades**
```
python-dotenv>=1.0.1
commentjson>=0.9.0
rich>=13.9.0
pydantic>=2.5.0
httpx>=0.25.0
```

**RSS-010: Conectores IoT**
```
phue>=1.1  # Philips Hue
python-nest>=4.1.0  # Nest
onvif-zeep>=0.2.12  # Cámaras ONVIF
soco>=0.29.0  # Sonos
```

#### 3.3.6 Servicios Externos (Opcionales)

**RSS-011: Home Assistant (Opcional)**
- Home Assistant Core 2023.12 o superior
- Instalación: Docker o Python venv
- Propósito: Facilitar integración con dispositivos IoT heterogéneos

**RSS-012: Ollama (Requerido para LLM)**
- Ollama 0.1.0 o superior
- Propósito: Ejecutar Llama localmente con inferencia optimizada
- Instalación: https://ollama.ai/download

---

## 4. Apéndices

### Apéndice A: Mapeo de Requisitos a Objetivos del Anteproyecto

| Objetivo (Anteproyecto) | Requisitos Relacionados |
|------------------------|-------------------------|
| Analizar requerimientos técnicos y funcionales | RF-001 a RF-033, RNF-001 a RNF-030 |
| Diseñar arquitectura basada en MCP | RF-006 a RF-011, RNF-021 a RNF-024 |
| Implementar agente AI central con LLM local | RF-001 a RF-006, RNF-001, RNF-006, RSH-002 |
| Desarrollar servidores MCP especializados | RF-012 a RF-015 |
| Crear interfaces de usuario intuitivas | RF-019 a RF-023, RNF-011 a RNF-015 |
| Validar funcionalidad mediante casos de uso | Ver Plan de Pruebas (doc 08) |
| Generar evidencia empírica de viabilidad | RNF-001 a RNF-030 (métricas) |

### Apéndice B: Priorización de Requisitos (MoSCoW)

**Must Have (Esenciales para MVP):**
- RF-001, RF-002, RF-004, RF-006, RF-007, RF-008, RF-012, RF-016, RF-019, RF-020, RF-022, RF-027
- RNF-001, RNF-002, RNF-006, RNF-011, RNF-016, RNF-017

**Should Have (Importantes):**
- RF-003, RF-005, RF-013, RF-014, RF-018, RF-024, RF-025, RF-029, RF-030
- RNF-003 a RNF-005, RNF-007 a RNF-010, RNF-012 a RNF-015, RNF-018 a RNF-020

**Could Have (Deseables):**
- RF-009 a RF-011, RF-015, RF-021, RF-026, RF-031 a RF-033
- RNF-021 a RNF-025, RNF-029 a RNF-030

**Won't Have (Fuera de alcance para v1.0):**
- RF-017 (descubrimiento automático completo)
- RF-023 (interfaz web compleja)
- RNF-027 (containerización avanzada)

### Apéndice C: Supuestos de Rendimiento

**Tiempos Estimados por Componente:**

| Componente | Operación | Tiempo Estimado |
|-----------|-----------|-----------------|
| Whisper (STT) | Transcripción de 5s de audio | 800ms |
| Llama (LLM) | Inferencia con contexto de 2000 tokens | 500ms |
| Cliente MCP | Invocación de herramienta simple | 50ms |
| Servidor MCP | Procesamiento de solicitud | 100ms |
| Conector IoT | Llamada API REST a dispositivo | 200ms |
| Dispositivo IoT | Ejecución de acción física | 300ms |
| Bark/Piper (TTS) | Síntesis de respuesta corta (10 palabras) | 200ms |
| **Total End-to-End** | | **~2150ms** |

**Optimizaciones previstas:**
- Caché de respuestas comunes del LLM: -300ms
- Ejecución paralela de múltiples dispositivos: -200ms
- **Tiempo optimizado**: ~1650ms (dentro del objetivo de 2s)

### Apéndice D: Modelo de Datos Preliminar

Ver documento: [05-Modelo-Datos.md](./05-Modelo-Datos.md)

**Tablas principales:**
- `users`: Usuarios del sistema
- `devices`: Dispositivos IoT registrados
- `mcp_servers`: Servidores MCP configurados
- `scenes`: Escenas predefinidas
- `conversation_history`: Historial de conversaciones
- `user_preferences`: Preferencias aprendidas
- `action_logs`: Registro de acciones ejecutadas
- `system_metrics`: Métricas de rendimiento

### Apéndice E: Glosario de Términos

Ver documento completo: [10-Glosario.md](./10-Glosario.md)

---

**Firma de Aprobación:**

**Autores:**
- Alejandro Mosquera: ______________________ Fecha: __________
- Victor Rodríguez: ________________________ Fecha: __________

**Asesor:**
- Ing. Aris Castillo, MSC: __________________ Fecha: __________

---

**Fin del Documento SRS v1.0**
