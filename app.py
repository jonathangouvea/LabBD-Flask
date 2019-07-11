from flask import Flask
import db

app = Flask(__name__)
app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'flaskr.postgres'),
    )

@app.route('/')
def hello():
    return "Hello World!"
    
@app.route('/teste/')
def hello():
	db.initDB()
    return "Hello DB!"   

if __name__ == '__main__':
    app.run()
