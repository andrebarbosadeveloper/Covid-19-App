import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:LPIproject/Screens/location_detail/navBar.dart';
import 'package:LPIproject/Screens/reservation/stateManagerReservation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ReservationButton extends StatelessWidget {
  final TextEditingController
      matricula; // para tentar passar a variavel do controlador
  final int location_id;

  ReservationButton(TextEditingController this.matricula, int this.location_id,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.green,
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: Text(
        "Reservar",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        final schedule = Provider.of<MySchedule>(context, listen: false);
        print(schedule.stateManagerTime);
        print(schedule.stateManagerTimeOfDay);
        print(matricula.text);
        print(schedule.val);
        print("local: $location_id");

        if (matricula.text == "" ||
            matricula.text.length >= 9 ||
            matricula.text.length < 8) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Intruduza os dados da matricula corretamente")));
        } else {
          var state = await Reservation(
              schedule.stateManagerTime,
              schedule.stateManagerTimeOfDay,
              matricula.text,
              schedule.val,
              location_id);
          print(state[1].toString().split('"')[5]);
          String mensagem = state[1].toString().split('"')[5];
          if (state[0] == 201) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Navbar(),
              ),
            );
          } else {
            if (state[0] == 200) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("$mensagem")));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Reserva inválida")));
            }
          }
        }
      },
    );
  }

  Future Reservation(DateTime data, TimeOfDay hora, String matricula, int val,
      int location_id) async {
    // url to registration
    var url = Uri.parse('http://127.0.0.1:5000/reserva');
    //json maping user entered details
    String tipo = "";
    if (val == 1) {
      tipo = "vacinação";
    } else {
      tipo = "teste";
    }
    TimeOfDay hora_fim = TimeOfDay(hour: hora.hour + 1, minute: hora.minute);

    String datastr,
        horastr,
        hora_fimstr,
        aux1,
        aux2,
        aux3,
        aux4,
        aux5,
        aux6; // passar para string para poder ser convertido para json
    datastr = data.toString();
    aux1 = hora.hour.toString();
    aux2 = ":";
    aux3 = hora.minute.toString();
    aux4 = "00";
    aux5 = hora_fim.hour.toString();
    aux6 = hora_fim.minute.toString();
    horastr = "$aux1$aux2$aux3$aux2$aux4";
    hora_fimstr =
        "$aux5$aux2$aux6$aux2$aux4"; // resolver o problema deste valor

    String token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get("token");
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print(decodedToken.entries.first.value); // retiro o id
    int utilizadores_idaux = decodedToken.entries.first.value;

    http.Response reponse = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'matricula': matricula,
          'tipo': tipo,
          "data_inicio": datastr,
          'hora_inicio': horastr,
          'hora_fim': hora_fimstr,
          "utilizadores_id": utilizadores_idaux,
          'locais_id': location_id
        },
      ),
    );
    return [reponse.statusCode, reponse.body];
  }
}
