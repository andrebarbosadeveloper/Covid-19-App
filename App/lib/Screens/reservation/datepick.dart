import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LPIproject/Screens/reservation/stateManagerReservation.dart';
import 'package:provider/provider.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}
class _DatePickerState extends State<DatePicker> {
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final schedule= Provider.of<MySchedule>(context, listen:false);  // está a dar erro aqi
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2022));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        schedule.stateManagerTime= currentDate;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      body:Container(
        color: Colors.white,
        alignment: Alignment.center,



        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(currentDate.toString().substring(0,11),),

            RaisedButton(
              color: Colors.blue,
              onPressed: () => _selectDate(context),
              child: Text('Escolha o dia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

            ),


          ],

        ),
      ),

    );
  }

}