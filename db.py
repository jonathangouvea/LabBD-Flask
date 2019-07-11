import os
import psycopg2

DATABASE_URL = os.environ['DATABASE_URL']

def initDB():
	conn = psycopg2.connect(DATABASE_URL, sslmode='require')
	with conn as cursor:
		cursor.execute(open("schema.sql", "r").read())
