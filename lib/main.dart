import 'package:flutter/material.dart';
import 'package:projeto_1/models/lista_membros.dart';
import 'package:projeto_1/pages/membro_detalhe_pg.dart';
import 'package:projeto_1/pages/membro_view_pg.dart';
import 'package:projeto_1/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListaMembros(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.white70,
            secondary: Colors.black87,
            onPrimary: Colors.black87,
          ),
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.inicio: (ctx) => const MembroViewPg(),
          AppRoutes.membroDetalhe: (ctx) => const MembroDetalhePg(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
