import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProfileReservation {
  final int id;
  final int utilizadores_id;
  final String data_inicio;
  final String hora_inicio;
  final String matricula;

  ProfileReservation(
      {this.id, this.utilizadores_id, this.data_inicio, this.hora_inicio, this.matricula});

  factory ProfileReservation.fromJson(Map<String, dynamic> json) {
    return ProfileReservation(
      id: json["reservas"]['id'],
      utilizadores_id: json["reservas"]['utilizadores_id'],
      data_inicio: json["reservas"]['data_inicio'],
      hora_inicio: json["reservas"]['hora_inicio'],
      matricula: json["reservas"]['matricula'],
    );
  }
}
