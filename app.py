from flask import Flask, render_template, g, redirect, flash, Blueprint, request, session, url_for
import db
import os
import auth

app = Flask(__name__)
app.config.from_mapping(
		SECRET_KEY='dev',
		DATABASE=os.path.join(app.instance_path, 'flaskr.postgres'),
	)
app.register_blueprint(auth.bp)

@app.route('/')
def hello():
	return render_template('index.html')
    
@app.route('/teste/')
def helloDB():
	db.initDB()
	return "Hello DB!"   

if __name__ == '__main__':
	app.run()
