import os
import psycopg2

DATABASE_URL = os.environ['DATABASE_URL']

def initDB():
	print(DATABASE_URL)
	conn = psycopg2.connect(DATABASE_URL, user="postgres")
	with conn.cursor() as cursor:
		cursor.execute(open("schema.sql", "r").read())
	conn.commit()
