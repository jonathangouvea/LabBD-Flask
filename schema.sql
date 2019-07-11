CREATE TABLE Pessoa
(
    id_pessoa INT CONSTRAINT pk_pessoa PRIMARY KEY,
    nome VARCHAR(30) CONSTRAINT pessoa_nome_nnu NOT NULL,
    senha VARCHAR(30) CONSTRAINT pessoa_senha_nnu NOT NULL,
    uf VARCHAR(2),
    cidade VARCHAR(30),
    bairro VARCHAR(30),
    rua VARCHAR(30),
    numero INT
);
