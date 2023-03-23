import 'package:flutter/material.dart';

class Membro with ChangeNotifier {
  final String id;
  final String nomeArtistico;
  final String nomeReal;
  final String dataNascimento;
  final String signo;
  final String altura;
  final String posicao;
  final String tipoSanguineo;
  final String grupoOriginal;
  final String imgPerfil;
  final String imgStage;
  final String imgLightstick;
  final Color cor;

  Membro({
    required this.id,
    required this.nomeArtistico,
    required this.nomeReal,
    required this.dataNascimento,
    required this.signo,
    required this.altura,
    required this.posicao,
    required this.tipoSanguineo,
    required this.grupoOriginal,
    required this.imgPerfil,
    required this.imgStage,
    required this.imgLightstick,
    required this.cor,
  });
}
