import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/application_actions/components/index.dart';
import 'package:open_copyright_platform/application_actions/index.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ApplicationsAdd extends StatefulWidget {
  final BottomAppBarBloc bottomAppBarBloc;
  final ApplicationsBloc applicationsBloc;
  final applicationActions = ApplicationActions();
  final ProductsActions productsActions;

  ApplicationsAdd(
      {Key key,
      this.productsActions,
      this.bottomAppBarBloc,
      this.applicationsBloc})
      : super(key: key);

  @override
  _ApplicationsAddState createState() => _ApplicationsAddState();
}

class _ApplicationsAddState extends State<ApplicationsAdd> {
  ApplicationActionsBloc _applicationActionsBloc;

  @override
  void initState() {
    _applicationActionsBloc = new ApplicationActionsBloc(
        productsActions: widget.productsActions,
        applicationActions: widget.applicationActions);

    super.initState();
  }

  @override
  void dispose() {
    _applicationActionsBloc.dispose();

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
              BlocProvider<ApplicationActionsBloc>(
                  bloc: _applicationActionsBloc)
            ],
            child: BlocListener(
                bloc: _applicationActionsBloc,
                listener:
                    (BuildContext context, ApplicationActionsState state) {
                  if (state is ApplicationCreated) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Application created!'),
                      backgroundColor: Colors.greenAccent,
                      duration: Duration(seconds: 5),
                    ));
                  }
                  if (state is ApplicationNotCreated) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Application does not created!'),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 5),
                    ));
                  }
                },
                child: BlocBuilder(
                  bloc: widget.applicationsBloc,
                  builder: (BuildContext context, ApplicationsState state) {
                    return ApplicationForm();
                  },
                ))));
  }
}
