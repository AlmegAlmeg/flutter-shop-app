import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cartScreen.dart';

import '../providers/cart.dart';

import '../widgets/appDrawer.dart';
import '../widgets/productsGrid.dart';
import '../widgets/badge.dart';

enum FilterOption { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopMe'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(
                () {
                  if (selectedValue == FilterOption.favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                },
              );
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                  child: Text('Only favorites'), value: FilterOption.favorites),
              const PopupMenuItem(
                  child: Text('Show all'), value: FilterOption.all),
            ],
          ),
          Consumer<Cart>(
            builder: (_, data, ch) => Badge(
              child: ch as Widget,
              value: data.itemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
