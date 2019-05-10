import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/settings/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

import 'package:open_copyright_platform/products/index.dart';

import 'package:open_copyright_platform/common/index.dart';

class ProductsPage extends StatefulWidget {
  final ProductsActions productsActions;

  ProductsPage({Key key, @required this.productsActions})
      : assert(productsActions != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  ProductsActions get _productsActions => widget.productsActions;

  ProductsBloc _productsBloc;

  @override
  void initState() {
    _productsBloc = ProductsBloc(productsActions: _productsActions);

    _productsBloc.dispatch(Fetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ThemeBloc _themeBloc = BlocProvider.of<ThemeBloc>(context);

    bottomAppBarBloc.dispatch(BottomAppBarAddProducts());

    return BlocProvider<ProductsBloc>(
      bloc: _productsBloc,
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeData theme) {
          return MaterialApp(
            theme: theme,
            routes: {
              '/': (context) => ProductList(),
              '/show': (context) => ProductShow(),
            },
            initialRoute: '/',
          );
        },
      )
    );
  }

  @override
  void dispose() {
    _productsBloc.dispose();
    super.dispose();
  }
}
