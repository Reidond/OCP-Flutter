import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/products/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ProductInfo extends StatefulWidget {
  final Product product;

  ProductInfo(this.product);

  @override
  State<StatefulWidget> createState() {
    return ProductInfoState(product);
  }
}

class ProductInfoState extends State<ProductInfo> {
  Product product;

  ProductInfoState(this.product);

  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);

    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Back to products',
          onPressed: () {
            bottomAppBarBloc.dispatch(ShowAddProductsFAB());
            productsBloc.dispatch(Fetch());
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(child: Text(product.description)),
    ));
  }
}
