import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/products/components/product_info.dart';
import 'package:open_copyright_platform/products/index.dart';

class ProductsShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);

    bottomAppBarBloc.dispatch(InitialBottomAppBar());

    return BlocProviderTree(
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
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
