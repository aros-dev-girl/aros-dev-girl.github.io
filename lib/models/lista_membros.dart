import 'package:flutter/material.dart';
import 'package:projeto_1/data/mock_membros.dart';
import 'package:projeto_1/models/membro.dart';

class ListaMembros with ChangeNotifier {
  final List<Membro> _items = MockMembros;

  List<Membro> get items => [..._items];

  void addMembro(Membro membro) {
    _items.add(membro);
    notifyListeners();
  }
}
