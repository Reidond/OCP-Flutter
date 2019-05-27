import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';

class ApplicationList extends StatelessWidget {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<ApplicationsBloc>(context),
      listener: (BuildContext context, ApplicationsState state) {
        if (state is ApplicationShowed) {
          Navigator.of(context).pushNamed('/application_show');
        }
      },
      child: BlocBuilder(
        bloc: BlocProvider.of<ApplicationsBloc>(context),
        builder: (BuildContext context, ApplicationsState state) {
          if (state is ApplicationsUninitialized) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ApplicationsError) {
            return Center(
                child: Center(child: Text('Failed to fetch applications')));
          }
          if (state is ApplicationsLoaded) {
            if (state.applications.isEmpty) {
              return Center(child: Center(child: Text('No applications')));
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ApplicationCard(state.applications[index]);
              },
              itemCount: state.applications.length,
              controller: _scrollController,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
