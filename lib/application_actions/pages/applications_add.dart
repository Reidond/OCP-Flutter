import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/application_actions/components/index.dart';
import 'package:open_copyright_platform/application_actions/index.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';

class ApplicationsAdd extends StatefulWidget {
  final BottomAppBarBloc bottomAppBarBloc;
  final ApplicationsBloc applicationsBloc;
  final ApplicationActionsBloc applicationActionsBloc;

  ApplicationsAdd(
      {Key key,
      this.bottomAppBarBloc,
      this.applicationsBloc,
      this.applicationActionsBloc})
      : super(key: key);

  @override
  _ApplicationsAddState createState() => _ApplicationsAddState();
}

class _ApplicationsAddState extends State<ApplicationsAdd> {
  BottomAppBarBloc get _bottomAppBarBloc => widget.bottomAppBarBloc;

  ApplicationsBloc get _applicationsBloc => widget.applicationsBloc;

  ApplicationActionsBloc get _applicationActionsBloc =>
      widget.applicationActionsBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bottomAppBarBloc.dispatch(InitialBottomAppBar());

    return WillPopScope(
        onWillPop: () {
          _bottomAppBarBloc.dispatch(ShowAddApplicationsFAB());
          _applicationsBloc.dispatch(FetchApplications());
          Navigator.of(context).pop();
        },
        child: BlocProviderTree(
            blocProviders: [
              BlocProvider<ApplicationsBloc>(bloc: _applicationsBloc),
              BlocProvider<BottomAppBarBloc>(bloc: _bottomAppBarBloc),
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
                  bloc: _applicationsBloc,
                  builder: (BuildContext context, ApplicationsState state) {
                    return ApplicationForm();
                  },
                ))));
  }
}
