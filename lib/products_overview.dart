import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';
import 'product_grid.dart';
import 'products_provider.dart';
import 'badge.dart';
import 'cart.dart';
import 'app_drawer.dart';
enum FilterOptions {
  Favorites,
  All,
}

class ProductOverview extends StatefulWidget {
  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),

            ],
          ), Consumer<Cart>(builder: (_,cart, ch)=>
          Badge(child:ch,
            value:cart.itemCount.toString(),
          ), child: IconButton(
    icon: Icon(Icons.shopping_cart),
            onPressed: (){
      Navigator.of(context).pushNamed(CartScreen.routeName);
            } ,
    ),
          )],
      ),
      drawer:AppDrawer(),
      body: new ProductsGrid(_showOnlyFavorites),
    );
  }
}
