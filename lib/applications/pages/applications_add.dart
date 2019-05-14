import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';

class ApplicationsAdd extends StatelessWidget {
  final BottomAppBarBloc bottomAppBarBloc;
  final ApplicationsBloc applicationsBloc;

  ApplicationsAdd({Key key, this.bottomAppBarBloc, this.applicationsBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bottomAppBarBloc.dispatch(InitialBottomAppBar());

    return WillPopScope(
        onWillPop: () {
          bottomAppBarBloc.dispatch(ShowAddApplicationsFAB());
          applicationsBloc.dispatch(ApplicationFetch());
          Navigator.of(context).pop();
        },
        child: BlocProviderTree(
            blocProviders: [
              BlocProvider<ApplicationsBloc>(bloc: applicationsBloc),
              BlocProvider<BottomAppBarBloc>(bloc: bottomAppBarBloc)
            ],
            child: BlocBuilder(
              bloc: applicationsBloc,
              builder: (BuildContext context, ApplicationsState state) {
                return ApplicationForm();
              },
            )));
  }
}
