import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiara/modelos/login.dart';
import 'package:tiara/modelos/cart.dart';
import 'package:tiara/modelos/membro.dart';
import 'package:tiara/utilitarios/app_rotas.dart';

class MembroGridItem extends StatelessWidget {
  const MembroGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membro = Provider.of<Membro>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Login>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Membro>(
            builder: (ctx, membro, _) => IconButton(
              onPressed: () {
                membro.toggleFavorite(
                  auth.token ?? '',
                  auth.userId ?? '',
                );
              },
              icon: Icon(
                  membro.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            membro.nomeArtistico,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Produto adicionado com sucesso!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      cart.removeSingleItem(membro.id);
                    },
                  ),
                ),
              );
              cart.addItem(membro);
            },
          ),
        ),
        child: GestureDetector(
          child: Hero(
            tag: membro.id,
            child: FadeInImage(
              placeholder:
                  const AssetImage('assets/images/membro-placeholder.png'),
              image: NetworkImage(membro.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          // child: Image.network(
          //   membro.imageUrl,
          //   fit: BoxFit.cover,
          // ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRotas.membroDetail,
              arguments: membro,
            );
          },
        ),
      ),
    );
  }
}
