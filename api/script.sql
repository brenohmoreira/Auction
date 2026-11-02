CREATE TABLE Usuarios (
        id NUMERIC(18, 0) PRIMARY KEY IDENTITY(1,1),
        nome VARCHAR(100) NOT NULL,
        email NVARCHAR(254) NOT NULL UNIQUE,
        senha VARCHAR(255) NOT NULL,
        status VARCHAR(1) NOT NULL DEFAULT 'A',
        dataCriacao DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME() 
)

CREATE TABLE Leiloes (
        id NUMERIC(18,0) PRIMARY KEY IDENTITY(1,1),
        idUsuario NUMERIC(18,0) NOT NULL REFERENCES Usuarios(id),
        titulo VARCHAR(100) NOT NULL,
        descricao VARCHAR(MAX) NULL,
        status VARCHAR(1) NOT NULL DEFAULT 'P',
        dataCriacao DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME() 
)

CREATE TABLE Lotes (
        id NUMERIC(18, 0) PRIMARY KEY IDENTITY(1,1),
        idLeilao NUMERIC(18,0) NOT NULL REFERENCES Leiloes(id),
        titulo VARCHAR(100) NOT NULL,
        descricao VARCHAR(MAX),
        lanceInicial NUMERIC(18,2) NULL, 
        incrementoMinimo NUMERIC(18, 2) NOT NULL,
        precoReserva NUMERIC(18,2) NULL,
        precoCompreJa NUMERIC(18,2) NULL, 
        prorrogacaoMinutos NUMERIC(18,2) NULL,
        dataInicio DATETIME2 NOT NULL,
        dataFim DATETIME2 NOT NULL, 
        dataCriacao DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        status VARCHAR(1) NOT NULL DEFAULT 'P'
)

CREATE TABLE Placas (
        id NUMERIC(18,0) PRIMARY KEY IDENTITY(1,1),
        idLote NUMERIC(18,0) NOT NULL REFERENCES Lotes(id),
        idLeilao NUMERIC(18,0) NOT NULL REFERENCES Leiloes(id),
        placa VARCHAR(10) NOT NULL
)

CREATE TABLE Lances (
        id NUMERIC(18,0) PRIMARY KEY IDENTITY(1,1),
        idPlaca NUMERIC(18,0) NOT NULL REFERENCES Placas(id),
        idUsuario NUMERIC(18,0) NOT NULL REFERENCES Usuarios(id),
        valor NUMERIC(18,2) NOT NULL,
        dataCriacao DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
)