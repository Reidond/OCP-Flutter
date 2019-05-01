import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

import 'package:open_copyright_platform/products/index.dart';

class ProductsPage extends StatefulWidget {
  final UserRepository userRepository;

  ProductsPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  ProductsBloc _productsBloc;

  @override
  void initState() {
    _productsBloc = ProductsBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }

  @override
  void dispose() {
    _productsBloc.dispose();
    super.dispose();
  }
}
