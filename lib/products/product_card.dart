import 'package:flutter/material.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard(this.product);

  @override
  State<StatefulWidget> createState() {
    return ProductCardState(product);
  }
}

class ProductCardState extends State<ProductCard> {
  Product product;

  ProductCardState(this.product);

  Widget get productCard {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
            leading: Text('${product.productType}',
                style: TextStyle(fontSize: 10.0)),
            title: Text(product.name),
            isThreeLine: true,
            subtitle: Text(product.description),
            dense: true)
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: productCard);
  }
}
