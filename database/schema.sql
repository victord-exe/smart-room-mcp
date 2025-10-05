-- ============================================================================
-- Smart Room Control System (SRCS) - Database Schema
-- ============================================================================
-- Universidad Tecnológica de Panamá
-- Autores: Alejandro Mosquera, Victor Rodríguez
-- Versión: 1.0
-- Fecha: Enero 2025
-- ============================================================================

-- Habilitar foreign keys en SQLite
PRAGMA foreign_keys = ON;

-- ============================================================================
-- TABLA: users
-- Descripción: Almacena información de usuarios del sistema
-- ============================================================================

CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    voice_profile TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Índices para users
CREATE INDEX IF NOT EXISTS idx_users_name ON users(name);

-- Trigger para actualizar updated_at en users
CREATE TRIGGER IF NOT EXISTS update_users_timestamp
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    UPDATE users SET updated_at = datetime('now') WHERE id = NEW.id;
END;

-- ============================================================================
-- TABLA: mcp_servers
-- Descripción: Configuración de servidores MCP activos en el sistema
-- ============================================================================

CREATE TABLE IF NOT EXISTS mcp_servers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    command TEXT NOT NULL,
    args TEXT NOT NULL, -- JSON array
    env TEXT, -- JSON object
    enabled INTEGER NOT NULL DEFAULT 1 CHECK(enabled IN (0, 1)),
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Índices para mcp_servers
CREATE INDEX IF NOT EXISTS idx_mcp_servers_name ON mcp_servers(name);
CREATE INDEX IF NOT EXISTS idx_mcp_servers_enabled ON mcp_servers(enabled);

-- Trigger para actualizar updated_at en mcp_servers
CREATE TRIGGER IF NOT EXISTS update_mcp_servers_timestamp
AFTER UPDATE ON mcp_servers
FOR EACH ROW
BEGIN
    UPDATE mcp_servers SET updated_at = datetime('now') WHERE id = NEW.id;
END;

-- ============================================================================
-- TABLA: devices
-- Descripción: Registro de dispositivos IoT conectados al sistema
-- ============================================================================

CREATE TABLE IF NOT EXISTS devices (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('light', 'thermostat', 'camera', 'speaker', 'sensor', 'lock', 'switch')),
    server_mcp TEXT NOT NULL,
    config TEXT NOT NULL, -- JSON object
    enabled INTEGER NOT NULL DEFAULT 1 CHECK(enabled IN (0, 1)),
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (server_mcp) REFERENCES mcp_servers(name) ON DELETE RESTRICT
);

-- Índices para devices
CREATE INDEX IF NOT EXISTS idx_devices_type ON devices(type);
CREATE INDEX IF NOT EXISTS idx_devices_server_mcp ON devices(server_mcp);
CREATE INDEX IF NOT EXISTS idx_devices_enabled ON devices(enabled);

-- Trigger para actualizar updated_at en devices
CREATE TRIGGER IF NOT EXISTS update_devices_timestamp
AFTER UPDATE ON devices
FOR EACH ROW
BEGIN
    UPDATE devices SET updated_at = datetime('now') WHERE id = NEW.id;
END;

-- ============================================================================
-- TABLA: scenes
-- Descripción: Escenas predefinidas y personalizadas de configuración de dispositivos
-- ============================================================================

CREATE TABLE IF NOT EXISTS scenes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    user_id INTEGER,
    config TEXT NOT NULL, -- JSON object
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE(name, user_id)
);

-- Índices para scenes
CREATE INDEX IF NOT EXISTS idx_scenes_user_id ON scenes(user_id);
CREATE INDEX IF NOT EXISTS idx_scenes_name ON scenes(name);

-- Trigger para actualizar updated_at en scenes
CREATE TRIGGER IF NOT EXISTS update_scenes_timestamp
AFTER UPDATE ON scenes
FOR EACH ROW
BEGIN
    UPDATE scenes SET updated_at = datetime('now') WHERE id = NEW.id;
END;

-- ============================================================================
-- TABLA: conversation_history
-- Descripción: Historial de conversaciones entre usuarios y el sistema
-- ============================================================================

CREATE TABLE IF NOT EXISTS conversation_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    message TEXT NOT NULL,
    role TEXT NOT NULL CHECK(role IN ('user', 'assistant', 'system')),
    timestamp TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Índices para conversation_history
CREATE INDEX IF NOT EXISTS idx_conversation_user_id ON conversation_history(user_id);
CREATE INDEX IF NOT EXISTS idx_conversation_timestamp ON conversation_history(timestamp);

-- ============================================================================
-- TABLA: user_preferences
-- Descripción: Preferencias aprendidas del comportamiento de usuarios
-- ============================================================================

CREATE TABLE IF NOT EXISTS user_preferences (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    preference_key TEXT NOT NULL,
    preference_value TEXT NOT NULL, -- JSON object
    learned_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE(user_id, preference_key)
);

-- Índices para user_preferences
CREATE INDEX IF NOT EXISTS idx_preferences_user_id ON user_preferences(user_id);
CREATE INDEX IF NOT EXISTS idx_preferences_key ON user_preferences(preference_key);

-- ============================================================================
-- TABLA: action_logs
-- Descripción: Registro de auditoría de todas las acciones ejecutadas en el sistema
-- ============================================================================

CREATE TABLE IF NOT EXISTS action_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    action TEXT NOT NULL,
    device_id INTEGER,
    parameters TEXT, -- JSON object
    result TEXT NOT NULL CHECK(result IN ('success', 'error', 'partial')),
    error_message TEXT,
    timestamp TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (device_id) REFERENCES devices(id) ON DELETE SET NULL
);

-- Índices para action_logs
CREATE INDEX IF NOT EXISTS idx_action_logs_user_id ON action_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_action_logs_device_id ON action_logs(device_id);
CREATE INDEX IF NOT EXISTS idx_action_logs_timestamp ON action_logs(timestamp);
CREATE INDEX IF NOT EXISTS idx_action_logs_action ON action_logs(action);

-- ============================================================================
-- TABLA: system_metrics
-- Descripción: Métricas de rendimiento y salud del sistema
-- ============================================================================

CREATE TABLE IF NOT EXISTS system_metrics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    metric_name TEXT NOT NULL,
    metric_value REAL NOT NULL,
    metadata TEXT, -- JSON object
    timestamp TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Índices para system_metrics
CREATE INDEX IF NOT EXISTS idx_metrics_name ON system_metrics(metric_name);
CREATE INDEX IF NOT EXISTS idx_metrics_timestamp ON system_metrics(timestamp);
CREATE INDEX IF NOT EXISTS idx_metrics_name_timestamp ON system_metrics(metric_name, timestamp);

-- ============================================================================
-- DATOS INICIALES (SEED DATA)
-- ============================================================================

-- Insertar usuario por defecto para desarrollo/testing
INSERT OR IGNORE INTO users (id, name, voice_profile)
VALUES (1, 'Usuario Demo', NULL);

-- Insertar servidores MCP predefinidos
INSERT OR IGNORE INTO mcp_servers (name, command, args, env, enabled)
VALUES
    ('lighting', 'python', '["-m", "mcp_lighting_server"]', '{}', 1),
    ('climate', 'python', '["-m", "mcp_climate_server"]', '{}', 1),
    ('security', 'python', '["-m", "mcp_security_server"]', '{}', 1),
    ('entertainment', 'python', '["-m", "mcp_entertainment_server"]', '{}', 1);

-- Insertar escenas predefinidas del sistema
INSERT OR IGNORE INTO scenes (name, user_id, config)
VALUES
    ('Modo Trabajo', NULL, '{"description":"Ambiente ideal para trabajar","devices":{"lighting":{"brightness":100,"color":"white"},"climate":{"temperature":21}}}'),
    ('Modo Presentación', NULL, '{"description":"Configuración para presentaciones","devices":{"lighting":{"brightness":80},"entertainment":{"projector":"on"}}}'),
    ('Modo Cine', NULL, '{"description":"Ambiente para ver películas","devices":{"lighting":{"brightness":20,"color":"warm"},"climate":{"temperature":20},"entertainment":{"volume":60}}}'),
    ('Modo Descanso', NULL, '{"description":"Ambiente relajante","devices":{"lighting":{"brightness":30,"color":"warm"},"climate":{"temperature":22}}}');

-- ============================================================================
-- VISTAS ÚTILES
-- ============================================================================

-- Vista: Dispositivos online/offline
CREATE VIEW IF NOT EXISTS v_devices_status AS
SELECT
    d.id,
    d.name,
    d.type,
    d.server_mcp,
    d.enabled,
    CASE
        WHEN d.enabled = 1 THEN 'online'
        ELSE 'offline'
    END AS status,
    d.updated_at as last_updated
FROM devices d;

-- Vista: Métricas recientes (últimas 24 horas)
CREATE VIEW IF NOT EXISTS v_metrics_recent AS
SELECT
    metric_name,
    AVG(metric_value) as avg_value,
    MIN(metric_value) as min_value,
    MAX(metric_value) as max_value,
    COUNT(*) as sample_count
FROM system_metrics
WHERE timestamp >= datetime('now', '-1 day')
GROUP BY metric_name;

-- Vista: Actividad de usuarios (últimos 7 días)
CREATE VIEW IF NOT EXISTS v_user_activity AS
SELECT
    u.id,
    u.name,
    COUNT(DISTINCT DATE(al.timestamp)) as active_days,
    COUNT(al.id) as total_actions,
    MAX(al.timestamp) as last_action
FROM users u
LEFT JOIN action_logs al ON u.id = al.user_id
WHERE al.timestamp >= datetime('now', '-7 days')
GROUP BY u.id, u.name;

-- ============================================================================
-- FUNCIONES DE LIMPIEZA AUTOMÁTICA
-- ============================================================================

-- Nota: SQLite no soporta eventos programados nativamente.
-- La limpieza debe ejecutarse mediante una tarea programada del sistema (cron, systemd timer, etc.)
-- o mediante un script Python que se ejecute periódicamente.

-- Script de limpieza de conversation_history (> 30 días)
-- DELETE FROM conversation_history WHERE timestamp < datetime('now', '-30 days');

-- Script de limpieza de action_logs (> 30 días)
-- DELETE FROM action_logs WHERE timestamp < datetime('now', '-30 days');

-- Script de limpieza de system_metrics (> 7 días)
-- DELETE FROM system_metrics WHERE timestamp < datetime('now', '-7 days');

-- ============================================================================
-- VALIDACIONES E INTEGRIDAD
-- ============================================================================

-- Verificar que todas las tablas se crearon correctamente
SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;

-- ============================================================================
-- NOTAS PARA DESARROLLO
-- ============================================================================

-- Para recrear la base de datos desde cero (CUIDADO: elimina todos los datos):
-- rm database/smart_room.db
-- sqlite3 database/smart_room.db < database/schema.sql

-- Para verificar el esquema:
-- sqlite3 database/smart_room.db ".schema"

-- Para exportar datos:
-- sqlite3 database/smart_room.db ".dump" > backup.sql

-- Para importar datos:
-- sqlite3 database/smart_room.db < backup.sql

-- ============================================================================
-- FIN DEL SCHEMA
-- ============================================================================
