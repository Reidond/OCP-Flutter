import 'package:flutter/material.dart';
import 'package:open_copyright_platform/application_actions/index.dart';
import 'package:open_copyright_platform/products/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ApplicationActionsProductCard extends StatefulWidget {
  final Product product;
  final ApplicationActionsBloc applicationActionsBloc;
  final productId;

  ApplicationActionsProductCard({
    this.product,
    this.applicationActionsBloc,
    this.productId,
  });

  @override
  State<StatefulWidget> createState() {
    return _ApplicationActionsProductCardState(product);
  }
}

class _ApplicationActionsProductCardState
    extends State<ApplicationActionsProductCard> {
  Product product;

  ApplicationActionsBloc get _applicationActionsBloc =>
      widget.applicationActionsBloc;

  int get _productId => widget.productId;

  _ApplicationActionsProductCardState(this.product);

  Widget get applicationActionsProductCard {
    return Card(
        margin:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                onTap: () {
                  _applicationActionsBloc
                      .dispatch(TapOnProductSelect(id: _productId));
                },
                leading: Icon(
                    ProductType.getCorrespondingImageType(product.productType)),
                title: Text(product.name, style: TextStyle(fontSize: 16.0)),
                subtitle: Text(product.description),
                dense: true)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: applicationActionsProductCard);
  }
}
