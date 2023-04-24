import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tiara/exceptions/http_exception.dart';
import 'package:tiara/modelos/membro.dart';
import 'package:tiara/utilitarios/Constantes.dart';

class MembroLista with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Membro> _items = [];

  List<Membro> get items => [..._items];
  List<Membro> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  MembroLista([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constantes.membroBaseUrl}.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse(
        '${Constantes.usuarioFavoritoUrl}/$_userId.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((membroId, membroData) {
      final isFavorite = favData[membroId] ?? false;
      _items.add(
        Membro(
          id: membroId,
          nomeArtistico: membroData['nomeArtistico'],
          nomeVerdadeiro: membroData['nomeVerdadeiro'],
          posicao: membroData['posicao'],
          dataNascimento: membroData['dataNascimento'],
          signo: membroData['signo'],
          altura: membroData['altura'],
          imageUrl_1: membroData['imageUrl_1'],
          imageUrl_2: membroData['imageUrl_2'],
          isFavorite: isFavorite,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveMember(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final membro = Membro(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        nomeArtistico: data['nomeArtistico'] as String,
        nomeVerdadeiro: data['nomeVerdadeiro'] as String,
        posicao: data['posicao'] as String,
        dataNascimento: data['dataNascimento'] as String,
        signo: data['signo'] as String,
        altura: data['altura'] as double,
        imageUrl_1: data['imageUrl_1'] as String,
        imageUrl_2: data['imageUrl_2'] as String);

    if (hasId) {
      return updateProduct(membro);
    } else {
      return addProduct(membro);
    }
  }

  Future<void> addProduct(Membro membro) async {
    final response = await http.post(
      Uri.parse('${Constantes.membroBaseUrl}.json?auth=$_token'),
      body: jsonEncode(
        {
          "nomeArtistico": membro.nomeArtistico,
          "nomeVerdadeiro": membro.nomeVerdadeiro,
          "posicao": membro.posicao,
          "dataNascimento": membro.dataNascimento,
          "signo": membro.signo,
          "altura": membro.altura,
          "imageUrl_1": membro.imageUrl_1,
          "imageUrl_2": membro.imageUrl_2
        },
      ),
    );

    final id = jsonDecode(response.body)['nomeArtistico'];
    _items.add(Membro(
        id: id,
        nomeArtistico: membro.nomeArtistico,
        nomeVerdadeiro: membro.nomeVerdadeiro,
        posicao: membro.posicao,
        dataNascimento: membro.dataNascimento,
        signo: membro.signo,
        altura: membro.altura,
        imageUrl_1: membro.imageUrl_1,
        imageUrl_2: membro.imageUrl_2));
    notifyListeners();
  }

  Future<void> updateProduct(Membro membro) async {
    int index = _items.indexWhere((p) => p.id == membro.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constantes.membroBaseUrl}/${membro.id}.json?auth=$_token'),
        body: jsonEncode(
          {
            "nomeArtistico": membro.nomeArtistico,
            "nomeVerdadeiro": membro.nomeVerdadeiro,
            "posicao": membro.posicao,
            "dataNascimento": membro.dataNascimento,
            "signo": membro.signo,
            "altura": membro.altura,
            "imageUrl_1": membro.imageUrl_1,
            "imageUrl_2": membro.imageUrl_2
          },
        ),
      );

      _items[index] = membro;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Membro membro) async {
    int index = _items.indexWhere((p) => p.id == membro.id);

    if (index >= 0) {
      final membro = _items[index];
      _items.remove(membro);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constantes.membroBaseUrl}/${membro.id}.json?auth=$_token'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, membro);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
