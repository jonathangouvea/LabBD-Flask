from flask import Flask, render_template, g, redirect, flash
from flask import Blueprint, request, session, url_for
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
def index():
	return render_template('index.html')
	
@app.route('/editais/abertos/')
def editais1():
	ed = db.editais(pagina = 0)
	qtd = db.qtdEditais()
	return render_template('editaisAbertos.html', editais = ed, page = 0, qtd = qtd)
	
@app.route('/editais/fechados/')
def editais3():
	ed = db.editais(pagina = 0, abertos=False)
	qtd = db.qtdEditais(abertos=False)
	return render_template('editaisFechados.html', editais = ed, page = 0, qtd = qtd)

@app.route('/editais/abertos/<page>/')
def editais2(page):
	ed = db.editais(pagina = int(page)*15)
	qtd = db.qtdEditais()
	return render_template('editaisAbertos.html', editais = ed, page = int(page), qtd = qtd)

@app.route('/editais/fechados/<page>/')
def editais4(page):
	ed = db.editais(pagina = int(page)*15, abertos=False)
	qtd = db.qtdEditais(abertos=False)
	return render_template('editaisFechados.html', editais = ed, page = int(page), qtd = qtd)

@app.route('/aciepes/')
def aciepes1():
	return render_template('aciepes.html')
	
@app.route('/atividades/', methods=['GET', 'POST'])
def atividades1():
	if request.method == 'POST':
		titulo = request.form['titulo-atividade']
		ano = request.form['ano-atividade']
		tipo = request.form['tipo-atividade']
		campus = request.form['campus-atividade']
		codigo = request.form['codigo-atividade']
		chave = request.form['chave-atividade']
		
	return render_template('atividades.html')
    
@app.route('/teste/')
def helloDB():
	db.initDB()
	return "Hello DB!"  
	
@app.route('/extra/')
def extra():
	db.extra()
	return "More DB!"  
	
@app.route('/login/', methods=['GET', 'POST'])
def login():
	if request.method == 'POST':
		cpf = request.form['Username']
		senha = request.form['password']
		if not cpf:
			flash('Sem CPF ou Passaporte')
		elif not senha:
			flash('Sem Senha')
		else:
			dados = db.checaPessoa(cpf)
			if dados:
				print(dados)
				if (dados[1] != senha):
					flash('Senha incorreta')
				else:
					g.user = dados[0]
					g.nome = dados[1]
	return render_template('login.html')
	
@app.route('/registrar/', methods=['GET', 'POST'])
def registrar():
	if request.method == 'POST':
		print("!")
		nome = request.form['nome']
		print("!")
		cpf = request.form['cpf']
		print("!")
		senha = request.form['senha']
		print("!")
		estado = request.form['estado']
		cidade = request.form['cidade']
		print("!")
		bairro = request.form['bairro']
		print("!")
		rua = request.form['rua']
		print("!")
		numero = request.form['numero']
		print("!")
		funcao = request.form['funcao']
		print("!")
		
		if not nome:
			flash('Sem nome')
		elif not cpf:
			flash('Dados incorretos')
		elif not senha:
			flash('Dados incorretos')
		elif not cidade:
			flash('Dados incorretos')
		elif not bairro:
			flash('Dados incorretos')
		elif not rua:
			flash('Dados incorretos')
		elif not numero:
			flash('Dados incorretos')
		elif not funcao:
			flash('Dados incorretos')
		else:
			id_pessoa = db.criaPessoa(nome, cpf, senha, estado, cidade, bairro, rua, numero, funcao)
			if id_pessoa > -1:
				g.user = id_pessoa
				g.nome = nome
		
	return render_template('index.html')
	
@app.route('/editais/<id_edital>/')
def editaisDetalhes(id_edital):
	ed = db.editaisDetalhes(id_edital)

	return render_template('editalDetalhes.html', ed = ed)
	
@app.route('/atividades/<id_edital>/')
def atividadesDetalhes(id_edital):
	return id_edital
	
@app.route('/aciepes/detalhes/<id_edital>/')
def aciepesDetalhes(id_edital):
	return render_template('aciepeDetalhes.html')

if __name__ == '__main__':
	app.run()
