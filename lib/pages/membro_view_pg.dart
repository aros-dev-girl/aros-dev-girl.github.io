import 'package:flutter/material.dart';
import 'package:projeto_1/components/grid_membro.dart';

enum FilterOptions {
  favorite,
  all,
}

class MembroViewPg extends StatefulWidget {
  const MembroViewPg({Key? key}) : super(key: key);

  @override
  State<MembroViewPg> createState() => _MembroViewPgState();
}

class _MembroViewPgState extends State<MembroViewPg> {
  final bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/t_logo.png', fit: BoxFit.cover, width: 170),
        
      ),
      body: GridMembro(_showFavoriteOnly),
    );
  }
}
