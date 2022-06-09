import 'package:flutter/material.dart';
import 'package:LPIproject/Screens/reservation/stateManagerReservation.dart';
import 'package:provider/provider.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();

}

class _DropDownState extends State<DropDown> {
  TextEditingController _name = TextEditingController();
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    final schedule= Provider.of<MySchedule>(context, listen:false);
    return Scaffold(
        backgroundColor: Colors.white,
        
        body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: DropdownButton(
              value: _value,
              items: [
                DropdownMenuItem(
                  child: Text("Vacinação"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Teste Covid"),
                  value: 2,
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _value = value;
                  schedule.val=value;
                });
              }),
        ));
  }
}
