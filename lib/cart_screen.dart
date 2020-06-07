import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart'show Cart;
import 'cart_item.dart' ;
import 'order.dart';
class CartScreen extends StatelessWidget {
static const routeName='/cart';
  @override
  Widget build(BuildContext context) {
    final cart=Provider.of<Cart>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child:  Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total',style: TextStyle(
                    fontSize: 20,
                  ),),

                  Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                        backgroundColor: Theme.of(context).primaryColor,
                  ),
                FlatButton(
                  child: Text('Order Now'),
                  onPressed: (){
                    Provider.of<Orders>(context,listen: false).
                    addOrder(cart.items.values.toList(),
                        cart.totalAmount);
                    cart.clear();
                  },
                  textColor: Theme.of(context).primaryColor,
                )],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                 cart.items.values.toList()[i].id,
                 cart.items.keys.toList()[i],
                 cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].title,

              ),
            ),
          ),
        ],
      ),
    );

  }
}
