import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_1/components/item_membro.dart';
import 'package:projeto_1/models/lista_membros.dart';
import 'package:projeto_1/models/membro.dart';

class GridMembro extends StatelessWidget {
  final bool showFavoriteOnly;

  const GridMembro(this.showFavoriteOnly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListaMembros>(context);
    final List<Membro> loadedProducts = provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: const ItemMembro(),
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
