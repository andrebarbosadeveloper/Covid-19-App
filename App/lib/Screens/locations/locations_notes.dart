import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LocationModel {
  int id;
  String nome;
  int lugares;
  String descricao;
  String localizacao;
  String horario_abertura;
  String horario_fecho;
  String imagem;

  LocationModel(
      {this.id,
      this.nome,
      this.lugares,
      this.descricao,
      this.localizacao,
      this.horario_abertura,
      this.horario_fecho,
      this.imagem});

  LocationModel.fromJson(Map<String, dynamic> json) {
  
    id = json['id'];
    nome = json['nome'];
    lugares = json['lugares'];
    descricao = json['descricao'];
    localizacao = json['localizacao'];
    horario_abertura = json['horario_abertura'];
    horario_fecho = json['horario_fecho'];
    imagem = json['imagem'];
  }


}
