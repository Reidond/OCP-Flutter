import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/settings/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

import 'package:open_copyright_platform/products/index.dart';

import 'package:open_copyright_platform/common/index.dart';

class ProductsPage extends StatefulWidget {
  final ProductsActions productsActions;
  final SettingsBloc settingsBloc;

  ProductsPage({Key key, @required this.productsActions, this.settingsBloc})
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
  final _scrollController = ScrollController();

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

    bottomAppBarBloc.dispatch(BottomAppBarAddProducts());

    return BlocBuilder(
      bloc: _productsBloc,
      builder: (BuildContext context, ProductsState state) {
        if (state is ProductsUninitialized) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductsError) {
          return Center(child: Center(child: Text('Failed to fetch products')));
        }
        if (state is ProductsLoaded) {
          if (state.products.isEmpty) {
            return Center(child: Center(child: Text('No posts')));
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(state.products[index]);
            },
            itemCount: state.products.length,
            controller: _scrollController,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _productsBloc.dispose();
    super.dispose();
  }
}
