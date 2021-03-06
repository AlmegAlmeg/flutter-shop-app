import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    //   Product(
    //     id: 'p1',
    //     title: 'Red Shirt',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   ),
    //   Product(
    //     id: 'p2',
    //     title: 'Trousers',
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   ),
    //   Product(
    //     id: 'p3',
    //     title: 'Yellow Scarf',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 19.99,
    //     imageUrl:
    //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   ),
    //   Product(
    //     id: 'p4',
    //     title: 'A Pan',
    //     description: 'Prepare any meal you want.',
    //     price: 49.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    try {
      var url = Uri.https(
          'shopme-62fae-default-rtdb.firebaseio.com', '/products.json');
      final res = await http.get(url);
      final data = json.decode(res.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      data.forEach((id, item) {
        loadedProducts.add(
          Product(
              id: id,
              title: item['title'],
              description: item['description'],
              price: item["price"],
              imageUrl: item['imageUrl'],
              isFavorite: item['isFavorite']),
        );
      });
      _items = loadedProducts;
    } catch (err) {
      throw err;
    }
  }

  Future<void> addProduct(Product product) {
    var url =
        Uri.https('shopme-62fae-default-rtdb.firebaseio.com', '/products.json');
    return http
        .post(
      url,
      body: json.encode(
        {
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    )
        .then((res) {
      final newProduct = Product(
          id: json.decode(res.body)['name'],
          title: product.title,
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price);
      _items.add(newProduct);
      notifyListeners();
    }).catchError((err) {
      throw err;
    });
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      var url = Uri.https(
          'shopme-62fae-default-rtdb.firebaseio.com', '/products/$id.json');
      await http.patch(url,
          body: json.encode({
            "title": newProduct.title,
            "description": newProduct.description,
            "imageUrl": newProduct.imageUrl,
            "price": newProduct.price,
          }));
      _items[index] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    var url = Uri.https(
        'shopme-62fae-default-rtdb.firebaseio.com', '/products/$id.json');
    var index = _items.indexWhere((item) => item.id == id);
    _items.removeAt(index);
    notifyListeners();
    await http
        .delete(url, body: id)
        .then((_) => _items[index] = null!)
        .catchError((_) => _items.insert(index, _items[index]));
  }
}
