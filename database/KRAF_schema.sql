-- ============================================================
-- KRAF | Sistema Bancario y Analítica Financiera
-- Arquitectura de Datos en Entornos Digitales
-- Universidad Dr. José Matías Delgado (UJMD)
-- ============================================================
--
-- Esquema relacional de la base de datos KRAF.
-- El modelo está compuesto por 7 tablas principales:
-- cliente, tipo_cuenta, entidad_financiera,
-- tipo_transferencia, cuenta, transferencia y saldo_historico.
--
-- ============================================================


-- ============================================================
-- 1. CLIENTE
-- ============================================================

CREATE TABLE public.cliente (
  cliente_id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre character varying NOT NULL,
  dui character varying NOT NULL UNIQUE,
  telefono character varying,
  correo character varying UNIQUE,
  estado character varying NOT NULL DEFAULT 'ACTIVO'::character varying
    CHECK (
      estado::text = ANY (
        ARRAY[
          'ACTIVO'::character varying,
          'INACTIVO'::character varying,
          'BLOQUEADO'::character varying
        ]::text[]
      )
    ),
  CONSTRAINT cliente_pkey PRIMARY KEY (cliente_id)
);


-- ============================================================
-- 2. TIPO DE CUENTA
-- ============================================================

CREATE TABLE public.tipo_cuenta (
  tipo_cuenta_id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre character varying NOT NULL UNIQUE,
  descripcion character varying,
  CONSTRAINT tipo_cuenta_pkey PRIMARY KEY (tipo_cuenta_id)
);


-- ============================================================
-- 3. ENTIDAD FINANCIERA
-- ============================================================

CREATE TABLE public.entidad_financiera (
  entidad_financiera_id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre character varying NOT NULL UNIQUE,
  codigo_entidad character varying NOT NULL UNIQUE,
  tipo_entidad character varying NOT NULL
    CHECK (
      tipo_entidad::text = ANY (
        ARRAY[
          'BANCO'::character varying,
          'FINTECH'::character varying,
          'COOPERATIVA'::character varying,
          'OTRA'::character varying
        ]::text[]
      )
    ),
  CONSTRAINT entidad_financiera_pkey PRIMARY KEY (entidad_financiera_id)
);


-- ============================================================
-- 4. TIPO DE TRANSFERENCIA
-- ============================================================

CREATE TABLE public.tipo_transferencia (
  tipo_transferencia_id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre character varying NOT NULL UNIQUE,
  descripcion character varying,
  CONSTRAINT tipo_transferencia_pkey PRIMARY KEY (tipo_transferencia_id)
);


-- ============================================================
-- 5. CUENTA
-- ============================================================

CREATE TABLE public.cuenta (
  cuenta_id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  cliente_id integer NOT NULL,
  tipo_cuenta_id integer NOT NULL,
  numero_cuenta character varying NOT NULL UNIQUE,
  saldo_actual numeric NOT NULL DEFAULT 0
    CHECK (saldo_actual >= 0::numeric),
  fecha_apertura date NOT NULL,
  estado character varying NOT NULL DEFAULT 'ACTIVA'::character varying
    CHECK (
      estado::text = ANY (
        ARRAY[
          'ACTIVA'::character varying,
          'INACTIVA'::character varying,
          'BLOQUEADA'::character varying,
          'CERRADA'::character varying
        ]::text[]
      )
    ),
  CONSTRAINT cuenta_pkey PRIMARY KEY (cuenta_id),

  CONSTRAINT fk_cuenta_cliente
    FOREIGN KEY (cliente_id)
    REFERENCES public.cliente(cliente_id),

  CONSTRAINT fk_cuenta_tipo
    FOREIGN KEY (tipo_cuenta_id)
    REFERENCES public.tipo_cuenta(tipo_cuenta_id)
);


-- ============================================================
-- 6. TRANSFERENCIA
-- ============================================================

CREATE TABLE public.transferencia (
  transferencia_id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  cuenta_id integer NOT NULL,
  entidad_financiera_id integer NOT NULL,
  tipo_transferencia_id integer NOT NULL,
  monto numeric NOT NULL
    CHECK (monto > 0::numeric),
  fecha_hora timestamp without time zone NOT NULL,
  cuenta_destino character varying NOT NULL,
  referencia character varying UNIQUE,
  canal character varying NOT NULL
    CHECK (
      canal::text = ANY (
        ARRAY[
          'APP'::character varying,
          'WEB'::character varying,
          'SUCURSAL'::character varying,
          'API'::character varying
        ]::text[]
      )
    ),
  estado character varying NOT NULL DEFAULT 'COMPLETADA'::character varying
    CHECK (
      estado::text = ANY (
        ARRAY[
          'COMPLETADA'::character varying,
          'PENDIENTE'::character varying,
          'RECHAZADA'::character varying,
          'CANCELADA'::character varying
        ]::text[]
      )
    ),

  CONSTRAINT transferencia_pkey
    PRIMARY KEY (transferencia_id),

  CONSTRAINT fk_transferencia_cuenta
    FOREIGN KEY (cuenta_id)
    REFERENCES public.cuenta(cuenta_id),

  CONSTRAINT fk_transferencia_entidad
    FOREIGN KEY (entidad_financiera_id)
    REFERENCES public.entidad_financiera(entidad_financiera_id),

  CONSTRAINT fk_transferencia_tipo
    FOREIGN KEY (tipo_transferencia_id)
    REFERENCES public.tipo_transferencia(tipo_transferencia_id)
);


-- ============================================================
-- 7. SALDO HISTÓRICO
-- ============================================================

CREATE TABLE public.saldo_historico (
  saldo_id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  cuenta_id integer NOT NULL,
  fecha date NOT NULL,
  saldo_inicial numeric NOT NULL
    CHECK (saldo_inicial >= 0::numeric),
  saldo_final numeric NOT NULL
    CHECK (saldo_final >= 0::numeric),

  CONSTRAINT saldo_historico_pkey
    PRIMARY KEY (saldo_id),

  CONSTRAINT fk_saldo_cuenta
    FOREIGN KEY (cuenta_id)
    REFERENCES public.cuenta(cuenta_id)
);


-- ============================================================
-- FIN DEL ESQUEMA KRAF
-- ============================================================
