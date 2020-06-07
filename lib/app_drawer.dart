import 'package:flutter/material.dart';
import 'orders_screen.dart';
import 'user_products.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/');
            },
          ),
    Divider(),
    ListTile(
    leading: Icon(Icons.payment),
    title: Text('orders'),
    onTap: () {
    Navigator.of(context)
        .pushReplacementNamed(OrdersScreen.routeName);
    },
    ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProducts.routeName);
            },
          )],
      ),
    );
  }
}
