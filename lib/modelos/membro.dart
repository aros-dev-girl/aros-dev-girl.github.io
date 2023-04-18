import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tiara/utilitarios/Constantes.dart';

class Membro with ChangeNotifier {
  final String id;
  final String nomeArtistico;
  final String nomeVerdadeiro;
  final String posicao;
  final String dataNascimento;
  final String signo;
  final double altura;
  final String imageUrl;
  bool isFavorite;

  Membro({
    required this.id,
    required this.nomeArtistico,
    required this.nomeVerdadeiro,
    required this.posicao,
    required this.dataNascimento,
    required this.signo,
    required this.altura,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    try {
      _toggleFavorite();

      final response = await http.put(
        Uri.parse(
          '${Constantes.usuarioFavoritoUrl}/$userId/$id.json?auth=$token',
        ),
        body: jsonEncode(isFavorite),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (_) {
      _toggleFavorite();
    }
  }
}
