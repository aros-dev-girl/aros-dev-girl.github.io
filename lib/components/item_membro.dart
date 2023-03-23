import 'package:flutter/material.dart';
import 'package:projeto_1/models/membro.dart';
import 'package:projeto_1/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ItemMembro extends StatelessWidget {
  const ItemMembro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membro = Provider.of<Membro>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(5),
          child: const Icon(
            Icons.diamond,
            color: Colors.black87,
          ),
        ),
        footer: SizedBox(
          height: 30,
          child: GridTileBar(
            backgroundColor: membro.cor,
            title: Text(
              membro.nomeArtistico,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ),
        child: GestureDetector(
          child: Image.asset(
            membro.imgPerfil,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.membroDetalhe,
              arguments: membro,
            );
          },
        ),
      ),
    );
  }
}
