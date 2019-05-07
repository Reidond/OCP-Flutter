import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/dashboard/index.dart';
import 'package:open_copyright_platform/home2/index.dart';

import '../authentication/index.dart';

import '../bottom_app_bar/index.dart';

import '../products/index.dart';

class DashBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashBoardState();
  }
}

class _DashBoardState extends State<DashBoardPage> {
  BottomAppBarBloc _bottomAppBarBloc;
  Home2Bloc _home2bloc;
  DashBoardBloc _dashBoardBloc;

  @override
  void initState() {
    _home2bloc = Home2Bloc();
    _bottomAppBarBloc = BottomAppBarBloc();
    _dashBoardBloc = DashBoardBloc();

    _bottomAppBarBloc.dispatch(InitialBottomAppBar());
    _home2bloc.dispatch(InitialHome2());
    _dashBoardBloc.dispatch(InitialDashBoard());
    super.initState();
  }

  @override
  void dispose() {
    _home2bloc.dispose();
    _bottomAppBarBloc.dispose();
    _dashBoardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return new Scaffold(
        key: _scaffoldKey,
        body: BlocProviderTree(
          blocProviders: [
            BlocProvider<Home2Bloc>(bloc: _home2bloc),
            BlocProvider<AuthenticationBloc>(bloc: authenticationBloc),
            BlocProvider<BottomAppBarBloc>(bloc: _bottomAppBarBloc)
          ],
          child: MaterialApp(
            title: 'Open Copyright Platform',
            home: BlocBuilder<DashBoardEvent, DashBoardState>(
              bloc: _dashBoardBloc,
              builder: (BuildContext context, DashBoardState state) {
                if (state is InitialDashBoardState) {
                  return Home2Page();
                }
              },
            ),
          ),
        ));
  }
}
