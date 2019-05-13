import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';

class ApplicationsAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ApplicationsBloc applicationsBloc =
        BlocProvider.of<ApplicationsBloc>(context);

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
                return Center(child: Text("Nothing here yet"));
              },
            )));
  }
}
