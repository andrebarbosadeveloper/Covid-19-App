import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LPIproject/Screens/reservation/datepick.dart';
import 'package:LPIproject/Screens/reservation/dropdown.dart';
import 'package:LPIproject/Screens/reservation/reservationButton.dart';
import 'package:LPIproject/Screens/reservation/stateManagerReservation.dart';
import 'package:LPIproject/Screens/reservation/time.dart';
import 'package:provider/provider.dart';



class Reservation extends StatelessWidget{
  final int location_id;
  final TextEditingController _matriculaController = new TextEditingController();


  Reservation(this.location_id, {Key key}) : super(key: key);


  //String valueChoose;
  //List listItem=["Vacinação","Teste-Covid"];

  @override
  Widget build (BuildContext context){
    return ChangeNotifierProvider(
        create: (context) => MySchedule(),
      child:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Reserva",
          textAlign: TextAlign.center,
          ),
        ),
        body: Container(

          padding: EdgeInsets.only(top: 100, left: 40, right: 40),
          color: Colors.white,

          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 175,
                height: 175,
                child: Image.asset("assets/images/vaccineicon.png"),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 100,
                child:
                 DatePicker(),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 100,
                child:
                Time(),

              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 100,
                child:
                DropDown(),

              ),
              SizedBox(
                height: 40,
              ),
              Container(
              child: TextFormField(
                controller:_matriculaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Matricula(exemplo: AB-99-JN)",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Insira a matricula";
                  }
                  return null;
                },
                style: TextStyle(fontSize: 20),
              ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 50,
                child:
                  ReservationButton(_matriculaController,location_id),
               // Imprimir();
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Imprimir(){
    print(_matriculaController.text);
  }

}