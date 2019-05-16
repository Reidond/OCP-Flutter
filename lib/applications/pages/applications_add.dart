import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/products/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ApplicationsAdd extends StatefulWidget {
  final BottomAppBarBloc bottomAppBarBloc;
  final ApplicationsBloc applicationsBloc;
  final ProductsActions productsActions;

  ApplicationsAdd({Key key, this.productsActions, this.bottomAppBarBloc, this.applicationsBloc})
      : super(key: key);

  @override
  _ApplicationsAddState createState() => _ApplicationsAddState();
}

class _ApplicationsAddState extends State<ApplicationsAdd> {
  ProductsBloc _productsBloc;

  @override
  void initState() {
    _productsBloc = new ProductsBloc(productsActions: widget.productsActions);
    
    super.initState();
  }

  @override
  void dispose() {
    _productsBloc.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.bottomAppBarBloc.dispatch(InitialBottomAppBar());

    return WillPopScope(
        onWillPop: () {
          widget.bottomAppBarBloc.dispatch(ShowAddApplicationsFAB());
          widget.applicationsBloc.dispatch(FetchApplications());
          Navigator.of(context).pop();
        },
        child: BlocProviderTree(
            blocProviders: [
              BlocProvider<ApplicationsBloc>(bloc: widget.applicationsBloc),
              BlocProvider<BottomAppBarBloc>(bloc: widget.bottomAppBarBloc),
              BlocProvider<ProductsBloc>(bloc: _productsBloc)
            ],
            child: BlocBuilder(
              bloc: widget.applicationsBloc,
              builder: (BuildContext context, ApplicationsState state) {
                return ApplicationForm();
              },
            )));
  }
}
