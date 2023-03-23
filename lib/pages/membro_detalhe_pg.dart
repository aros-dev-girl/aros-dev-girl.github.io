import 'package:flutter/material.dart';
import 'package:projeto_1/models/membro.dart';

class MembroDetalhePg extends StatelessWidget {
  const MembroDetalhePg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Membro membro = ModalRoute.of(context)!.settings.arguments as Membro;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          membro.nomeArtistico,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                membro.posicao,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Image.asset(
                membro.imgStage,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              membro.grupoOriginal,
              style: const TextStyle(color: Colors.black87),
            ),
            Text(
              membro.nomeReal,
              style: const TextStyle(color: Colors.black87),
            ),
            Text(
              membro.dataNascimento,
              style: const TextStyle(color: Colors.black87),
            ),
            Text(
              membro.signo,
              style: const TextStyle(color: Colors.black87),
            ),
            Text(
              membro.altura,
              style: const TextStyle(color: Colors.black87),
            ),
            Text(
              membro.tipoSanguineo,
              style: const TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                membro.imgLightstick,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
