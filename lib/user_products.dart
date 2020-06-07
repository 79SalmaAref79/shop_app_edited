import 'package:flutter/material.dart';
import 'products_provider.dart';
import 'package:provider/provider.dart';
import 'user_product_item.dart';
import 'app_drawer.dart';
import 'edit_product.dart';
class UserProducts extends StatelessWidget {
  static const routeName='/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData =
    Provider.of<Products>(context);
    return Scaffold(appBar: AppBar(
      title: Text('Your products'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).pushNamed(EditProduct.routeName);},
        ),
      ],
    ),
    drawer: AppDrawer(),
    body: Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(itemCount:
      productsData.items.length,
      itemBuilder:(_,i)=>Column(
        children: <Widget>[
          UserProductItem(
            productsData.items[i].id,
            productsData.items[i].title,
            productsData.items[i].imageUrl,
          ),
          Divider(),
        ],
      ) ,),
    ),);
  }
}
