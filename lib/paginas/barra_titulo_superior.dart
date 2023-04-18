import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiara/componentes/menu_lateral.dart';
import 'package:tiara/componentes/badge.dart';
import 'package:tiara/componentes/membro_grid.dart';
import 'package:tiara/modelos/cart.dart';
import 'package:tiara/modelos/membro_lista.dart';
import 'package:tiara/utilitarios/app_rotas.dart';

enum FilterOptions {
  favorite,
  all,
}

class BarraTituloSuperior extends StatefulWidget {
  const BarraTituloSuperior({Key? key}) : super(key: key);

  @override
  State<BarraTituloSuperior> createState() => _BarraTituloSuperiorState();
}

class _BarraTituloSuperiorState extends State<BarraTituloSuperior> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<MembroLista>(
      context,
      listen: false,
    ).loadProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T👑ARA'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          /*Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRotas.cart);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          ),*/
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : MembroGrid(_showFavoriteOnly),
      drawer: const MenuLateral(),
    );
  }
}
