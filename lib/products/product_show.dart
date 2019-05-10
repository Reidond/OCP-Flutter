import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/products/index.dart';

class ProductShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page B'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Pop'),
          onPressed: () {
            BlocProvider.of<ProductsBloc>(context).dispatch(Fetch());
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}