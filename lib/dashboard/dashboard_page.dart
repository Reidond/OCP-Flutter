import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/auth/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/dashboard/index.dart';
import 'package:open_copyright_platform/home2/index.dart';
import 'package:open_copyright_platform/settings/index.dart';

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
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    final ThemeBloc _themeBloc = BlocProvider.of<ThemeBloc>(context);

    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return new Scaffold(
        key: _scaffoldKey,
        body: BlocProviderTree(
            blocProviders: [
              BlocProvider<Home2Bloc>(bloc: _home2bloc),
              BlocProvider<AuthBloc>(bloc: authBloc),
              BlocProvider<BottomAppBarBloc>(bloc: _bottomAppBarBloc),
              BlocProvider<ThemeBloc>(bloc: _themeBloc)
            ],
            child: BlocBuilder(
                bloc: _themeBloc,
                builder: (_, ThemeData theme) {
                  return MaterialApp(
                    theme: theme,
                    home: BlocBuilder<DashBoardEvent, DashBoardState>(
                      bloc: _dashBoardBloc,
                      builder: (BuildContext context, DashBoardState state) {
                        if (state is InitialDashBoardState) {
                          return Home2Page();
                        }
                      },
                    ),
                  );
                })));
  }
}
