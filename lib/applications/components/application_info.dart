import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ApplicationInfo extends StatefulWidget {
  final Application application;

  ApplicationInfo(this.application);

  @override
  State<StatefulWidget> createState() {
    return ApplicationInfoState(application);
  }
}

class ApplicationInfoState extends State<ApplicationInfo> {
  Application application;

  ApplicationInfoState(this.application);

  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ApplicationsBloc applicationsBloc =
        BlocProvider.of<ApplicationsBloc>(context);

    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text(application.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Back to applications',
          onPressed: () {
            bottomAppBarBloc.dispatch(ShowAddApplicationsFAB());
            applicationsBloc.dispatch(FetchApplications());
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(child: Text(application.description)),
    ));
  }
}
