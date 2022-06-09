import 'package:flutter/material.dart';

class SuportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Utilizador",
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
            children: <Widget>[
              SizedBox(
                width: 175,
                height: 175,
                child: Image.asset("assets/images/ajuda.png"),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Text("Contacto telefónico: 252 252 252",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Text("Email: suport@appcovid.pt",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
              ),

            ]
        ),


      ),
    );
  }
}