import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/products/index.dart';
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
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          ListTile(
            onTap: () {
              BlocProvider.of<ProductsBloc>(context).dispatch(Show(id: product.id));
            },
            leading: Icon(ProductType.getCorrespondingImageType(product.productType)),
            title: Text(product.name,
                style: TextStyle(fontSize: 16.0)),
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
