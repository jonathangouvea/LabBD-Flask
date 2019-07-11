import os
import psycopg2
from flask import current_app, g

DATABASE_URL = os.environ['DATABASE_URL']

def initDB():
	print(DATABASE_URL)
	if DATABASE_URL == 'postgresql://localhost/labbd':
		conn = psycopg2.connect(DATABASE_URL, user="postgres")
	else:
		conn = psycopg2.connect(DATABASE_URL)
	with conn.cursor() as cursor:
		cursor.execute(open("schema.sql", "r").read())
	conn.commit()
