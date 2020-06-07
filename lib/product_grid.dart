import 'package:flutter/material.dart';
import 'products_provider.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        //builder: (c) => products[i],
        child: ProductItem(
            //products[i].imageUrl,
            // products[i].title,
            // products[i].id),
            ),
      ),
      // The item builder defines how every grid item is built how every grid cell should be built
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      //The grid delegate allows us to define how the grid generally should be structured so how many columns
      //it should have.
    );
  }
}
