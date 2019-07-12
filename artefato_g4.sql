CREATE OR REPLACE VIEW vizualizaVerbas AS
	SELECT AtividadeDeExtensao.titulo, AlteracaoVerba.Data, AlteracaoVerba.Valor, AlteracaoVerba.Destino, AlteracaoVerba.Origem
		FROM AtividadeDeExtensao, AlteracaoVerba, Coordenador, CoordenadorCoordenaAtividade
		WHERE AtividadeDeExtensao.nro_extensao = CoordenadorCoordenaAtividade.nro_extensao AND Coordenador.id_pessoa = CoordenadorCoordenaAtividade.id_pessoa AND Coordenador.id_departamento = CoordenadorCoordenaAtividade.id_departamento AND Coordenador.nro_ufscar = AlteracaoVerba.Numero_UFSCar_Sol;

CREATE OR REPLACE FUNCTION CalculaTempoCoordenacao (nome_coordenador IN VARCHAR, titulo_atividade IN VARCHAR)
	RETURNS DATE AS $$
DECLARE
	v_nro_extensao CoordenadorCoordenaAtividade.nro_extensao%type;
	v_data_inicio CoordenadorCoordenaAtividade.InicioCoordenacao%type;
	v_data_fim CoordenadorCoordenaAtividade.FimCoordenacao%type;
BEGIN
	select Pessoa.nome, CoordenadorCoordenaAtividade.InicioCoordenacao, CoordenadorCoordenaAtividade.FimCoordenacao
		INTO v_data_inicio, v_data_fim
		FROM CoordenadorCoordenaAtividade
		WHERE Pessoa.nome = nome_coordenador AND Pessoa.id_pessoa = CoordenadorCoordena.id_pessoa AND CoordenadorCoordena.nro_extensao = AtividadeDeExtensao.nro_extensao AND
		Departamento.nome = nome_departamento AND Departamento.id_departamento = CoordenadorCoordena.id_departamento;
	RETURN v_data_fim - v_data_inicio;
end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW get_all_participantes_in_atividades AS
	SELECT pessoa.nome, pessoa.id_pessoa
		FROM pessoa, participante, AtividadeDeExtensao
		WHERE AtividadeDeExtensao.nro_extensao = participante.nro_extensao AND participante.nro_extensao = pessoa.id_pessoa;

CREATE OR REPLACE VIEW get_dados_from_atividade AS
	SELECT AtividadeDeExtensao.resumo, AtividadeDeExtensao.tipo_atividade, AtividadeDeExtensao.titulo, AtividadeDeExtensao.status, programadeExtensao.anotacoes_proex
		FROM AtividadeDeExtensao, programadeExtensao
		WHERE AtividadeDeExtensao.nro_extensao_programa = programadeExtensao.nro_extensao;


CREATE OR REPLACE FUNCTION sum_verba_atividade
(atividade IN INT)
RETURNS FLOAT AS $$
DECLARE
	cnumber FLOAT;
	valores cursor FOR SELECT SUM(financia.valor)
							FROM financia, ATIVIDADEDEEXTENSAO
							WHERE ATIVIDADEDEEXTENSAO.nro_extensao = atividade AND financia.nro_atividadeDeExtensao = ATIVIDADEDEEXTENSAO.nro_extensao;
BEGIN
	open valores;
	fetch valores into cnumber;
	Return cnumber;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW listar_atividades_extensao AS 
	SELECT atividade.nro_extensao_programa,id_financiador,id_area_pr,id_area_se,publico_alvo,palavras_chave,resumo,inicio_real,fim_real,inicio_previsto,fim_previsto,data_aprovacao,tipo_atividade,titulo,status, id_pessoa, id_departamento
		FROM AtividadeDeExtensao atividade, CoordenadorCoordenaAtividade coordena WHERE atividade.nro_extensao = coordena.nro_extensao;

CREATE OR REPLACE FUNCTION calcular_carga_horaria_prevista(nro IN INT)
		RETURNS INT AS $$
	DECLARE
		calculo CURSOR FOR SELECT fim_previsto - inicio_previsto AS carga_horaria FROM AtividadeDeExtensao WHERE nro_extensao = nro;
		carga_horaria INT;
	BEGIN
		open calculo;

		if calculo%notfound then
			RAISE EXCEPTION 'atividade nao encontrada';
		end if;

		FETCH calculo INTO carga_horaria;

		CLOSE calculo;

		RETURN carga_horaria;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE logar (cpf IN CHAR, passaporte IN CHAR, id_pessoa INOUT INT)
	AS $$
	DECLARE
		buscaCPF CURSOR FOR SELECT id_pessoa FROM PessoaBrasileira pessoa WHERE pessoa.cpf = cpf;
		buscaPAS CURSOR FOR SELECT id_pessoa FROM PessoaEstrangeira pessoa WHERE pessoa.passaporte = passaporte;

	BEGIN
		if cpf != NULL then
			OPEN buscaCPF;
			FETCH buscaCPF INTO id_pessoa;
			CLOSE buscaCPF;
		else
			OPEN buscaPAS;
			FETCH buscaPAS INTO id_pessoa;
			CLOSE buscaPAS; 
		end if;
END;
$$ LANGUAGE plpgsql;