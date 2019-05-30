import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';

class ApplicationsShow extends StatelessWidget {
  final _scrollController = ScrollController();
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
          applicationsBloc.dispatch(FetchApplications());
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
                if (state is ApplicationShowUninitialized) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ApplicationShowError) {
                  return Center(
                      child: Center(child: Text('Failed to show application')));
                }
                if (state is ApplicationShowLoaded) {
                  return ApplicationInfo(state.application);
                }
                if (state is ApplicationsLoaded) {
                  if (state.applications.isEmpty) {
                    return Center(
                        child: Center(child: Text('No applications')));
                  }
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return ApplicationCard(state.applications[index]);
                    },
                    itemCount: state.applications.length,
                    controller: _scrollController,
                  );
                }
                return Container();
              },
            )));
  }
}
