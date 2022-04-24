import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../providers/products.dart';
// import '../providers/product.dart';
import './productItem.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Products>(context);
    final productsArr = showFavs ? data.favoriteItems : data.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: productsArr.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: productsArr[i],
        child: ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
