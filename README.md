# Ecco

Sistema de leilão para treinamento em criação de sistemas em alta concorrência.

| Pasta | O que é | Tecnologias |
|---|---|---|
| `api/` | Back-end | NestJS + TypeScript, SQL Server (`mssql`) |
| `app/` | Front-end | Quasar (Vue 3) + Tailwind |

## Pré-requisitos

- **Node.js** 20 ou superior
- **SQL Server** rodando localmente (porta 1433) com autenticação SQL ligada
- Um login com permissão para criar bancos (papel `dbcreator`) ou dono (`db_owner`) do banco do projeto

## 1. Banco de dados

1. Crie o banco:
   ```sql
   CREATE DATABASE Auction;
   ```
2. Conectado ao banco `Auction` (não ao `master`), rode o script [`api/script.sql`](api/script.sql) para criar as tabelas.

## 2. API

```bash
cd api
npm install
cp .env.example .env
```

Preencha o `.env`:

| Variável | Exemplo | Descrição |
|---|---|---|
| `PORT` | `3000` | Porta da API |
| `CORS_ORIGIN` | `http://localhost:9000` | Endereço do front liberado no CORS |
| `JWT_SECRET` | *(texto longo e aleatório)* | Chave que assina o token de login |
| `JWT_EXPIRES_IN` | `86400` | Validade do login, em segundos (86400 = 1 dia) |
| `DB_HOST` | `localhost` | Servidor do SQL Server |
| `DB_PORT` | `1433` | Porta do SQL Server |
| `DB_USER` / `DB_PASSWORD` | | Login do SQL Server |
| `DB_NAME` | `Auction` | Nome do banco |

Inicie em modo de desenvolvimento (reinicia sozinha a cada alteração):

```bash
npm run start:dev
```

- API: http://localhost:3000/api
- Documentação (Swagger): http://localhost:3000/api/docs

## 3. App

Em outro terminal:

```bash
cd app
npm install
cp .env.example .env
npm run dev
```

O `.env` do app tem só `QCLI_API_URL`, o endereço da API (padrão `http://localhost:3000/api`).

O navegador abre sozinho em http://localhost:9000. Crie uma conta em **Criar conta** e entre com ela.

## Comandos úteis

| Onde | Comando | O que faz |
|---|---|---|
| `api/` | `npm run build` / `npm run start:prod` | Gera e roda a versão de produção |
| `api/` | `npm test` / `npm run test:e2e` | Testes unitários / ponta a ponta |
| `api/` | `npm run lint` | Verifica o código |
| `app/` | `npm run build` | Gera o site em `app/dist/spa` |
| `app/` | `npm run typecheck` | Verifica os tipos |
| `app/` | `npm run lint` | Verifica o código |

## Problemas comuns

- **`Permissão CREATE DATABASE negada no banco de dados 'master'`**: o login não pode criar bancos. Com um usuário administrador (ou a autenticação do Windows), rode `ALTER SERVER ROLE dbcreator ADD MEMBER [seu_login];`.
- **Tabelas criadas no lugar errado**: o script rodou conectado ao `master`. Selecione o banco `Auction` antes de rodar o `script.sql`.
- **API não inicia com `Variáveis de ambiente inválidas`**: falta alguma variável no `api/.env`, geralmente `JWT_SECRET`.
- **Erro de CORS no navegador**: o `CORS_ORIGIN` da API precisa ser igual ao endereço onde o app está aberto.
