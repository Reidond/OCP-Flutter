import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/settings/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ApplicationsPage extends StatefulWidget {
  final ApplicationActions applicationActions;

  ApplicationsPage({Key key, @required this.applicationActions})
      : assert(applicationActions != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ApplicationsPageState();
  }
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ApplicationsBloc applicationsBloc =
        BlocProvider.of<ApplicationsBloc>(context);

    final ThemeBloc _themeBloc = BlocProvider.of<ThemeBloc>(context);

    bottomAppBarBloc.dispatch(ShowAddApplicationsFAB());

    applicationsBloc.dispatch(ApplicationFetch());

    return BlocProviderTree(
        blocProviders: [
          BlocProvider<ApplicationsBloc>(bloc: applicationsBloc),
          BlocProvider<BottomAppBarBloc>(bloc: bottomAppBarBloc)
        ],
        child: BlocBuilder(
          bloc: _themeBloc,
          builder: (_, ThemeData theme) {
            return MaterialApp(
              theme: theme,
              routes: {
                '/': (context) => ApplicationList(),
                '/application_show': (context) => ApplicationsShow()
              },
              initialRoute: '/',
            );
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
