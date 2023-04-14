import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiara/modelos/login.dart';
import 'package:tiara/paginas/login_page.dart';
import 'package:tiara/paginas/products_overview_page.dart';

class loginOuHomePage extends StatelessWidget {
  const loginOuHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Login auth = Provider.of(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return auth.isAuth ? const ProductsOverviewPage() : const LoginPage();
        }
      },
    );
  }
}
