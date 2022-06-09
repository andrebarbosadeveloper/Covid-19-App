from flask import Flask, Response, request
import json
from flask import Flask, request, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import jwt
import datetime
from functools import wraps
from datetime import datetime, date, time, timedelta
from sqlalchemy import select, desc, asc
import base64

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your secret key'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://barbosa@localhost/AppCovid'

db = SQLAlchemy(app)


# Local
class Locais(db.Model):
    __tablename__ = 'locais'

    id = db.Column(db.Integer, primary_key=True)
    #  children = db.relationship("Reservas", back_populates="reserva",lazy='dynamic') #teste
    # reserva = db.relationship('reservas', backref='local', lazy=True)
    # reservas=  db.relationship('reservas')

    # reserva_id = db.Column(db.Integer, db.ForeignKey('reserva.id'), nullable=False)

    nome = db.Column(db.String(200), nullable=False, unique=True)
    lugares = db.Column(db.Integer)
    descricao = db.Column(db.String(1000))
    horario_abertura = db.Column(db.DATETIME)  # qual é o formato da data ?
    horario_fecho = db.Column(db.DATETIME)
    localizacao = db.Column(db.String(50))
    imagem = db.Column(db.TEXT(10000000))
    morada = db.Column(db.String(1000))

    def to_json(self):
        return {"id": self.id,
                # "reserva_id": self.reserva_id,
                "nome": self.nome,
                "lugares": self.lugares,
                "descricao": self.descricao,
                "horario_abertura": self.horario_abertura.isoformat(),
                "horario_fecho": self.horario_fecho.isoformat(),
                "localizacao": self.localizacao,
                "imagem": self.imagem,
                "morada": self.morada
                }


# Reservas
class Reservas(db.Model):
    __tablename__ = 'reservas'

    id = db.Column(db.Integer, primary_key=True)
    matricula = db.Column(db.String(20), unique=True)
    tipo = db.Column(db.String(20))
    data_inicio = db.Column(db.DateTime)
    hora_inicio = db.Column(db.Time())
    hora_fim = db.Column(db.Time())
    utilizadores_id = db.Column(db.Integer, db.ForeignKey('utilizadores.id'), nullable=False)
    locais_id = db.Column(db.Integer, db.ForeignKey('locais.id'), nullable=False)

    ##id = db.Column(db.Integer, primary_key=True)
    ##utilizadores_id = db.Column(db.Integer, db.ForeignKey('utilizadores.id'), nullable=False)
    ##locais_id= db.Column(db.Integer,db.ForeignKey('locais.id'),nullable=False)
    # utilizador = db.relationship('Utilizador', backref='reserva', lazy=True)
    # local = db.relationship('Local', backref='local', lazy=True)
    ##data_inicio = db.Column(db.DateTime)  # qual é o formato da data ?
    # data_fim = db.Column(db.DATETIME)
    ##hora_inicio=db.Column(db.Time())
    ##hora_fim = db.Column(db.Time())
    ##matricula= db.Column(db.String(20), unique=True)
    ##tipo = db.Column(db.String(20))

    def to_json(self):
        return {"id": self.id,
                "utilizadores_id": self.utilizadores_id,
                "locais_id": self.locais_id,
                "data_inicio": self.data_inicio.isoformat(),
                # "data_fim":self.data_fim,
                "hora_inicio": self.hora_inicio.isoformat(),
                "hora_fim": self.hora_fim.isoformat(),
                "matricula": self.matricula,
                "tipo": self.tipo
                }


# Utilizador
class Utilizadores(db.Model):
    __tablename__ = 'utilizadores'

    id = db.Column(db.Integer, primary_key=True)
    # children = db.relationship("Reservas", back_populates="reserva", lazy='dynamic') #teste
    # reserva_id = db.Column(db.Integer, db.ForeignKey('reserva.id'), nullable=False)
    # reserva = db.relationship('reservas', backref='utilizador', lazy=True)
    nome = db.Column(db.String(200), nullable=False)
    email = db.Column(db.String(50), unique=True, nullable=False)
    password_hash = db.Column(db.String(128))
    numero_telemovel = db.Column(db.String(16), unique=True)
    numero_utente = db.Column(db.Integer, unique=True, nullable=False)
    admin = db.Column(db.Integer)
    token = db.Column(db.String(200))

    # reservas=  db.relationship('reservas')
    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def to_json(self):
        return {
            "id": self.id,
            "nome": self.nome,
            # "reserva_id": self.reserva_id,
            "email": self.email,
            "password_hash": self.password_hash,
            "numero_telemovel": self.numero_telemovel,
            "numero_utente": self.numero_utente,
            "admin": self.admin
        }


class Veiculos(db.Model):
    __tablename__ = 'veiculos'

    id = db.Column(db.Integer, primary_key=True)
    utilizadores_id = db.Column(db.Integer, db.ForeignKey('utilizadores.id'), nullable=False)
    funcionario = db.Column(db.Integer)
    matricula = db.Column(db.String(20))

    def to_json(self):
        return {
            "id": self.id,
            "utilizadores_id": self.utilizadores_id,
            "funcionario": self.funcionario,
            "matricula": self.matricula
        }


# db.drop_all()
db.create_all()


# Selecionar Todos os Utilizadores
@app.route("/utilizadores", methods=["GET"])
def seleciona_utilizadores():
    utilizadores_objetos = Utilizadores.query.all()
    utilizadores_json = [utilizadores.to_json() for utilizadores in utilizadores_objetos]

    return gerar_response(200, "utilizadores", utilizadores_json)


def token_required(f):
    utilizador_objeto = Utilizadores.query.filter_by(id=id).first()
    utilizador_json = utilizador_objeto.to_json()

    @wraps(f)
    def decorated(*args, **kwargs):
        token = None
        # jwt is passed in the request header
        if 'x-access-token' in request.headers:
            token = request.headers['x-access-token']
        # return 401 if token is not passed
        if not token:
            return jsonify({'message': 'Token is missing !!'}), 401

        try:
            # decoding the payload to fetch the stored details
            data = jwt.decode(token, app.config['SECRET_KEY'])
            current_user = utilizador_objeto
        except:
            return jsonify({
                'message': 'Token is invalid !!'
            }), 401
        # returns the current logged in users contex to the routes
        return f(current_user, *args, **kwargs)

    return decorated


# route for loging user in
@app.route('/login', methods=['POST'])
def login():
    # creates dictionary of form data
    # auth = request.form
    auth = request.get_json()
    data = request.get_json()

    if not auth or not auth.get('email') or not auth.get('password'):
        # returns 401 if any email or / and password is missing

        return make_response(
            'Could not verify fff',
            401,
            {'WWW-Authenticate': 'Basic realm ="Login required !!"'}
        )

    user = Utilizadores.query \
        .filter_by(email=auth.get('email')) \
        .first()

    if not user:
        # returns 401 if user does not exist
        return make_response(
            'Could not verify ',
            401,
            {'WWW-Authenticate': 'Basic realm ="User does not exist !!"'}
        )
    # n estou a perceber esta condição
    if check_password_hash(user.password_hash, auth.get('password')):
        # generates the JWT Token
        token = jwt.encode({
            'id': user.id,
            'exp': datetime.utcnow() + timedelta(minutes=30)
        }, app.config['SECRET_KEY'])

        return make_response((jsonify({'token': token}), 201))
    # returns 403 if password is wrong

    return make_response(
        'Could not verify ',
        403,
        {'WWW-Authenticate': 'Basic realm ="Wrong Password !!"'}

    )


# alterar isto para usar token
@app.route("/login_semtoken", methods=["POST"])
def utilizadores_login():
    data = request.get_json()
    utilizador_objeto = Utilizadores.query.filter_by(email=data['email']).first()
    if utilizador_objeto:
        utilizador_json = utilizador_objeto.to_json()
        # if verify_password(data['password'], utilizador_json['password_hash']):
        if utilizador_json['password_hash'] == data['password']:
            return gerar_response(200, "login", utilizador_json)
        return gerar_response(400, "login", {}, "Wrong Credentials")
    else:
        return gerar_response(400, "login", {}, "User Not Found")


# Selecionar Utilizador
@app.route("/utilizador/<id>", methods=["GET"])
def seleciona_utilizador(id):
    utilizador_objeto = Utilizadores.query.filter_by(id=id).first()
    utilizador_json = utilizador_objeto.to_json()

    return gerar_response(200, "utilizadores", utilizador_json)


# signup route
@app.route('/signup', methods=['POST'])
def signup():
    # creates a dictionary of the form data
    # data = request.form
    body = request.get_json()

    # gets name, email and password
    print(body)
    nome, email = body.get('nome'), body.get('email')
    password = body.get('password_hash')
    numero_telemovel = body.get('numero_telemovel')
    numero_utente = body.get('numero_utente')

    # checking for existing user
    user = Utilizadores.query.filter_by(email=email).first()

    print(user)
    if not user:
        # database ORM object
        user = Utilizadores(
            nome=body["nome"],
            email=body["email"],
            password_hash=generate_password_hash(body["password_hash"], method='sha256'),
            numero_utente=body["numero_utente"],
            numero_telemovel=body["numero_telemovel"],

        )
        # insert user
        db.session.add(user)
        db.session.commit()

        return make_response('Successfully registered.', 201)
    else:
        # returns 202 if user already exists
        return make_response('User already exists. Please Log in.', 202)


# Registo
@app.route("/utilizador", methods=["POST"])
def cria_utilizador():
    body = request.get_json()

    try:
        utilizador = Utilizadores(nome=body["nome"],
                                  email=body["email"],
                                  password_hash=body["password"],
                                  numero_telemovel=body["numero de telemovel"],
                                  numero_utente=body["numero de utente"])

        db.session.add(utilizador)
        db.session.commit()
        return gerar_response(201, "utilizadores", utilizador.to_json(), "Criado com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "utilizadores", {}, "Erro ao registar")


# Atualizar utilizador
@app.route("/utilizador/<id>", methods=["PUT"])
def atualiza_utilizador(id):
    utilizador_objeto = Utilizadores.query.filter_by(id=id).first()
    body = request.get_json()

    try:
        if ('nome' in body):
            utilizador_objeto.nome = body['nome']
        if ('email' in body):
            utilizador_objeto.email = body['email']
        if ('password' in body):
            utilizador_objeto.password = body['password']
        if ('numero_telemovel' in body):
            utilizador_objeto.numero_telemovel = body['numero_telemovel']
        if ('numero_utente' in body):
            utilizador_objeto.numero_utente = body['numero_utente']

        db.session.add(utilizador_objeto)
        db.session.commit()
        return gerar_response(201, "utilizadores", utilizador_objeto.to_json(), "Atualizado com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "utilizadores", {}, "Erro ao atualizar")


# Remover
@app.route("/utilizador/<id>", methods=["DELETE"])
def remover_utilizador(id):
    utilizador_objeto = Utilizadores.query.filter_by(id=id).first()

    try:
        db.session.delete(utilizador_objeto)
        db.session.commit()
        return gerar_response(201, "utilizadores", utilizador_objeto.to_json(), "Removido com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "utilizadores", {}, "Erro ao remover")


# Selecionar todas as reservas
@app.route("/reservas", methods=["GET"])
def seleciona_reservas():
    reservas_objetos = Reservas.query.all()
    reservas_json = [reservas.to_json() for reservas in reservas_objetos]

    return gerar_response(200, "reservas", reservas_json)


# selecionar reservas por id
@app.route("/reserva/<id>", methods=["GET"])
def seleciona_reserva(id):
    reservas_objetos = Reservas.query.filter_by(id=id).first()
    reservas_json = reservas_objetos.to_json()

    return gerar_response(200, "reservas", reservas_json)


# selecionar reservas por id ordem descendente
@app.route("/reservadesc/<utilizadores_id>", methods=["GET"])
def seleciona_reservaporid(utilizadores_id):
    reservas_objetos = Reservas.query.filter_by(utilizadores_id=utilizadores_id).order_by(desc(Reservas.id)).first()

    reservas_json = reservas_objetos.to_json()

    return gerar_response(200, "reservas", reservas_json)

# adicionar uma reserva
@app.route("/reserva", methods=["POST"])
def cria_reserva():
    body = request.get_json()
    try:
        reservas = Reservas(matricula=body["matricula"],
                            tipo=body["tipo"],
                            data_inicio=body["data_inicio"],
                            hora_inicio=body["hora_inicio"],
                            utilizadores_id=body["utilizadores_id"],
                            locais_id=body["locais_id"],
                            hora_fim=body["hora_fim"])

        confirmareserva = confirma_reservas(body)
        if (type(confirmareserva) == type('string')):
            return gerar_response(200, "reservas", {}, confirmareserva)

        if (confirmareserva):
            return gerar_response(401, "reservas", {}, "Não é possivel marcar reserva para essa hora")

        db.session.add(reservas)  # o erro está a ser aqui
        db.session.commit()
        return gerar_response(201, "reservas", reservas.to_json(), "Reserva criada com sucesso")
    except Exception as e:
        print('erro', e)
        return gerar_response(400, "reservas", {}, "Erro ao registar reserva")


# atualizar reserva
@app.route("/reserva/<id>", methods=["PUT"])
def atualiza_reserva(id):
    reservas_objeto = Reservas.query.filter_by(id=id).first()
    body = request.get_json()

    try:
        if ('data_inicio' in body):
            reservas_objeto.data_inicio = body('data_inicio')
        # if ('data_fim' in body):
        # reservas_objeto.data_fim = body('data_fim')
        if ('utilizadores_id' in body):
            reservas_objeto.utilizador_id = body('utilizadores_id')
        if ('locais_id' in body):
            reservas_objeto.local_id = body('locais_id')

        db.session.add(reservas_objeto)
        db.session.commit()
        return gerar_response(200, "reservas", reservas_objeto.to_json(), "Reserva atualizado com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "reservas", {}, "Erro ao atualizar reserva")


# Eliminar reserva
@app.route("/reserva/<id>", methods=["DELETE"])
def eliminar_reserva(id):
    reservas_objeto = Reservas.query.filter_by(id=id).first()

    try:
        db.session.delete(reservas_objeto)
        db.session.commit()
        return gerar_response(200, "reservas", reservas_objeto.to_json(), "Reserva eliminada com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "reservas", {}, "Erro ao eliminar reserva")


# Selecionar Locais
@app.route("/locais", methods=["GET"])
def seleciona_locais():
    locais_objetos = Locais.query.all()
    locais_json = [locais.to_json() for locais in locais_objetos]

    return gerar_response(200, "locais", locais_json)


# Selecional local por id
@app.route("/local/<id>", methods=["GET"])
def seleciona_local(id):
    locais_objeto = Locais.query.filter_by(id=id).first()
    locais_json = locais_objeto.to_json()

    return gerar_response(200, "locais", locais_json)


# Criar local
@app.route("/local", methods=["POST"])
def cria_local():
    body = request.get_json()

    try:
        locais = Locais(nome=body["nome"],
                        lugares=body["lugares"],
                        descricao=body["descricao"],
                        localizacao=body["localizacao"],
                        horario_abertura=body["horario_abertura"],
                        horario_fecho=body["horario_fecho"],
                        imagem=body["imagem"],
                        morada=body["morada"])
        db.session.add(locais)
        db.session.commit()
        return gerar_response(201, "locais", locais.to_json(), "Local criada com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "locais", {}, "Erro ao criar local")


# Atualizar local
@app.route("/local/<id>", methods=["PUT"])
def atualiza_local(id):
    locais_objeto = Locais.query.filter_by(id=id).first()
    body = request.get_json()

    try:
        if ('nome' in body):
            locais_objeto.nome = body('nome')
        if ('lugares' in body):
            locais_objeto.lugares = body('lugares')
        if ('descricao' in body):
            locais_objeto.descricao = body('descricao')
        if ('localizacao' in body):
            locais_objeto.localizacao = body('localizacao')
        if ('local_id' in body):
            locais_objeto.lugares = body('lugares')
        if ('horario_abertura' in body):
            locais_objeto.horario_abertura = body('horario_abertura')
        if ('horario_fecho' in body):
            locais_objeto.horario_fecho = body('horario_fecho')
        if ('imagem' in body):
            locais_objeto.imagem = body('imagem')
        if ('morada' in body):
            locais_objeto.morada = body('morada')

        db.session.add(locais_objeto)
        db.session.commit()
        return gerar_response(200, "locais", locais_objeto.to_json(), "Local atualizado com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "locais", {}, "Erro ao atualizar local")


# Eliminar local
@app.route("/local/<id>", methods=["DELETE"])
def eliminar_local(id):
    locais_objeto = Locais.query.filter_by(id=id).first()

    try:
        db.session.delete(locais_objeto)
        db.session.commit()
        return gerar_response(200, "locais", locais_objeto.to_json(), "Local eliminada com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "locais", {}, "Erro ao eliminar local")


# Selecionar Veiculos
@app.route("/veiculos", methods=["GET"])
def seleciona_veiculos():
    veiculos_objetos = Veiculos.query.all()
    veiculos_json = [veiculos.to_json() for veiculos in veiculos_objetos]

    return gerar_response(200, "veiculos", veiculos_json)


# Selecional veiculos por id
@app.route("/veiculo/<id>", methods=["GET"])
def seleciona_veiculo(id):
    veiculos_objeto = Veiculos.query.filter_by(id=id).first()
    veiculos_json = veiculos_objeto.to_json()

    return gerar_response(200, "veiculos", veiculos_json)


# Criar veiculos
@app.route("/veiculo", methods=["POST"])
def cria_veiculo():
    body = request.get_json()

    try:
        veiculos = Veiculos(matricula=body["matricula"],
                            utilizadores_id=body["utilizadores_id"],
                            funcionario=body["funcionario"])
        db.session.add(veiculos)
        db.session.commit()
        return gerar_response(201, "veiculos", veiculos.to_json(), "Veiculo criada com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "veiculos", {}, "Erro ao criar veiculo")


@app.route("/veiculo/<id>", methods=["PUT"])
def atualiza_veiculos(id):
    veiculos_objeto = Veiculos.query.filter_by(id=id).first()
    body = request.get_json()

    try:
        if ('funcionario' in body):
            veiculos_objeto.funcionario = body('funcionario')
        if ('matricula' in body):
            veiculos_objeto.matricula = body('matricula')
        if ('utilizadores_id' in body):
            veiculos_objeto.utilizadores_id = body('utilizadores_id')

        db.session.add(veiculos_objeto)
        db.session.commit()
        return gerar_response(200, "veiculos", veiculos_objeto.to_json(), "Veiculo atualizado com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "veiculos", {}, "Erro ao atualizar veiculo")


@app.route("/veiculo/<id>", methods=["DELETE"])
def eliminar_veiculos(id):
    veiculos_objeto = Veiculos.query.filter_by(id=id).first()

    try:
        db.session.delete(veiculos_objeto)
        db.session.commit()
        return gerar_response(200, "veiculos", veiculos_objeto.to_json(), "Veiculo eliminada com sucesso")
    except Exception as e:
        print('Erro', e)
        return gerar_response(400, "veiculos", {}, "Erro ao eliminar veiculo")


def gerar_response(status, nome_do_conteudo, conteudo, mensagem=False):
    body = {}
    body[nome_do_conteudo] = conteudo

    if (mensagem):
        body["mensagem"] = mensagem

    return Response(json.dumps(body), status=status, mimetype="application/json")


def confirma_reservas(body):
    dataaux = body.get("data_inicio")
    horaaux = body.get("hora_inicio")
    reservas_objetos_data = Reservas.query.filter_by(data_inicio=dataaux, hora_inicio=horaaux).all()
    idaux = body.get("locais_id")

    locais_objetos_hora = Locais.query.filter_by(id=idaux).first()
    # hora_abertura=locais_objetos_hora.horario_abertura
    # hora_fecho = locais_objetos_hora.horario_fecho

    hora_inicio_reserva = datetime.strptime(horaaux, '%H:%M:%S').time()  # converter para time

    horatostring = str(locais_objetos_hora.horario_abertura).split(" ")[1]
    hora_abertura = datetime.strptime(horatostring, '%H:%M:%S').time()

    horatostring2 = str(locais_objetos_hora.horario_fecho).split(" ")[1]
    hora_fecho = datetime.strptime(horatostring2, '%H:%M:%S').time()

    print(hora_abertura)
    print(hora_fecho)

    # falta ver se o local está aberto

    if (len(reservas_objetos_data) >= 4 or hora_inicio_reserva < hora_abertura or hora_inicio_reserva >= hora_fecho):
        proxhora = hora_inicio_reserva
        # hora = datetime.strptime("01:00:00", '%H:%M:%S').time()
        hora = 1
        print(type(hora))
        ## print(proxhora.hour)
        while (proxhora != hora_fecho):
            # proxhora = hora_inicio_reserva.hour + hora.hour
            proxhora = timedelta(hours=proxhora.hour + hora)
            query_proxhora = Reservas.query.filter_by(data_inicio=dataaux, hora_inicio=proxhora).all()
            if (len(query_proxhora) < 4):
                return "Essa hora esta cheia podes marcar na hora " + str(proxhora)
            hora = hora + 1
        return 1

    return 0


#if __name__ == "__main__":
 #   app.run(host="0.0.0.0", port=5000)
