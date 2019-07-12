import os
import psycopg2
from flask import current_app, g

DATABASE_URL = os.environ['DATABASE_URL']

def initDB():
	conn = psycopg2.connect(DATABASE_URL)
	with conn.cursor() as cursor:
		cursor.execute(open("schema.sql", "r").read())
	conn.commit()
