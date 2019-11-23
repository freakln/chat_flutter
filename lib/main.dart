import 'package:chat/screens/create_negociacao_screen.dart';
import 'package:chat/screens/edit_product_screen.dart';
import 'package:chat/screens/product_detail_screen.dart';
import 'package:chat/screens/shop_tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';
import 'package:chat/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat/screens/auth_screen.dart';
void main() {
  SharedPreferences.getInstance().then((prefs) {
    runApp(LandingPage(prefs: prefs));
  });
}


class LandingPage extends StatelessWidget {
  final SharedPreferences prefs;

  LandingPage({this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
      ],
      child: MaterialApp(
          title: 'Troca Aqui',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          // home: UserTabsScreen(),
          home: _decideMainPage(),
          routes: {
            CreateNegociacaoScreen.routeName: (ctx) => CreateNegociacaoScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            // UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            UserTabsScreen.routeName: (ctx) => UserTabsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          }),
    );
  }
  _decideMainPage() {
    if (prefs.getBool('is_verified') != null) {
      if (prefs.getBool('is_verified')) {
        return HomePage(prefs: prefs);
        // return RegistrationPage(prefs: prefs);
      } else {
        //testetetetetet
        return AuthScreen(prefs: prefs);
      }
    } else {
      return AuthScreen(prefs: prefs);
    }
  }
}

