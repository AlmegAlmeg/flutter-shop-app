import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
// import '../providers/products.dart';
import '../providers/product.dart';
import '../screens/productDetailScreen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    // final products = Provider.of<Products>(context).items;
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
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Added item to cart!',
                      textAlign: TextAlign.center,
                    ),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeSingleItem(currentProduct.id);
                        }),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
