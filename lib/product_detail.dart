import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  //final String title;
  //final double price;
  //ProductDetail(this.title,this.price);
  static const routeName = '/product_detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context,).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context,
      listen:false,
      //that of course is something you should do if you only need data one time you
      //just want to get data from your global data storage but you're not interested in updates then you don't
      //need to listen.
        ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(loadedProduct.imageUrl,
              fit: BoxFit.cover,),
            ),
            SizedBox(
              height: 10,
            ),
            Text('\$${loadedProduct.price}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding:EdgeInsets.symmetric(
                horizontal: 10,
              ) ,
              child: Text(loadedProduct.description,
                textAlign: TextAlign.center,
              softWrap: true,),
            ),

          ],
        ),
      ),
    );
  }
}
