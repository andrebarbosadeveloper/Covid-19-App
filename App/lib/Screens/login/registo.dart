import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:LPIproject/Screens/login/login.dart';
import 'dart:convert' as convert;

class RegistoFormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<RegistoFormPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  TextEditingController _numeroUtente = TextEditingController();

  final GlobalKey<FormState> _formkey =
      GlobalKey<FormState>(); // nao percebi mt bem o que isto faz
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 175,
                  height: 175,
                  child: Image.asset("assets/images/vaccineicon.png"),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nome completo",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Insira um nome";
                      }
                      return null;
                    },
                    onSaved: (String name) {},
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Insira o email";
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return "Insira um email válido";
                      }
                      return null;
                    },
                    onSaved: (String email) {},
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Telefone",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Insira o número de telefone";
                      }
                      if (value.length < 9) {
                        return "Insira um número de telefone válido";
                      }
                      return null;
                    },
                    onSaved: (String phone) {},
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Insira a password";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: _confirmpassword,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Repita a password",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Insira a password";
                      }
                      if (_password.text != _confirmpassword.text) {
                        return "Password não coincide";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: _numeroUtente,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Numero de utente ",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Insira um numero de utente";
                      }
                      return null;
                    },
                    onSaved: (String name) {},
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.redAccent,
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        var state = await RegistrationUser();
                        if(state == 201){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPageBonito(),
                          ),
                        );}
                        else{
                          if(state == 202){
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Utilizador já se encontra registado")));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Dados do Registo inválidos")));
                          }
                        }
                        print("Successful");
                      } else {
                        print("Unsuccessfull");
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.blue, width: 2)),
                    textColor: Colors.white,
                    child: Text("Registar"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future RegistrationUser() async {
    // url to registration
    var url = Uri.parse('http://127.0.0.1:5000/signup');
    //var url = Uri.parse('http://10.0.2.2:5000/signup');
    //json maping user entered details

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nome': _name.text,
        'email': _email.text,
        'password_hash': _password.text,
        'numero_utente': _numeroUtente.text,
        'numero_telemovel': _phone.text,
      }),
    );
    return response.statusCode;
  }
}
