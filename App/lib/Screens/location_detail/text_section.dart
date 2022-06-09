import 'package:flutter/material.dart';

class TextSection extends StatelessWidget{
  final String _title;
  final String _body;
  static const double _hPad=16.0;

  TextSection(this._title,this._body);
 
  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          Container( // container para o titulo
            padding: const EdgeInsets.fromLTRB(_hPad, 32.0, _hPad, 4.0), // destanciamento para cima, baixo e para os lados
            // ignore: deprecated_member_use
            child: Text(_title, style:Theme.of(context).textTheme.title), // title defenido na app.dart
          ),
          Container( // container para o body 
          padding: const EdgeInsets.fromLTRB(_hPad, 10.0, _hPad, _hPad),
          // ignore: deprecated_member_use
          child: Text(_body, style: Theme.of(context).textTheme.body1), // body defenido na app.dart
          )
        ] 
        );
  }
}