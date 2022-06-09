import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:LPIproject/Screens/Search/note.dart';
import 'package:http/http.dart' as http;

import '../../app.dart';

class SearchPageTest extends StatefulWidget {
  @override
  _SearchPageTestState createState() => _SearchPageTestState();
}

class _SearchPageTestState extends State<SearchPageTest> {
  List<Note> _notes = List<Note>();
  List<Note> _notesForDisplay = List<Note>();

  Future<List<Note>> fetchNotes() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/locais'));

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> notes = map["locais"];
    List<Note> notes_aux = [];

    if (response.statusCode == 200) {
      for (var noteJson in notes) {
        notes_aux.add(Note.fromJson(noteJson));
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text('Pesquisa locais'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {   // Meter um onPressed para reencaminhar para outra pagina
            return index == 0 ? _searchBar() : _listItem(index - 1);
          },
          itemCount: _notesForDisplay.length + 1,
        ));
  }

  void _onLocationTap(BuildContext context, int locationID) {
    Navigator.pushNamed(context, LocationDetailRoute,
        arguments: {"id": locationID});
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Procurar...'),
        onChanged: (nome) {
          nome = nome.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((note) {
              var noteName = note.nome.toLowerCase();
              return noteName.contains(nome);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
    child: new InkWell(  
      onTap: ()=> _onLocationTap(context,_notesForDisplay[index].id ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _notesForDisplay[index].nome,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              
            ),
            Text(
              _notesForDisplay[index].nome,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    ));
  }
}
