DROP TABLE if exists Pessoa;
DROP SEQUENCE if exists gera_id_pessoa;

CREATE TABLE Pessoa
(
    id_pessoa INT CONSTRAINT pk_pessoa PRIMARY KEY,
    nome VARCHAR(60) CONSTRAINT pessoa_nome_nnu NOT NULL,
    senha VARCHAR(30) CONSTRAINT pessoa_senha_nnu NOT NULL,
    uf VARCHAR(2),
    cidade VARCHAR(30),
    bairro VARCHAR(30),
    rua VARCHAR(60),
    numero INT
);

create sequence gera_id_pessoa
start with 1 increment by 1 maxvalue 1000;

CREATE OR REPLACE FUNCTION AlimentaIDPessoa()
	RETURNS "trigger" AS
	$BODY$
	BEGIN
	New.id_pessoa:=nextval('gera_id_pessoa');
	Return NEW;
	END;
	$BODY$
	LANGUAGE 'plpgsql' VOLATILE;

-- trigger Para inserir pessoa
create trigger t_bef_ins_row_InserePessoa
    before insert
    on pessoa
    for each row
    EXECUTE PROCEDURE AlimentaIDPessoa();


insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Eduardo', 'minha senha', 'PA', 'Belem', 'Nazare', 'Nazare', 1234);
insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Gustavo', 'senhafacil', 'SP', 'São Carlos', 'Jardins', 'Oliveira', 125);
insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Fernando', 'pipopi', 'SP', 'São Jose dos Campos', 'Argentina', 'Rua 15', 365);
insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Jonatan', '12345', 'SP', 'São Paulo', 'Zona Lost', 'Paulista', 1564);
insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Carlos', '951753', 'SP', 'São Carlos', 'Planalto paraiso', 'Robson Luiz', 1489);
insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Vitor', 'mlpoki', 'SP', 'Campinas', 'Papoula', 'Rua das Luzes', 1597);
insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Alisson', 'senhadodc', 'SP', 'São Carlos', 'Jardins', 'Rosa', 134);
insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Amanda', 'senhapratudo', 'SP', 'São Carlos', 'Jardins', 'Tulipa', 234);
insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Fernanda', 'poiklnm', 'SP', 'São Carlos', 'Centro', 'Padre Teixeira', 1398);
insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Maria', 'poiuytghjkl', 'SP', 'Ribeirão Preto', 'Centro', 'Rua 9 de Julho', 1234);
insert into pessoa(nome, senha, uf, cidade, bairro, rua, numero) values ('Luis', '12345678', 'SP', 'Limeira', 'Vila', 'Rua 1 de Agosto', 250);
