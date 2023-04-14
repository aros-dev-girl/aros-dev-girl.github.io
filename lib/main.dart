import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiara/modelos/login.dart';
import 'package:tiara/modelos/cart.dart';
import 'package:tiara/modelos/order_list.dart';
import 'package:tiara/modelos/product_list.dart';
import 'package:tiara/paginas/login_ou_home_page.dart';
import 'package:tiara/paginas/cart_page.dart';
import 'package:tiara/paginas/orders_page.dart';
import 'package:tiara/paginas/product_detail_page.dart';
import 'package:tiara/paginas/product_form_page.dart';
import 'package:tiara/paginas/products_page.dart';
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
        ChangeNotifierProxyProvider<Login, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
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
          AppRotas.productDetail: (ctx) => const ProductDetailPage(),
          AppRotas.cart: (ctx) => const CartPage(),
          AppRotas.orders: (ctx) => const OrdersPage(),
          AppRotas.products: (ctx) => const ProductsPage(),
          AppRotas.productForm: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
