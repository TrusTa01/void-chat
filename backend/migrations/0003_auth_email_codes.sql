-- Migration: 0003_auth_email_codes
-- Multi-step registration + email code login.
-- Safe to apply on empty DB after 0001 and 0002.

-- ---------------------------------------------------------------------------
-- 1. Pending registrations (register/start → verify-email → complete-profile)
-- ---------------------------------------------------------------------------
CREATE TABLE auth.pending_registrations (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  login         VARCHAR(255) NOT NULL,
  email         VARCHAR(255) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  code_hash     VARCHAR(255) NOT NULL,
  expires_at    TIMESTAMPTZ NOT NULL,
  verified_at   TIMESTAMPTZ NULL,
  attempts      INT NOT NULL DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  CONSTRAINT pending_registrations_email_key UNIQUE (email),
  CONSTRAINT pending_registrations_login_key  UNIQUE (login),
  CONSTRAINT pending_registrations_attempts_nonneg CHECK (attempts >= 0)
);

CREATE INDEX pending_registrations_expires_at_idx
  ON auth.pending_registrations (expires_at);

-- ---------------------------------------------------------------------------
-- 2. Login email codes (login/code/request → login/code/verify)
-- ---------------------------------------------------------------------------
CREATE TABLE auth.login_email_codes (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  code_hash   VARCHAR(255) NOT NULL,
  expires_at  TIMESTAMPTZ NOT NULL,
  consumed_at TIMESTAMPTZ NULL,
  attempts    INT NOT NULL DEFAULT 0,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  CONSTRAINT login_email_codes_attempts_nonneg CHECK (attempts >= 0)
);

CREATE INDEX login_email_codes_user_id_idx
  ON auth.login_email_codes (user_id);

CREATE INDEX login_email_codes_expires_at_idx
  ON auth.login_email_codes (expires_at);

CREATE INDEX login_email_codes_active_idx
  ON auth.login_email_codes (user_id, expires_at)
  WHERE consumed_at IS NULL;

-- ---------------------------------------------------------------------------
-- 3. Trim unused auth.users columns
-- ---------------------------------------------------------------------------

ALTER TABLE auth.users
  DROP COLUMN confirmation_token,
  DROP COLUMN confirmation_sent_at,
  DROP COLUMN phone,
  DROP COLUMN phone_confirmed_at,
  DROP COLUMN reauthentication_token,
  DROP COLUMN reauthentication_sent_at;
  
-- Pending users now live in auth.pending_registrations.
-- Rows in auth.users are complete accounts by default.
ALTER TABLE auth.users
  ALTER COLUMN status SET DEFAULT 'active';

CREATE INDEX users_email_confirmed_at_idx
  ON auth.users (email_confirmed_at)
  WHERE email_confirmed_at IS NOT NULL;
