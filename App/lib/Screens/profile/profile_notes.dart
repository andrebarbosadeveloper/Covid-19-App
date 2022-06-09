import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';


@JsonSerializable()
class ProfileModel {
  final int id;
  final String nome;
  final String email;
  final String numero_telemovel;
  final int numero_utente;

  ProfileModel(
      {this.id,
      this.nome,
      this.email,
      this.numero_telemovel,
      this.numero_utente});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {    
    return ProfileModel(
      //id: int.parse(json["utilizadores"]['id']),
      nome: json["utilizadores"]['nome'],
      email: json["utilizadores"]['email'],
      numero_telemovel: json["utilizadores"]['numero_telemovel'],
      numero_utente: json["utilizadores"]['numero_utente'],
    );
  }

  get getNome async {
    return this.nome;
  }
}
