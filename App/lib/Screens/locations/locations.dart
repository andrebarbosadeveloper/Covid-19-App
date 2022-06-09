import 'dart:convert';
import 'package:LPIproject/Screens/locations/locations_notes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../app.dart';

class LocationsPageTest extends StatefulWidget {
  @override
  _LocationsPageTest createState() => _LocationsPageTest();
}

class _LocationsPageTest extends State<LocationsPageTest> {
  List<LocationModel> _notes = List<LocationModel>();
  List<LocationModel> _notesForDisplay = List<LocationModel>();

  Future<List<LocationModel>> fetchNotes() async {
    
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/locais'));

    // ignore: deprecated_member_use

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> notes = map["locais"];
    List<LocationModel> notes_aux = [];

    if (response.statusCode == 200) {
      
      for (var noteJson in notes) {
        notes_aux.add(LocationModel.fromJson(noteJson));
      }
    }
    return notes_aux;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final locations=Location.fetchAll();
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text('HomePage'),
        ),
        body: 
        ListView.builder(
          itemBuilder: (context, index)=> _listItemTest(index),
          itemCount: _notesForDisplay.length,
        ));
  }

  void _onLocationTap(BuildContext context, int locationID) {
    Navigator.pushNamed(context, LocationDetailRoute, arguments:{"id": locationID} );
  }


  _listItemTest(index) {
    return Card(
      color: Colors.grey.shade200,
    child: new InkWell(  
      onTap: ()=> _onLocationTap(context, _notesForDisplay[index].id),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, bottom: 16.0),
        child: Container(
          
          //height: 245.0,
          //width: 245,

          child: Column(
            
          crossAxisAlignment: CrossAxisAlignment.start,
              
          children: <Widget>[

            //Image.asset('assets/images/Porto.jpeg', fit:BoxFit.cover,  ),
            Image.memory(base64Decode(_notesForDisplay[index].imagem), width: MediaQuery.of(context).size.width,),

             Text(
              _notesForDisplay[index].nome,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
             Text(
              _notesForDisplay[index].localizacao,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              _notesForDisplay[index].horario_abertura.substring(12,16) + "-" +_notesForDisplay[index].horario_fecho.substring(11,16),
              style: TextStyle(fontSize: 15, color: Colors.red),
            ),
           ],
          ),
          ),
        ),
      ),
    );
  }

}
