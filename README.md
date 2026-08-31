# KRAF — Sistema Bancario y Analítica Financiera

Proyecto de Arquitectura de Datos en Entornos Digitales para el diseño y análisis de una base de datos bancaria para KRAF.

## Estudiantes

- Fernando Boveda Pleitez — 202401115
- Karen María Mina Martínez — 202400945
- Rodrigo Javier Villalobos Hernández — 202400878
- Alejandro Raphael Mejía Guerrero — 202401441

## Descripción

KRAF es un modelo de datos orientado a la gestión de clientes, cuentas, entidades financieras y transferencias. El proyecto incluye el diseño de una estructura relacional, poblado con datos sintéticos y consultas SQL para análisis operativo.

## Tecnologías

- PostgreSQL
- Supabase
- SQL
- GitHub

## Estructura de la base de datos

El modelo está compuesto por las siguientes tablas principales:

- `cliente`
- `cuenta`
- `tipo_cuenta`
- `entidad_financiera`
- `tipo_transferencia`
- `transferencia`
- `saldo_historico`

## Contenido del proyecto

- Diseño de la estructura relacional.
- Poblado con datos sintéticos.
- Verificación de registros.
- Consultas SQL de analítica operativa.
- Implementación y despliegue mediante Supabase.

## Analítica

Las consultas desarrolladas permiten analizar aspectos como:

- Concentración de transferencias por cliente.
- Evolución de saldos por tipo de cuenta.
- Transferencias por entidad financiera y canal.
- Perfil transaccional de los clientes.
- Transferencias con montos inusuales.

## Herramientas utilizadas

**Base de datos:** PostgreSQL / Supabase  
**Control de versiones:** GitHub
