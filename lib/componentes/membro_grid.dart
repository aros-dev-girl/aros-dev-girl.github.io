import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiara/componentes/membro_grid_item.dart';
import 'package:tiara/modelos/membro.dart';
import 'package:tiara/modelos/membro_lista.dart';

class MembroGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const MembroGrid(this.showFavoriteOnly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MembroLista>(context);
    final List<Membro> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: const MembroGridItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
