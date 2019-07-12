import os
import psycopg2
from flask import current_app, g

DATABASE_URL = os.environ['DATABASE_URL']
conn = psycopg2.connect(DATABASE_URL)

def initDB():
	print("Deletando todas as tabelas...")
	with conn.cursor() as cursor:
		cursor.execute(open("schema_delete.sql", "r").read())
	
	print("Criando todas as tabelas...")
	with conn.cursor() as cursor:
		cursor.execute(open("schema_create.sql", "r").read())
	conn.commit()
	
	print("Inserindo editais...")
	with conn.cursor() as cursor:
		cursor.execute(open("schema_edital_insert.sql", "r").read())
	conn.commit()
	
	print("Criando views de edital...")
	
	conn.cursor().execute("CREATE OR REPLACE VIEW vEditais_Abertos AS \
	SELECT codigo, titulo, tipo, justificativa, (data_encerramento - data_abertura) AS tempo_restante \
	FROM edital \
	WHERE data_abertura <= current_date AND data_encerramento > current_date; ")
    
	conn.cursor().execute("CREATE OR REPLACE VIEW vEditais_Fechados AS \
	SELECT codigo, titulo, tipo, justificativa, data_encerramento   \
	FROM edital \
	WHERE data_encerramento <= current_date; ")
	
	conn.commit()
	print("Banco de Dados pronto para o uso")
	
def qtdEditais(abertos=True):
	code = "SELECT count(*) FROM vEditais_Abertos"
	if not abertos:
		code = "SELECT count(*) FROM vEditais_Fechados"
		
	with conn.cursor() as cur:
		cur.execute(code)
		dados = cur.fetchone()
		return int(dados[0])

def editais(pagina = 0, abertos = True):
	code = "SELECT * FROM vEditais_Abertos ORDER BY tempo_restante ASC, titulo LIMIT 15 OFFSET %s;"
	if not abertos:
		code = "SELECT * FROM vEditais_Fechados ORDER BY data_encerramento DESC, titulo LIMIT 15 OFFSET %s;"

	with conn.cursor() as cur:
		cur.execute(code, [pagina])
		dados = cur.fetchall()
		return dados
		
		
		
		
		
