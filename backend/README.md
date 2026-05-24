# Void backend

Dart backend that powers the Void chat app.

## Run locally

```bash
# 1. PostgreSQL must be running with migrations applied (see Database schema).

# 2. Configure credentials.
cp .env.example .env  # then edit DB_USER / DB_PASSWORD / DB_NAME

# 3. Start the server.
dart run bin/server.dev.dart
```

The server listens on `8082` by default (override with the `PORT` environment
variable).

## Database schema

The schema lives in versioned SQL files under `migrations/`. Apply them **in
order** against an empty database:

| File                          | Purpose                                                |
| ----------------------------- | ------------------------------------------------------ |
| `0001_init_auth_users.sql`    | `auth.users`, `auth.sessions`                          |
| `0002_init_auth_sessions.sql` | `auth.sessions`                                        |
| `0003_auth_email_codes.sql`   | `auth.pending_registrations`, `auth.login_email_codes` |

```bash
# Example with psql on the host:
psql "postgres://<user>:<password>@localhost:5432/<db>" \
  -f migrations/0001_init_auth_users.sql
psql "postgres://<user>:<password>@localhost:5432/<db>" \
  -f migrations/0002_init_auth_sessions.sql
psql "postgres://<user>:<password>@localhost:5432/<db>" \
  -f migrations/0003_auth_email_codes.sql
```

**Migration files are append-only**: never edit a file that has already been
applied. New schema changes go into a new `0004_*.sql`, etc.

## Auth API

Base URL: `http://localhost:8082/auth`

All responses are JSON. Errors use a single envelope:

```json
{
  "success": false,
  "error": {
    "code": "MACHINE_READABLE_CODE",
    "message": "Human-readable explanation",
    "details": [
      { "field": "password", "code": "INVALID_PASSWORD", "message": "..." }
    ]
  }
}
```

`error.details[]` is present **only** for `VALIDATION_FAILED`. Other codes
include `code` and `message` only.

### Authentication

Protected endpoints require a header:

```http
Authorization: Bearer <access_token>
```

`access_token` is returned by login endpoints. Only a SHA-256 hash is stored in
`auth.sessions.token_hash`.

**Public** (no Bearer): registration and login endpoints below.

**Protected** (Bearer required): `/me`, `/logout`, `/logout/all`.

In local development, email verification codes are printed to the server log
(`DevEmailSender` via Talker), not sent over SMTP.

---

### Registration (3 steps)

#### 1. POST `/auth/register/start`

Starts registration; sends an email code (logged in dev).

**Request**

```json
{
  "login": "john_doe",
  "email": "john@example.com",
  "password": "Password123"
}
```

**Response 201**

```json
{ "registration_id": "uuid" }
```

#### 2. POST `/auth/register/verify-email`

**Request**

```json
{
  "registration_id": "uuid",
  "code": "1234"
}
```

**Response 200**

```json
{ "verified": true }
```

#### 3. POST `/auth/register/complete-profile`

**Request**

```json
{
  "registration_id": "uuid",
  "username": "john_doe",
  "display_name": "John Doe"
}
```

**Response 201**

```json
{
  "id": "uuid",
  "email": "john@example.com",
  "username": "john_doe",
  "display_name": "John Doe",
  "created_at": "2026-05-19T00:00:00.000Z"
}
```

---

### Login

#### POST `/auth/login-password`

**Request**

```json
{
  "identifier": "john@example.com",
  "password": "Password123"
}
```

`identifier` is login or email.

**Response 200**

```json
{
  "access_token": "opaque-token",
  "user": {
    "id": "uuid",
    "email": "john@example.com",
    "username": "john_doe",
    "display_name": "John Doe",
    "created_at": "2026-05-19T00:00:00.000Z"
  },
  "expires_in": 2592000
}
```

`expires_in` is seconds (30 days).

| Status | code                  | When                                 |
| ------ | --------------------- | ------------------------------------ |
| 401    | `INVALID_CREDENTIALS` | Unknown identifier or wrong password |

#### POST `/auth/login/code/request`

**Request**

```json
{ "identifier": "john@example.com" }
```

**Response 200**

```json
{ "sent": true }
```

Always returns `sent: true` (even if the user does not exist) to avoid account
enumeration.

#### POST `/auth/login/code/verify`

**Request**

```json
{
  "identifier": "john@example.com",
  "code": "1234"
}
```

**Response 200** — same shape as `/auth/login-password` (`access_token`, `user`,
`expires_in`).

| Status | code                           | When               |
| ------ | ------------------------------ | ------------------ |
| 401    | `INVALID_CREDENTIALS`          | Unknown identifier |
| 400    | `INVALID_EMAIL_CODE`           | Wrong code         |
| 400    | `EMAIL_CODE_EXPIRED`           | Code TTL exceeded  |
| 400    | `EMAIL_CODE_ATTEMPTS_EXCEEDED` | Too many attempts  |

---

### Session (protected)

#### GET `/auth/me`

Returns the authenticated user profile.

**Headers:** `Authorization: Bearer <access_token>`

**Response 200**

```json
{
  "id": "uuid",
  "email": "john@example.com",
  "username": "john_doe",
  "display_name": "John Doe",
  "created_at": "2026-05-19T00:00:00.000Z"
}
```

| Status | code           | When                     |
| ------ | -------------- | ------------------------ |
| 401    | `UNAUTHORIZED` | Missing or invalid token |

#### POST `/auth/logout`

Revokes the **current** session (the Bearer token used in the request).

**Headers:** `Authorization: Bearer <access_token>`

**Response 200**

```json
{ "ok": true }
```

#### POST `/auth/logout/all`

Revokes **all** sessions for the authenticated user.

**Headers:** `Authorization: Bearer <access_token>`

**Response 200**

```json
{ "ok": true }
```

---

### Common validation errors

| Status | code                     | When                                     |
| ------ | ------------------------ | ---------------------------------------- |
| 400    | `INVALID_JSON`           | Body is not valid JSON                   |
| 400    | `INVALID_BODY`           | JSON root is not an object               |
| 400    | `INVALID_REQUEST_FIELDS` | Missing or wrong-type field              |
| 400    | `VALIDATION_FAILED`      | Domain validation; see `error.details[]` |
| 409    | `EMAIL_TAKEN`            | Email already registered                 |
| 409    | `USERNAME_TAKEN`         | Username already taken                   |

---

## Tests

```bash
dart test test/unit/features/auth/
```

API handler tests live under `test/unit/features/auth/api/` and use fake use
cases (no database). Protected routes are exercised by setting
`authenticatedUserIdKey` on the request context, matching what `authMiddleware`
does in production.

## Manual smoke testing (Postman)

1. Import `postman/auth.postman_collection.json` (if present) or create requests
   manually against `http://localhost:8082/auth`.
2. Set environment variable `baseUrl = http://localhost:8082`.
3. Apply migrations and start the server: `dart run bin/server.dev.dart`.
4. **Registration:** `register/start` → copy code from server log →
   `register/verify-email` → `register/complete-profile`.
5. **Login:** `login-password` or `login/code/request` + `login/code/verify` →
   copy `access_token`.
6. **Session:** `GET /auth/me` with `Authorization: Bearer <access_token>`.
7. **Logout:** `POST /auth/logout` → `GET /auth/me` should return `401`.

### Smoke checklist

| Flow           | Steps                      | Expected             |
| -------------- | -------------------------- | -------------------- |
| Register       | start → verify → complete  | 201 user profile     |
| Login password | login-password             | 200 + `access_token` |
| Login code     | code/request → code/verify | 200 + `access_token` |
| Me             | GET /me + Bearer           | 200 user JSON        |
| Logout         | POST /logout → GET /me     | 200 then 401         |
