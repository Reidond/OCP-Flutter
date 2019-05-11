import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/products/index.dart';

class ProductsList extends StatelessWidget {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<ProductsBloc>(context),
      listener: (BuildContext context, ProductsState state) {
        if (state is ProductShowed) {
          Navigator.of(context).pushNamed('/show');
        }
      },
      child: BlocBuilder(
        bloc: BlocProvider.of<ProductsBloc>(context),
        builder: (BuildContext context, ProductsState state) {
          if (state is ProductsUninitialized) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductsError) {
            return Center(
                child: Center(child: Text('Failed to fetch products')));
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
      ),
    );
  }
}
