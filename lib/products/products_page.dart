import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _productsBloc = ProductsBloc(productsActions: _productsActions);

    _scrollController.addListener(_onScroll);
    _productsBloc.dispatch(Fetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _productsBloc,
      builder: (BuildContext context, ProductsState state) {
        if (state is ProductsUninitialized) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductsError) {
          return Center(child: Text('Failed to fetch products'));
        }
        if (state is ProductsLoaded) {
          if (state.products.isEmpty) {
            return Center(child: Text('No posts'));
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.products.length
                  ? BottomLoader()
                  : ProductCard(state.products[index]);
            },
            itemCount: state.hasReachedMax
                ? state.products.length
                : state.products.length + 1,
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

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _productsBloc.dispatch(Fetch());
    }
  }
}
