import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/appDrawer.dart';
import '../widgets/userProductItem.dart';

import '../providers/products.dart';

import '../screens/editProductScreen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (ctx, i) => UserProductItem(data.items[i].title,
              data.items[i].imageUrl, data.items[i].id.toString()),
          itemCount: data.items.length,
        ),
      ),
    );
  }
}
