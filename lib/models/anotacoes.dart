import 'package:flutter/material.dart';

class Anotacoes {
  Anotacoes(
      {required this.titulo_da_anotacao,
      required this.DataHorario,
      required this.texto_da_anotacao});

  String titulo_da_anotacao;
  DateTime DataHorario;
  String texto_da_anotacao;
}
