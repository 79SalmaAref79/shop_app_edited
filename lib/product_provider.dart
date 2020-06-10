import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  // isFavorite is changeable so we did not use final with it
  Product({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.price,
    this.isFavorite = false,
  });
  void _setFavValue(bool newValue){
    isFavorite=newValue;
    notifyListeners();
  }
  void toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'https://shop-app-a0dde.firebaseio.com/products_provider.json';
    try {
      final response =await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      if(response.statusCode>=400){
        isFavorite=oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
