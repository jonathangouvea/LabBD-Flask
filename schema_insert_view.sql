insert into edital (data_abertura, data_encerramento, justificativa, tipo, titulo, reoferta) 
values ('2019-05-18', '2020-11-18', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 'Blue', 'Varanus albigularis', false);

insert into bolsa(codigo_edital, bolsa) values (1, 'CNPq R$500,00');
insert into bolsa(codigo_edital, bolsa) values (1, 'FAPESP R$700,00');
insert into bolsa(codigo_edital, bolsa) values (1, 'CAPS R$450,00');

insert into proponente(codigo_edital, proponente) values (1, 'Carlos');
insert into proponente(codigo_edital, proponente) values (1, 'Jonathan');
insert into proponente(codigo_edital, proponente) values (1, 'Vitor');

insert into objetivo(codigo_edital, objetivo) values (1, 'Carlos');
insert into objetivo(codigo_edital, objetivo) values (1, 'Jonathan');
insert into objetivo(codigo_edital, objetivo) values (1, 'Vitor');

insert into cronograma(codigo_edital, atividade, data) values (1, 'Fazer o pipipi', '2019-05-18');
insert into cronograma(codigo_edital, atividade, data) values (1, 'Fazer o popopo', '2019-05-18');
insert into cronograma(codigo_edital, atividade, data) values (1, 'Fazer o pipipi popop', '2019-05-18');

insert into disposicoes_gerais(codigo_edital, disposicao) values (1, 'Fulaninho faz o pipipi');
insert into disposicoes_gerais(codigo_edital, disposicao) values (1, 'Fulanoso faz o popopo');
insert into disposicoes_gerais(codigo_edital, disposicao) values (1, 'Fulaníssimo faz o pipipi popopo');







