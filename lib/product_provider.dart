
import 'package:flutter/foundation.dart';
class Product with ChangeNotifier {
  final  String id;
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
   this.isFavorite=false,
});
  void toggleFavoriteStatus(){
    isFavorite= !isFavorite;
    notifyListeners();

  }
 }