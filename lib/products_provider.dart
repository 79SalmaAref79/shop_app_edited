/*
* you need to add a mix in, adding the with keyword and
then the name of the mix in a mix in,you simply merge some properties or add some methods into your existing
class but you don't return your class into an instance off that inherited class.
*/

import 'http_exception.dart';
import 'package:flutter/material.dart';
import 'product_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
//    Product(
//      id: 'p1',
//      title: 'Red Shirt',
//      description: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:
//          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//    ),
//    Product(
//      id: 'p2',
//      title: 'Trousers',
//      description: 'A nice pair of trousers.',
//      price: 59.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//    ),
//    Product(
//      id: 'p3',
//      title: 'Yellow Scarf',
//      description: 'Warm and cozy - exactly what you need for the winter.',
//      price: 19.99,
//      imageUrl:
//          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//    ),
//    Product(
//      id: 'p4',
//      title: 'A Pan',
//      description: 'Prepare any meal you want.',
//      price: 49.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//    ),
  ];

  //var _showFavoritesOnly=false;
  List<Product> get items {
//    if(_showFavoritesOnly){
//      return _items.where
//        ((productItem)=>productItem.isFavorite)
//          .toList();
//    }
    return [..._items];
    // we want to return o copy of these items so we
    // wrap them by square brackets and use spread operator
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

//  void showFavoritesOnly(){
//    _showFavoritesOnly=true;
//    notifyListeners();
//  }
//  void showAll(){
//    _showFavoritesOnly=false;
//    notifyListeners();
//  }
  Future <void> fetchAndSetProducts() async{
    const url = 'https://shop-app-a0dde.firebaseio.com/products_provider.json';
  try{
    final response = await http.get(url);
    final extractedData=json.decode(response.body)as
    Map<String,dynamic>;
    final List<Product>loadedProducts=[];
    extractedData.forEach((prodId,prodData){
     loadedProducts.add(Product(
       id: prodId,
       title: prodData['title'],
       description: prodData['description'],
       price: prodData['price'],
       isFavorite: prodData['isfavorite'],
       imageUrl: prodData['imageUrl'],
     ));
    });
    _items=loadedProducts;
    notifyListeners();
  }
  catch (error) {
    throw (error);
  }
  }
  Future<void> addProduct(Product product) async {
    const url = 'https://shop-app-a0dde.firebaseio.com/products_provider.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite
        }),
      );
      final newProduct = Product(
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          id: json.decode(response.body)['name']);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  /*we  use  notify listeners so that in these widgets which are listening to this class and to changes
in this class are then rebuilt and do actually get the latest data we have in there and that's why return
a copy so that we can directly edit our items here from anywhere else in the app.

    * */

  Future<void>updateProduct(String id, Product newProduct) async{
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://shop-app-a0dde.firebaseio.com/products_provider/$id.json';
     await http.patch(url,body: json.encode({'title':newProduct.title
      ,'description':newProduct.description,
      'imageUrl':newProduct.imageUrl,
      'price':newProduct.price}));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  Future <void> deleteProduct(String id) async {

    final url = 'https://shop-app-a0dde.firebaseio.com/products_provider/$id.json';
   final existingProductIndex=_items.indexWhere((prod)=>prod.id==id);
   var existingProduct=_items[existingProductIndex];
    final response=await http.delete(url);
      if(response.statusCode>=400){
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException('Couldn’t delelte product.');
      }
      existingProduct=null;
//      _items.removeWhere((prod) => prod.id == id);
//    notifyListeners();

}}
