import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/products/components/product_info.dart';
import 'package:open_copyright_platform/products/index.dart';

class ProductsShow extends StatelessWidget {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);

    bottomAppBarBloc.dispatch(InitialBottomAppBar());

    return WillPopScope(
        onWillPop: () {
          bottomAppBarBloc.dispatch(ShowAddProductsFAB());
          productsBloc.dispatch(Fetch());
          Navigator.of(context).pop();
        },
        child: BlocProviderTree(
            blocProviders: [
              BlocProvider<ProductsBloc>(bloc: productsBloc),
              BlocProvider<BottomAppBarBloc>(bloc: bottomAppBarBloc)
            ],
            child: BlocBuilder(
              bloc: productsBloc,
              builder: (BuildContext context, ProductsState state) {
                if (state is ProductShowUninitialized) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ProductShowError) {
                  return Center(
                      child: Center(child: Text('Failed to show product')));
                }
                if (state is ProductShowLoaded) {
                  return ProductInfo(state.product);
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
                return Center(child: CircularProgressIndicator());
              },
            )));
  }
}
