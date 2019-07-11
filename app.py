from flask import Flask
import db
import os

app = Flask(__name__)
app.config.from_mapping(
		SECRET_KEY='dev',
		DATABASE=os.path.join(app.instance_path, 'flaskr.postgres'),
	)

@app.route('/')
def hello():
	return "Hello World!"
    
@app.route('/teste/')
def helloDB():
	db.initDB()
	return "Hello DB!"   

if __name__ == '__main__':
	app.run()
