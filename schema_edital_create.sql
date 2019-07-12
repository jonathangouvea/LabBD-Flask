CREATE OR REPLACE VIEW vEditais_com_detalhes AS 
    SELECT data_abertura, data_encerramento, tipo, titulo, proponente, objetivo, bolsa, atividade, data, disposicao, e.codigo as id_edital
    FROM edital e,  proponente p, objetivo o, bolsa b, cronograma c, disposicoes_gerais d
	WHERE e.codigo = p.codigo_edital and e.codigo = o.codigo_edital and e.codigo = b.codigo_edital and e.codigo = c.codigo_edital and e.codigo = d.codigo_edital;
