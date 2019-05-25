import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/application_actions/application_actions_bloc.dart';
import 'package:open_copyright_platform/application_actions/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class InnerList extends StatelessWidget {
  final List<Product> products;
  final bool scrollEnabled;
  final ScrollController listViewScrollController;

  InnerList(
      {@required this.scrollEnabled,
      @required this.listViewScrollController,
      @required this.products});

  @override
  Widget build(BuildContext context) {
    final ApplicationActionsBloc applicationActionsBloc =
        BlocProvider.of<ApplicationActionsBloc>(context);

    return ListView.builder(
      controller: listViewScrollController,
      physics: scrollEnabled
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) =>
          ApplicationActionsProductCard(
            product: products[index],
            applicationActionsBloc: applicationActionsBloc,
            productId: products[index].id,
          ),
      itemCount: products.length,
    );
  }
}
