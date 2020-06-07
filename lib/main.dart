import 'package:flutter/material.dart';
import 'products_overview.dart';
import 'package:provider/provider.dart';
import 'product_detail.dart';
import 'products_provider.dart';
import 'cart.dart';
import 'cart_screen.dart';
import 'order.dart';
import 'orders_screen.dart';
import 'user_products.dart';
import 'edit_product.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(value: Products())
        // builder: (ctx)=>Products(),
        ,
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        home: ProductOverview(),
        routes: {
          OrdersScreen.routeName:(ctx)=>OrdersScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          ProductDetail.routeName: (ctx) => ProductDetail(),
          UserProducts.routeName:(ctx)=>UserProducts(),
          EditProduct.routeName:(ctx) =>EditProduct(),
        },
      ),
    );
  }
}
