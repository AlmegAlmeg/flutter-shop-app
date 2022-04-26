import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/auth_screen.dart';
import './screens/editProductScreen.dart';
import './screens/cartScreen.dart';
import './screens/productsOverviewScreen.dart';
import './screens/productDetailScreen.dart';
import './screens/ordersScreen.dart';
import './screens/userProductScreen.dart';

import './providers/auth.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './providers/orders.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
        ChangeNotifierProvider(create: (ctx) => Auth())
      ],
      child: MaterialApp(
        title: 'ShopMe',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: const AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
