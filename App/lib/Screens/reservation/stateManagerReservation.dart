import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySchedule with ChangeNotifier{
  DateTime _stateManagerTime=DateTime.now();  // para a data mudar nome
  TimeOfDay _stateManagerTimeOfDay= TimeOfDay(hour: 7, minute: 15);  // para as horas
  int _val=1;

  DateTime get stateManagerTime => _stateManagerTime;
  TimeOfDay get stateManagerTimeOfDay => _stateManagerTimeOfDay;
  int get val => _val;

  set stateManagerTime(DateTime newValue){
    _stateManagerTime = newValue;
    print(_stateManagerTime);
    notifyListeners();
  }


  set stateManagerTimeOfDay(TimeOfDay newValue){
    _stateManagerTimeOfDay = newValue;
    print(_stateManagerTimeOfDay);
    notifyListeners();
  }

  set val(int newValue){
    _val = newValue;
    print(_val);
    notifyListeners();
  }

}
