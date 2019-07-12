CREATE TABLE edital(
    codigo SERIAL PRIMARY KEY,
    data_abertura DATE NOT NULL,
    data_encerramento DATE NULL,
    justificativa TEXT NOT NULL,
    tipo VARCHAR(30) NOT NULL, -- pode ser de Projetos, Cursos, Eventos, Consultorias, Publicações, Produtos, eventos ou palestras
    titulo VARCHAR(130) NOT NULL,
    reoferta BOOLEAN NOT NULL
);

CREATE TABLE bolsa(
    codigo_edital INT NOT NULL,
    bolsa VARCHAR(100),
    
    PRIMARY KEY (codigo_edital,bolsa),
    CONSTRAINT bolsa_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE proponente(
    codigo_edital INT NOT NULL,
    proponente VARCHAR(30),
    
    PRIMARY KEY (codigo_edital,proponente),
    CONSTRAINT proponente_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE objetivo(
    codigo_edital INT NOT NULL,
    objetivo VARCHAR(50),
    
    PRIMARY KEY (codigo_edital,objetivo),
    CONSTRAINT objetivo_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE cronograma(
    codigo_edital INT NOT NULL,
    atividade VARCHAR(50),
    data DATE,
    
    PRIMARY KEY (codigo_edital,atividade,data),
    CONSTRAINT cronograma_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE disposicoes_gerais(
    codigo_edital INT NOT NULL,
    disposicao VARCHAR(150),
    
    PRIMARY KEY (codigo_edital,disposicao),
    CONSTRAINT disposicoes_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE edital_atividade(
    codigo_edital INT NOT NULL PRIMARY KEY,

    CONSTRAINT edital_atividade_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE edital_programa(
    codigo_edital INT NOT NULL PRIMARY KEY,

    CONSTRAINT edital_programa_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE orgao_avaliador(
    id_orgao SERIAL,
    sigla VARCHAR(10) NOT NULL,
    nome VARCHAR(130) NOT NULL,
    CONSTRAINT pk_orgao PRIMARY KEY(id_orgao)
);
 
/*Pessoa(PK(id_pessoa), nome, senha, uf, cidade, bairro, rua, numero);*/
CREATE TABLE Pessoa
(
    id_pessoa SERIAL CONSTRAINT pk_pessoa PRIMARY KEY,
    nome VARCHAR(30) CONSTRAINT pessoa_nome_nnu NOT NULL,
    senha VARCHAR(30) CONSTRAINT pessoa_senha_nnu NOT NULL,
    uf VARCHAR(2),
    cidade VARCHAR(30),
    bairro VARCHAR(30),
    rua VARCHAR(30),
    numero INT
);

/*Pessoa_Telefone(PK(FK_Pessoa(id_pessoa), fixo, ddd, ddi));*/
CREATE TABLE Pessoa_Telefone
(
    id_pessoa INT NOT NULL,
    fixo VARCHAR(9) NOT NULL,
    ddd CHAR(2) NOT NULL,
    ddi VARCHAR(4),
    
    CONSTRAINT pk_pessoa_telefone PRIMARY KEY (id_pessoa, fixo, ddd, ddi),
    CONSTRAINT fk_pessoa_telefone_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

/*Pessoa_Email(PK(FK_Pessoa(id_pessoa), email));*/
CREATE TABLE Pessoa_Email
(
    id_pessoa INT NOT NULL,
    email VARCHAR(30) NOT NULL,
    
    CONSTRAINT pk_pessoa_email PRIMARY KEY (id_pessoa, email),
    CONSTRAINT fk_pessoa_email_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

/*PessoaBrasileira(PK(cpf), FK_Pessoa(id_pessoa));*/
CREATE TABLE PessoaBrasileira
(
    cpf CHAR(11) NOT NULL,
    id_pessoa INT NOT NULL,
    
    CONSTRAINT pk_pessoaBrasileira PRIMARY KEY (id_pessoa, cpf),
    CONSTRAINT fk_pessoaBrasileira_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

/*PessoaEstrangeira(PK(passaporte), FK_Pessoa(id_pessoa));*/
CREATE TABLE PessoaEstrangeira
(
    passaporte CHAR(8) NOT NULL,
    id_pessoa INT NOT NULL,
    
    CONSTRAINT pk_pessoaEstrangeira PRIMARY KEY (id_pessoa, passaporte),
    CONSTRAINT fk_pessoaEstrangeira_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

/*Departamento(PK(id_departamento), nome);*/
CREATE TABLE Departamento
(
    id_departamento SERIAL CONSTRAINT pk_departamento PRIMARY KEY,
    nome VARCHAR(65)
);

/*PessoaGraduacao(PK(FK_Pessoa(id_pessoa)), nro_ufscar);*/
CREATE TABLE PessoaGraduacao
(
    id_pessoa INT NOT NULL,
    nro_ufscar INT NOT NULL,
    
    CONSTRAINT pk_pessoaGraduacao PRIMARY KEY (id_pessoa),
    CONSTRAINT fk_pessoaGraduacao_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

/*PessoaPosgraduacao(PK(FK_Pessoa(id_pessoa)), nro_ufscar);*/
CREATE TABLE PessoaPosgraduacao
(
    id_pessoa INT NOT NULL,
    nro_ufscar INT NOT NULL,
    
    CONSTRAINT pk_pessoaposgraduacao PRIMARY KEY (id_pessoa),
    CONSTRAINT fk_pessoaposgraduacao_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);


/*PessoaServidor(PK(FK_Pessoa(id_pessoa), FK_Departamento(id_departamento)), nro_ufscar, data_contratacao);*/
CREATE TABLE PessoaServidor
(
    id_pessoa INT,
    id_departamento INT CONSTRAINT fk_pessoaServidor_departamento REFERENCES Departamento(id_departamento),
    nro_ufscar INT UNIQUE NOT NULL,
    data_contratacao DATE,
    CONSTRAINT pk_pessoaServidor PRIMARY KEY (id_pessoa, id_departamento),
    CONSTRAINT fk_pessoaServidor FOREIGN Key (id_pessoa) REFERENCES Pessoa(id_pessoa)    
);

/*PessoaServidorDocente(PK(FK_PessoaServidor(id_pessoa, id_departamento)), titulo, cargo, setor, tipo, data_ingresso);*/

CREATE TABLE PessoaServidorDocente
(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    titulo VARCHAR(30) NOT NULL,
    cargo VARCHAR(30) NOT NULL,
    setor VARCHAR(30) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    data_ingresso DATE,
    CONSTRAINT pk_pessoaservidordocente PRIMARY KEY (id_pessoa, id_departamento),
    CONSTRAINT fk_pessoaservidordocente_pessoaservidor FOREIGN KEY (id_pessoa, id_departamento) REFERENCES PessoaServidor(id_pessoa, id_departamento)
);

/*PessoaServidorTecnico(PK(FK_PessoaServidor(id_pessoa, id_departamento)));*/

CREATE TABLE PessoaServidorTecnico
(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    CONSTRAINT fk_pessoaservidortecnico_pessoaservidor FOREIGN KEY (id_pessoa, id_departamento) REFERENCES PessoaServidor(id_pessoa, id_departamento),
    CONSTRAINT pk_pessoaservidortecnico PRIMARY KEY (id_pessoa, id_departamento)
);

/*Curso(PK(id_curso), FK_Departamento(id_departamento));*/

CREATE TABLE Curso
(
    id_curso SERIAL NOT NULL,
    id_departamento INT NOT NULL,
    CONSTRAINT fk_curso_departamento FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento),
    CONSTRAINT pk_curso PRIMARY KEY (id_curso)
);

/*Financiador(PK(id_financiador), agencia, tipo_controle);*/

CREATE TABLE Financiador
(
    id_financiador SERIAL NOT NULL,
    agencia VARCHAR(10),
    tipo_controle VARCHAR(10), -- O que significa esse atributo?? !!!!!!!!!!!!!
    CONSTRAINT pk_financiador PRIMARY KEY (id_financiador)
);


/*Extensao(PK(nro_extensao), nro_extensao_anterior);*/
--O que essa entidade representa? Uma atividade ou programa de extensão já aprovado
CREATE TABLE Extensao
(
    nro_extensao SERIAL NOT NULL,
    nro_extensao_anterior INT,
    CONSTRAINT pk_extensao PRIMARY KEY (nro_extensao)
);

/*ProgramaDeExtensao(PK(FK_Extensao(nro_extensao)), palavras_chave, titulo, resumo, comunidade_atingida, anotacoes_ProEx, inicio);*/
CREATE TABLE ProgramaDeExtensao
(
    nro_extensao INT NOT NULL,
    palavras_chave VARCHAR(50),
    titulo VARCHAR(30) NOT NULL,
    resumo TEXT,
    comunidade_atingida VARCHAR(50),
    anotacoes_ProEx TEXT,
    inicio DATE,
    
    CONSTRAINT pk_programaDeExtensao PRIMARY KEY (nro_extensao),
    CONSTRAINT fk_programaDeExtensao_extensao FOREIGN KEY (nro_extensao) REFERENCES Extensao(nro_extensao)
);

/*Area(PK(id_area), nome_area);*/
CREATE TABLE Area
(
    id_area SERIAL NOT NULL,
    nome_area VARCHAR(50) NOT NULL,
    CONSTRAINT pk_area PRIMARY KEY (id_area)
);


/*Area_tem_subareas(PK(FK_Area(id_area), id_subarea), nome_area);*/
CREATE TABLE Area_tem_subareas
(
    id_area INT NOT NULL,
    id_subarea INT NOT NULL,
    nome_area VARCHAR(50) NOT NULL,
    CONSTRAINT pk_area_tem_subareas PRIMARY KEY (id_area, id_subarea),
    CONSTRAINT fk_area_tem_subareas_area FOREIGN KEY (id_area) REFERENCES Area(id_area)
);

/*AtividadeDeExtensao(PK(FK_Extensao(nro_extensao)), FK_ProgramaDeExtensao(nro_extensao_pr), FK_Financiador(id_financiador), FK1_Area(id_area_pr), FK2_Area(id_area_se), publico_alvo, palavras_chave, resumo, inicio_real, fim_real, inicio_previsto, fim_previsto, data_aprovacao, tipo_atividade, titulo, status);*/
CREATE TABLE AtividadeDeExtensao
(
    nro_extensao INT NOT NULL,
    nro_extensao_programa INT NOT NULL,
    id_financiador INT,
    id_area_pr INT NOT NULL,
    id_area_se INT NOT NULL,
    publico_alvo VARCHAR(50),
    palavras_chave VARCHAR(50),
    resumo TEXT,
    inicio_real DATE,
    fim_real DATE,
    inicio_previsto DATE,
    fim_previsto DATE,
    data_aprovacao DATE,
    tipo_atividade VARCHAR(20),
    titulo VARCHAR(30),
    status VARCHAR(20),
    
    CONSTRAINT pk_atividadeDeExtensao PRIMARY KEY (nro_extensao),
    CONSTRAINT fk_atividadeDeExtensao_extensao FOREIGN KEY (nro_extensao) REFERENCES Extensao(nro_extensao),
    CONSTRAINT fk_atividadeDeExtensao_programaDeExtensao FOREIGN KEY (nro_extensao_programa) REFERENCES ProgramaDeExtensao(nro_extensao),
    CONSTRAINT fk_atividadeDeExtensao_financiador FOREIGN KEY (id_financiador) REFERENCES Financiador(id_financiador),
    CONSTRAINT fk_atividadeDeExtensao_area1 FOREIGN KEY (id_area_pr) REFERENCES Area(id_area),
    CONSTRAINT fk_atividadeDeExtensao_area2 FOREIGN KEY (id_area_se) REFERENCES Area(id_area)
);

/*Aciepe(PK(FK_AtividadeDeExtensao(nro_extensao)), horario_aulas, ementa, carga_horaria_prevista);*/
CREATE TABLE Aciepe
(
    nro_extensao INT NOT NULL,
    horario_aulas VARCHAR(30),
    ementa TEXT,
    carga_horaria_prevista INT,
    CONSTRAINT pk_Aciepe PRIMARY KEY (nro_extensao),
    CONSTRAINT pk_Aciepe_AtividadeDeExtensao FOREIGN KEY (nro_extensao) REFERENCES AtividadeDeExtensao(nro_extensao)
);

/*Aciepe_Encontros(PK(FK_Aciepe(nro_extensao), data, horario, local, campus));*/
CREATE TABLE Aciepe_Encontros
(
    nro_extensao INT NOT NULL,
    data DATE,
    horario VARCHAR(20),
    local VARCHAR(30),
    campus VARCHAR(15),
    
    CONSTRAINT pk_Aciepe_Encontros PRIMARY KEY (nro_extensao),
    CONSTRAINT fk_Aciepe_Encontros_Aciepe FOREIGN KEY (nro_extensao) REFERENCES Aciepe(nro_extensao)
);

/*Participante(PK(FK_Pessoa(id_pessoa), FK_AtividadeDeExtensao(nro_extensao)), frequencia, avaliacao);*/
CREATE TABLE Participante
(
    id_pessoa INT NOT NULL,
    nro_extensao INT NOT NULL, --O que significa esse atributo? !!!!!!!!
    frequencia INT, --frequencia como sinônimo de faltas
    avaliacao FLOAT CHECK (avaliacao >= 0 and avaliacao <= 10),
    
    CONSTRAINT pk_Participante PRIMARY KEY (id_pessoa, nro_extensao),
    CONSTRAINT fk_Participante_Pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa),
    CONSTRAINT fk_Participante_AtividadeDeExtensao FOREIGN KEY (nro_extensao) REFERENCES AtividadeDeExtensao(nro_extensao)
);


CREATE TABLE Coordenador
(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    nro_ufscar INT UNIQUE NOT NULL,
    
    CONSTRAINT pk_Coordenador PRIMARY KEY (id_pessoa, id_departamento),
    CONSTRAINT fk_Coordenador_Servidor FOREIGN KEY (id_pessoa, id_departamento)
        REFERENCES PessoaServidor (id_pessoa, id_departamento),
    CONSTRAINT fk_Coordenador_Servidor2 FOREIGN KEY (nro_ufscar) REFERENCES PessoaServidor (nro_ufscar)
);

/*Selecao(PK(id_selecao), nro_inscritos, vagas_interno, vagas_externo);*/
CREATE TABLE Selecao
(    
    id_selecao SERIAL NOT NULL,
    nro_inscritos INT,
    vagas_interno INT,
    vagas_externo INT,
    CONSTRAINT pk_Selecao PRIMARY KEY (id_selecao)
);

/*Participante_participa_Selecao(PK(FK_Participante(id_pessoa, nro_extensao), FK_Selecao(id_selecao)), declaracao_presenca, selecionado);*/
CREATE TABLE Participante_participa_Selecao
(
    id_pessoa INT NOT NULL,
    nro_extensao INT NOT NULL,
    id_selecao INT NOT NULL,
    declaracao_presenca VARCHAR(10),
    selecionado BOOLEAN,
    CONSTRAINT pk_Participante_participa_Selecao PRIMARY KEY (id_pessoa, nro_extensao, id_selecao),
    CONSTRAINT fk_Participante_participa_Selecao_Participante FOREIGN KEY (id_pessoa, nro_extensao) REFERENCES Participante(id_pessoa, nro_extensao),
    CONSTRAINT fk_Participante_participa_Selecao_Selecao FOREIGN KEY (id_selecao) REFERENCES Selecao(id_selecao)
);


----------------------------
----------Reunião
----------------------------

CREATE TABLE Reuniao (
    id_reuniao               SERIAL NOT NULL,
    documento_apresentacao    TEXT,
    orgao                    CHAR(4), --caex ou coex
    data_inicio              DATE, -- geração do atributo derivado duração
    data_fim             DATE,
    
    CONSTRAINT PK_Reuniao PRIMARY KEY (id_reuniao)
    
);

CREATE TABLE ReuniaoAta (
    nro_ata     INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    id_reuniao  INT,
    ata      TEXT,

    CONSTRAINT PK_ReuniaoAta PRIMARY KEY (nro_ata, id_reuniao),
    CONSTRAINT FK_ReuniaoAta
        FOREIGN KEY (id_reuniao) REFERENCES Reuniao(id_reuniao)
);

CREATE TABLE ReuniaoAvalia (
    id_reuniao           INT,
    id_pessoa           INT,
    codigo_edital        INT,
    veredito             TEXT,
    recorrencia          TEXT,

    CONSTRAINT PK_ReuniaoAvalia
     PRIMARY KEY (id_pessoa,id_reuniao,codigo_edital),
     
    CONSTRAINT FK_ReuniaoAvalia_Pessoa
     FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa),

    CONSTRAINT FK_ReuniaoAvalia_Reuniao
     FOREIGN KEY (id_reuniao) REFERENCES Reuniao(id_reuniao),

    CONSTRAINT FK_ReuniaoAvalia_Edital
     FOREIGN KEY (codigo_edital) REFERENCES Edital(codigo)

);

CREATE TABLE ReuniaoParticipa (
    id_reuniao                   INT,
    id_pessoa                    INT,
    data_participacao            DATE,
    presenca                 NUMERIC(1,0) CHECK (presenca=0 OR presenca=1),
    justificativa                TEXT,
    recurso_justificativa        TEXT,
    aprovacao_justificativa     TEXT,

    CONSTRAINT PK_ReuniaoParticipa
     PRIMARY KEY (id_pessoa,id_reuniao),

    CONSTRAINT FK_ReuniaoParticipa_Reuniao
     FOREIGN KEY (id_reuniao) REFERENCES Reuniao(id_reuniao),

    CONSTRAINT FK_ReuniaoParticipa_Pessoa
     FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

CREATE TABLE Demandante(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    nro_ufscar INT NOT NULL,
    data_contratacao DATE,

    CONSTRAINT PK_Demandante PRIMARY KEY (id_pessoa,id_departamento),

    CONSTRAINT FK_PessoaServidor_id_pessoa FOREIGN KEY (id_pessoa, id_departamento) REFERENCES PessoaServidor(id_pessoa, id_departamento)
);

CREATE TABLE Submete(
    codigo_edital INT NOT NULL,
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,

    CONSTRAINT PK_Submete PRIMARY KEY (codigo_edital, id_pessoa, id_departamento),

    CONSTRAINT FK_Edital_codigo FOREIGN KEY (codigo_edital) REFERENCES Edital(codigo),
    CONSTRAINT FK_Demandante_ids FOREIGN KEY (id_pessoa,id_departamento) REFERENCES Demandante(id_pessoa,id_departamento)
);

CREATE TABLE Proposta(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    codigo_edital INT NOT NULL,
    nro_processo INT NOT NULL,
    tipo VARCHAR(20),
    status VARCHAR(20),
    areatematica_grandearea VARCHAR(50),
    areatematica_areasecundaria VARCHAR(50),
    areatematica_areaprincipal VARCHAR(50),
    resumo VARCHAR(50),
    comunidade_atingida VARCHAR(50),
    publico_alvo VARCHAR(50),
    DataFim date,
    DataInicio date NOT NULL,
    descricao VARCHAR(50),
    setor_responsavel VARCHAR(50),
    abrangencia VARCHAR(50),

    CONSTRAINT PK_Proposta PRIMARY KEY (id_pessoa, id_departamento, nro_processo, codigo_edital),

    CONSTRAINT FK_Submete_ids FOREIGN KEY (codigo_edital, id_pessoa, id_departamento) REFERENCES Submete(codigo_edital, id_pessoa, id_departamento)
);

CREATE TABLE Tramitacao (
    id_pessoa INT,
    id_departamento INT,
    codigo_edital INT,
    nro_processo INT,
    nro_extensao INT,
    tipo BOOLEAN, --BOOL, considerando que tipo é o resultado da tramitação
    julgamento TEXT,
    data DATE,

    constraint Tramitacao_pk primary key (id_pessoa, id_departamento, codigo_edital, nro_processo, nro_extensao),
    constraint Tramitacao_proposta_fk foreign key (nro_processo, id_pessoa, id_departamento, codigo_edital)
     references Proposta (nro_processo, id_pessoa, id_departamento, codigo_edital),
    constraint Tramitacao_extensao_fk foreign key (nro_extensao) references Extensao (nro_extensao)
);



CREATE TABLE Avaliador (
    id_pessoa INT,
    id_departamento INT,
    representatividade VARCHAR(20),
    mandatoInicio DATE,
    mandatoFim DATE,

    constraint Avaliador_pk primary key (id_pessoa, id_departamento),
    constraint Avaliador_servidor_fk foreign key (id_pessoa, id_departamento)
     references PessoaServidor (id_pessoa, id_departamento)

);


CREATE TABLE julga (
    id_pessoa        INT,
    codigo_edital     INT,
    Id_reuniao       INT,
    justificativa    TEXT,
    posicionamento    TEXT,
    
    CONSTRAINT PK_Julga PRIMARY KEY (id_pessoa, codigo_edital, Id_reuniao),
    CONSTRAINT FK_id_pessoa_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa),
    CONSTRAINT FK_codigo_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo),
    CONSTRAINT FK_id_reuniao FOREIGN KEY (id_reuniao) REFERENCES Reuniao(id_reuniao)
);


CREATE TABLE julga_1 (
    id_pessoa        INT,
    id_departamento INT,
    codigo_edital   INT,
    nro_processo    INT,
    Id_reuniao       INT,
    veredito    TEXT,
    recorrencia      TEXT,
    
    CONSTRAINT PK_Julga_1 PRIMARY KEY (id_pessoa, nro_processo, Id_reuniao, id_departamento, codigo_edital),
    CONSTRAINT FK_julga1_proposta FOREIGN KEY (id_pessoa, id_departamento, codigo_edital, nro_processo) 
        REFERENCES Proposta (id_pessoa, id_departamento, codigo_edital, nro_processo),
    CONSTRAINT FK_id_reuniao_1 FOREIGN KEY (Id_reuniao) REFERENCES Reuniao(id_reuniao)
);

CREATE TABLE julga_2 (
    id_pessoa        INT,
    id_departamento INT,
    codigo_edital   INT,
    nro_processo    INT,
    Id_reuniao       INT,
    id_servidor     INT,
    id_dept_servidor INT,
    justificativa    TEXT,
    recorrencia      TEXT,
    
    CONSTRAINT PK_Julga_2 PRIMARY KEY (id_pessoa, nro_processo, Id_reuniao, id_departamento, codigo_edital, id_servidor, id_dept_servidor),
    CONSTRAINT FK_julga2_julga1 FOREIGN KEY (id_pessoa, nro_processo, Id_reuniao, id_departamento, codigo_edital) 
        REFERENCES julga_1 (id_pessoa, nro_processo, Id_reuniao, id_departamento, codigo_edital),
    CONSTRAINT FK_julga2_avaliador FOREIGN KEY (id_servidor, id_dept_servidor) 
        REFERENCES Avaliador (id_pessoa, id_departamento)
);

--

CREATE TABLE Parecer (
    id_pessoa INT,
    id_departamento INT,
    codigo_edital INT,
    nro_processo INT,
    nro_extensao INT,
    num_parecer INT,
    descricao TEXT,

    constraint Parecer_pk primary key (id_pessoa, id_departamento, codigo_edital, nro_processo, nro_extensao, num_parecer),
    constraint Parecer_tramitacao_fk foreign key (nro_processo, id_pessoa, id_departamento, codigo_edital, nro_extensao)
     references Tramitacao (nro_processo, id_pessoa, id_departamento, codigo_edital, nro_extensao)
);


CREATE TABLE Aprovador (
    Numero_UFSCar    INT,
    CONSTRAINT PK_Aprovador PRIMARY KEY (Numero_UFSCar),
    CONSTRAINT FK_Aprovador FOREIGN KEY (Numero_UFSCar) REFERENCES PessoaServidor (nro_ufscar)
);

CREATE TABLE AlteracaoVerba (
    Numero_UFSCar_Apr        INT,
    Numero_UFSCar_Sol        INT,
    Data                     DATE,
    Estado_da_aprovacao      TEXT,
    Valor                    INT,
    Destino                  TEXT,
    Origem                   TEXT,
    CONSTRAINT PK_AlteracaoVerba PRIMARY KEY (Numero_UFSCar_Sol, Numero_UFSCar_Apr, Data),
    CONSTRAINT FK_AlteracaoVerba_Sol FOREIGN KEY (Numero_UFSCar_Sol) REFERENCES Coordenador (nro_ufscar),
    CONSTRAINT FK_AlteracaoVerba_Apr FOREIGN KEY (Numero_UFSCar_Apr) REFERENCES PessoaServidor (nro_ufscar)
);

CREATE TABLE AlteracaoConteudo (
    Numero_UFSCar_Apr        INT,
    Numero_UFSCar_Sol        INT,
    Data                     DATE,
    Estado_da_aprovacao      TEXT,
    Conteudo_substituido    TEXT,
    CONSTRAINT PK_AlteracaoVerbaConteudo PRIMARY KEY (Numero_UFSCar_Sol, Numero_UFSCar_Apr, Data),
    CONSTRAINT FK_AlteracaoVerba_Sol2 FOREIGN KEY (Numero_UFSCar_Sol) REFERENCES Coordenador (nro_ufscar), 
    CONSTRAINT FK_AlteracaoVerba_Apr2 FOREIGN KEY (Numero_UFSCar_Apr) REFERENCES PessoaServidor (nro_ufscar)
);

--drop table AlteracaoIntegrante
CREATE TABLE AlteracaoIntegrante (
    Numero_UFSCar_Apr        INT,
    Numero_UFSCar_Sol        INT,
    Data                     DATE,
    Estado_da_aprovacao      TEXT,
    Status                   TEXT,
    CONSTRAINT PK_AlteracaoVerbaIntegrante PRIMARY KEY (Numero_UFSCar_Sol, Numero_UFSCar_Apr, Data),
    CONSTRAINT FK_AlteracaoVerba_Sol3 FOREIGN KEY (Numero_UFSCar_Sol) REFERENCES Coordenador (nro_ufscar),
    CONSTRAINT FK_AlteracaoVerba_Apr3 FOREIGN KEY (Numero_UFSCar_Apr) REFERENCES PessoaServidor (nro_ufscar)
);

--


CREATE TABLE SetoresParticipantes(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    nro_processo INT    NOT NULL,
    codigo_edital INT NOT NULL,
    setores VARCHAR(50),

    CONSTRAINT PK_SetoresParticipantes PRIMARY KEY (id_pessoa, id_departamento, nro_processo, codigo_edital),
    CONSTRAINT FK_Proposta_ids1 FOREIGN KEY (id_pessoa, id_departamento, nro_processo, codigo_edital) 
        REFERENCES Proposta(id_pessoa, id_departamento, nro_processo, codigo_edital)
);

CREATE TABLE Parcerias(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    nro_processo INT    NOT NULL,
    codigo_edital INT NOT NULL,
    setores VARCHAR(50),

    CONSTRAINT PK_Parcerias PRIMARY KEY (id_pessoa, id_departamento, nro_processo, codigo_edital),
    CONSTRAINT FK_Proposta_ids2 FOREIGN KEY (id_pessoa, id_departamento, nro_processo, codigo_edital) 
        REFERENCES Proposta(id_pessoa, id_departamento, nro_processo, codigo_edital)
);

CREATE TABLE PalavrasChave(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    nro_processo INT    NOT NULL,
    codigo_edital INT NOT NULL,
    palavras VARCHAR(50),

    CONSTRAINT PK_PalavrasChave PRIMARY KEY (id_pessoa, id_departamento, nro_processo, codigo_edital),

    CONSTRAINT FK_Proposta_ids3 FOREIGN KEY (id_pessoa, id_departamento, nro_processo, codigo_edital) 
        REFERENCES Proposta(id_pessoa, id_departamento, nro_processo, codigo_edital)
);

CREATE TABLE LinhaProgramatica(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    nro_processo INT    NOT NULL,
    codigo_edital INT NOT NULL,
    data1 DATE,
    horario TIMESTAMP,
    atividade VARCHAR(50),

    CONSTRAINT PK_LinhaProgramatica PRIMARY KEY (id_pessoa, id_departamento, nro_processo, codigo_edital),

    CONSTRAINT FK_Proposta_ids4 FOREIGN KEY (id_pessoa, id_departamento, nro_processo, codigo_edital) 
        REFERENCES Proposta(id_pessoa, id_departamento, nro_processo, codigo_edital)
);

CREATE TABLE Anotacoes(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    nro_processo INT    NOT NULL,
    codigo_edital INT NOT NULL,
    anotacoes VARCHAR(200),

    CONSTRAINT PK_Anotacoes PRIMARY KEY (id_pessoa, id_departamento, nro_processo, codigo_edital),

    CONSTRAINT FK_Proposta_ids5 FOREIGN KEY (id_pessoa, id_departamento, nro_processo, codigo_edital) 
        REFERENCES Proposta(id_pessoa, id_departamento, nro_processo, codigo_edital)
);

CREATE TABLE Errata
(
    CodigoEdital INT NOT NULL,
    Conteudo VARCHAR(4000),
    CONSTRAINT pk_Errata PRIMARY KEY (CodigoEdital, Conteudo),
    CONSTRAINT fk_Errata FOREIGN KEY (CodigoEdital) REFERENCES edital(codigo) 
);

CREATE TABLE CoordenadorCoordenaAtividade
(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    nro_extensao INT NOT NULL,
    InicioCoordenacao DATE,
    FimCoordenacao DATE,
    Cargo VARCHAR(30),
    CONSTRAINT pk_CoordenadorCoordenaAtividade PRIMARY KEY (id_pessoa, id_departamento, nro_extensao, InicioCoordenacao, Cargo),
    CONSTRAINT fk_CoordenadorCoordenaAtividade_Coord FOREIGN KEY (id_pessoa, id_departamento) REFERENCES Coordenador(id_pessoa, id_departamento),
    CONSTRAINT fk_CoordenadorCoordenaAtividade_Ativ FOREIGN KEY (nro_extensao) REFERENCES AtividadeDeExtensao(nro_extensao)
);

CREATE TABLE CoordenadorViceCoordenaAtividade(
    id_pessoa INT NOT NULL,
    id_departamento INT NOT NULL,
    nro_extensao INT NOT NULL,
    InicioCoordenacao DATE NOT NULL,
    FimCoordenacao DATE,

    CONSTRAINT pk_coordenadorViceCoordenaAtividade PRIMARY KEY (id_pessoa, id_departamento, nro_extensao),
    CONSTRAINT fk_coordenadorViceCoordenaAtividade_coordenador FOREIGN KEY (id_pessoa, id_departamento) REFERENCES Coordenador (id_pessoa, id_departamento),
    CONSTRAINT fk_coordenadorViceCoordenaAtividade_atividadeDeExtensao FOREIGN KEY (nro_extensao) REFERENCES AtividadeDeExtensao (nro_extensao)
);

CREATE TABLE Financia
(
	id_financia INT NOT NULL,
	nro_financiador INT NOT NULL,
	valor INT,
	nro_atividadeDeExtensao INT,
	
	CONSTRAINT pk_Financia PRIMARY KEY (id_financia, nro_atividadeDeExtensao),
	CONSTRAINT fk_Financiador_nroFinanciador FOREIGN KEY (nro_financiador) REFERENCES financiador(id_financiador),
	CONSTRAINT fk_Financiador_AtividadeDeExtensao FOREIGN KEY (nro_atividadeDeExtensao) REFERENCES AtividadeDeExtensao(nro_extensao)
);
