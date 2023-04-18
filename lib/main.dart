import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiara/modelos/login.dart';
import 'package:tiara/modelos/cart.dart';
import 'package:tiara/modelos/order_list.dart';
import 'package:tiara/modelos/membro_lista.dart';
import 'package:tiara/paginas/login_ou_home_page.dart';
import 'package:tiara/paginas/cart_page.dart';
import 'package:tiara/paginas/orders_page.dart';
import 'package:tiara/paginas/membro_detalhe_page.dart';
import 'package:tiara/paginas/membro_form_page.dart';
import 'package:tiara/paginas/membros_page.dart';
import 'package:tiara/utilitarios/app_rotas.dart';
import 'package:tiara/utilitarios/custom_route.dart';

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
          create: (_) => Login(),
        ),
        ChangeNotifierProxyProvider<Login, MembroLista>(
          create: (_) => MembroLista(),
          update: (ctx, auth, previous) {
            return MembroLista(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Login, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'T-ARA',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(205, 0, 0, 1),
            secondary: const Color.fromRGBO(238, 201, 0, 1),
          ),
          fontFamily: 'Lato',
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CustomPageTransitionsBuilder(),
              TargetPlatform.android: CustomPageTransitionsBuilder(),
            },
          ),
        ),
        routes: {
          AppRotas.loginOuHome: (ctx) => const loginOuHomePage(),
          AppRotas.membroDetail: (ctx) => const MembroDetalhePage(),
          AppRotas.cart: (ctx) => const CartPage(),
          AppRotas.orders: (ctx) => const OrdersPage(),
          AppRotas.membros: (ctx) => const MembrosPage(),
          AppRotas.membroForm: (ctx) => const MembroFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
