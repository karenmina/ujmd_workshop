# 🏦 KRAF — Sistema Bancario y Analítica Financiera

Proyecto de **Arquitectura de Datos en Entornos Digitales** para el diseño, implementación y análisis de una base de datos bancaria para KRAF.

## 👥 Estudiantes

- Fernando Boveda Pleitez — 202401115
- Karen María Mina Martínez — 202400945
- Rodrigo Javier Villalobos Hernández — 202400878
- Alejandro Raphael Mejía Guerrero — 202401441

---

## 📖 Descripción

KRAF es un modelo de datos orientado a la gestión de **clientes, cuentas, entidades financieras y transferencias**.

El proyecto comprende el diseño de una estructura relacional, su implementación en PostgreSQL mediante Supabase, el poblamiento con datos sintéticos y la elaboración de consultas SQL para realizar análisis operativos y financieros.

---

## 🛠️ Tecnologías utilizadas

- 🐘 **PostgreSQL**
- ⚡ **Supabase**
- 🔎 **SQL**
- 🐙 **GitHub**
- 🔄 **GitHub Actions**

---

## 🗃️ Estructura de la base de datos

El modelo está compuesto por las siguientes tablas principales:

| Tabla | Descripción |
|---|---|
| 👤 `cliente` | Información de los clientes |
| 💳 `tipo_cuenta` | Catálogo de tipos de cuenta |
| 🏦 `entidad_financiera` | Entidades financieras disponibles |
| 🔄 `tipo_transferencia` | Catálogo de tipos de transferencia |
| 💰 `cuenta` | Cuentas asociadas a los clientes |
| 💸 `transferencia` | Registro de transferencias realizadas |
| 📈 `saldo_historico` | Historial de saldos de las cuentas |

La estructura implementa relaciones mediante **claves primarias y foráneas**, manteniendo la integridad de los datos.

---

## 📊 Datos sintéticos

La base de datos fue poblada con información sintética para permitir la ejecución y validación de las consultas analíticas.

Se cuenta con:

- 👤 **40 clientes**
- 💳 **10 tipos de cuenta**
- 🏦 **10 entidades financieras**
- 🔄 **10 tipos de transferencia**
- 💰 **40 cuentas**
- 💸 **400 transferencias**
- 📈 **480 registros de saldo histórico**

Los datos son sintéticos y se utilizan únicamente con fines académicos.

> Los datos no forman parte del versionamiento del repositorio. El repositorio contiene principalmente la estructura y los scripts necesarios para la implementación de la base de datos.

---

## 🔎 Consultas analíticas

El proyecto incluye consultas SQL orientadas al análisis de diferentes aspectos del sistema bancario:

1. 💸 **Concentración de transferencias por cliente**
2. 📈 **Evolución de saldos promedio por tipo de cuenta**
3. 🏦 **Transferencias por canal y entidad financiera**
4. 👤 **Perfil de clientes**
5. ⚠️ **Identificación de transferencias con montos inusuales**

Estas consultas permiten obtener información útil para el análisis operativo y financiero del modelo.
