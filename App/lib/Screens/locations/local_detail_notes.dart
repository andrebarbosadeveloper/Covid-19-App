import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LocationDetailModel {
  int id;
  String nome;
  int lugares;
  String descricao;
  String localizacao;
  String horario_abertura;
  String horario_fecho;
  String imagem;
  String morada;

  LocationDetailModel(
      {this.id,
      this.nome,
      this.lugares,
      this.descricao,
      this.localizacao,
      this.horario_abertura,
      this.horario_fecho,
      this.imagem,
      this.morada});

  factory LocationDetailModel.fromJson(Map<String, dynamic> json) {
    return LocationDetailModel(
      nome: json["locais"]['nome'],
      lugares: json["locais"]["lugares"],
      descricao: json["locais"]["descricao"],
      localizacao: json["locais"]["localizacao"],
      horario_abertura: json["locais"]["horario_abertura"],
      horario_fecho: json["locais"]["horario_fecho"],
      imagem: json["locais"]["imagem"],
      morada: json["locais"]["morada"],
    );
  }
}
