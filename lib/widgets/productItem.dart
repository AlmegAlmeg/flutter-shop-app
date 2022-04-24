import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/productDetailScreen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    // final currentProduct = Provider.of<Product>(context);
    return Consumer<Product>(
      builder: (ctx, currentProduct, child) => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: currentProduct.id,
              );
            },
            child: Image.network(
              currentProduct.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(
                currentProduct.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline,
                size: 20,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                currentProduct.toggleFavoriteStatus();
              },
            ),
            title: Text(
              currentProduct.title,
              textAlign: TextAlign.center,
              // style: const TextStyle(fontSize: 15),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                size: 20,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(currentProduct.id, currentProduct.title,
                    currentProduct.price);
              },
            ),
          ),
        ),
      ),
    );
  }
}
