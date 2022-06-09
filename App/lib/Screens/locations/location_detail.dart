
import 'package:LPIproject/Screens/locations/local_detail_notes.dart';
import 'package:flutter/material.dart';
import 'package:LPIproject/Screens/reservation/reservation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class LocationsDetailPageTest extends StatelessWidget {
  final int locationID;
  LocationsDetailPageTest(this.locationID);
  String morada;

  Future<LocationDetailModel> fetchNotes() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:5000/local/$locationID'));

    print(locationID);
    if (response.statusCode == 200) {
      //var notesJson = json.decode(response.body);
      print(LocationDetailModel.fromJson(jsonDecode(response.body)).nome);
      morada = LocationDetailModel.fromJson(jsonDecode(response.body)).morada;
      return LocationDetailModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Erro ao carregar os Locais');
    }
  }

  @override
  Widget build(BuildContext context) {
    var aux = fetchNotes();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: FutureBuilder<LocationDetailModel>(
            future: aux,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.data.nome),
                );
                //return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          color: Colors.white,
          child: ListView(
              children: <Widget>[
            SizedBox(
              //width: 175,
              //height: 175,

              child: FutureBuilder<LocationDetailModel>(
                  future: aux,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Image.memory(base64Decode(snapshot.data.imagem),width: MediaQuery.of(context).size.width,));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }),

              // Image.asset("assets/images/Lisboa.jpg"),
            ),
            Container(
              child: FutureBuilder<LocationDetailModel>(
                  future: aux,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data.nome,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
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
              child: FutureBuilder<LocationDetailModel>(
                  future: aux,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data.descricao,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
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
              child: FutureBuilder<LocationDetailModel>(
                  future: aux,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Localizacao: " + snapshot.data.localizacao,
                          style: TextStyle(
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
              child: FutureBuilder<LocationDetailModel>(
                  future: aux,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Hora Abertura: " +
                              snapshot.data.horario_abertura.substring(12, 16),
                          style: TextStyle(
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
              child: FutureBuilder<LocationDetailModel>(
                  future: aux,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Hora Fecho: " +
                              snapshot.data.horario_fecho.substring(11, 16),
                          style: TextStyle(
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
          ] 
                ..add(
                  RaisedButton(
                    color: Colors.green,
                    child: Text(
                      "Reserva",
                      textAlign: TextAlign.right,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Reservation(locationID),
                        ),
                      );
                    },
                  ), //vem do location.dart
                )
                ..add(
                  RaisedButton(
                    color: Colors.blueAccent,
                    onPressed: _launchURLApp,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue, width: 2)),
                    textColor: Colors.white,
                    child: Text("Localizacao"),
                  ),
                )),
        ));
  }

  Future _launchURLApp() async {
    var url = morada;
    await launch(url, forceSafariVC: true, forceWebView: true);
  }
}
