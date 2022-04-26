import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    var url = Uri.https(
        'shopme-62fae-default-rtdb.firebaseio.com', '/products/$id.json');
    try {
      await http.patch(url, body: json.encode({"isFavorite": isFavorite}));
    } catch (err) {
      isFavorite = oldStatus;
    }
    notifyListeners();
  }
}
