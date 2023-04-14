import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiara/models/auth.dart';
import 'package:tiara/paginas/orders_page.dart';
import 'package:tiara/utilitarios/app_rotas.dart';
import 'package:tiara/utilitarios/custom_route.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem vindo Usuário!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('T-ARA'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRotas.loginOuHome,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRotas.orders,
              );
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(builder: (ctx) => const OrdersPage()),
              // );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRotas.products,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Provider.of<Auth>(
                context,
                listen: false,
              ).logout();
              Navigator.of(context).pushReplacementNamed(
                AppRotas.loginOuHome,
              );
            },
          ),
        ],
      ),
    );
  }
}
