import 'dart:io';

import 'package:LPIproject/Screens/Help/suportPage.dart';
import 'package:LPIproject/Screens/login/login.dart';
import 'package:LPIproject/Screens/profile/profile_notes.dart';
import 'package:LPIproject/Screens/profile/profile_reservation.dart';
import 'package:LPIproject/app.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<ProfileModel> fetchProfile() async {
  String token;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.get("token");
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  print(decodedToken.entries.first.value); // retiro o id
  int utilizadores_idaux = decodedToken.entries.first.value;

  final response = await http
      .get(Uri.parse('http://127.0.0.1:5000/utilizador/$utilizadores_idaux'));

  if (response.statusCode == 200) {
    return ProfileModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Erro ao carregar Utilizador');
  }
}

Future<ProfileReservation> fetchprofileReservation() async {
  String token;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.get("token");
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  print(decodedToken.entries.first.value); // retiro o id
  int utilizadores_idaux = decodedToken.entries.first.value;

  final response = await http
      .get(Uri.parse('http://127.0.0.1:5000/reservadesc/$utilizadores_idaux'));

  if (response.statusCode == 200) {
    return ProfileReservation.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Nenhuma Reserva Efetuada');
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ProfilePage> {
  Future<ProfileModel> futureAlbum;
  Future<ProfileReservation> futureProfileReservation;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchProfile();
    futureProfileReservation = fetchprofileReservation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "Utilizador",
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 40, right: 40),
        color: Colors.white,
        child: ListView(children: <Widget>[
          SizedBox(
            width: 175,
            height: 175,
            child: Image.asset("assets/images/perfil.png"),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: FutureBuilder<ProfileModel>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Nome do Utilizador : ' + snapshot.data.nome,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
          ),
          Container(
            child: FutureBuilder<ProfileModel>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Email : ' + snapshot.data.email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
          ),
          Container(
            child: FutureBuilder<ProfileModel>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Numero de Telemovel : ' +
                            snapshot.data.numero_telemovel,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
          ),
          Container(
            child: FutureBuilder<ProfileModel>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Numero de Utente : ' +
                            snapshot.data.numero_utente.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
          ),
          Container(
            child: FutureBuilder<ProfileReservation>(
                future: futureProfileReservation,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Matricula: ' + snapshot.data.matricula,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("");
                  }
                  return CircularProgressIndicator();
                }),
          ),
          Container(
            child: FutureBuilder<ProfileReservation>(
                future: futureProfileReservation,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Data da proxima reserva : ' +
                            snapshot.data.data_inicio.substring(0, 10),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("");
                  }
                  return CircularProgressIndicator();
                }),
          ),
          Container(
            child: FutureBuilder<ProfileReservation>(
                future: futureProfileReservation,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Hora da reserva: ' +
                            snapshot.data.hora_inicio.substring(0, 5),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("");
                  }
                  return CircularProgressIndicator();
                }),
          ),
          Container(
            child: RaisedButton(
              color: Colors.green,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuportPage(),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.blue, width: 2)),
              textColor: Colors.white,
              child: Text("AJUDA/SUPORTE"),
            ),
          ),
          Container(
            child: FlatButton(
              color: Colors.red,
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.clear();
                sharedPreferences.commit();
                  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPageBonito(),
              ),
            );
                
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.blue, width: 2)),
              textColor: Colors.white,
              child: Text('SAIR'),
            ),
          )
        ]),
      ),
    );
  }
}
