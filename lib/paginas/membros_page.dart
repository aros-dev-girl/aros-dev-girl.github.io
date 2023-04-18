import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiara/componentes/menu_lateral.dart';
import 'package:tiara/componentes/membro_item.dart';
import 'package:tiara/modelos/membro_lista.dart';
import 'package:tiara/utilitarios/app_rotas.dart';

class MembrosPage extends StatelessWidget {
  const MembrosPage({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<MembroLista>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final MembroLista membros = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Membros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRotas.membroForm);
            },
          )
        ],
      ),
      drawer: const MenuLateral(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: membros.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                MembroItem(membros.items[i]),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
