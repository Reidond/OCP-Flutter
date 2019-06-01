import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/application_actions/index.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ApplicationList extends StatefulWidget {
  @override
  _ApplicationListState createState() => _ApplicationListState();
}

class _ApplicationListState extends State<ApplicationList> {
  final _scrollController = ScrollController();

  ApplicationActionsBloc _applicationActionsBloc;

  @override
  void initState() {
    _applicationActionsBloc = new ApplicationActionsBloc(
        productsActions: ProductsActions(),
        applicationActions: ApplicationActions());

    super.initState();
  }

  @override
  void dispose() {
    _applicationActionsBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationActionsBloc applicationActionsBloc =
        BlocProvider.of<ApplicationActionsBloc>(context);

    return BlocListener(
      bloc: BlocProvider.of<ApplicationsBloc>(context),
      listener: (BuildContext context, ApplicationsState state) {
        if (state is ApplicationShowed) {
          Navigator.of(context).pushNamed('/application_show');
        }
        if (state is ShowQuickSearch) {
          Navigator.of(context).pushNamed('/application_quick_search');
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
                return Dismissible(
                  key: Key(state.applications[index].id.toString()),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    BlocProvider.of<ApplicationsBloc>(context).dispatch(
                        DeleteApplication(id: state.applications[index].id));
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${state.applications[index].title} dismissed")));
                  },
                  child: ApplicationCard(state.applications[index]),
                );
              },
              itemCount: state.applications.length,
              controller: _scrollController,
            );
          }
          return Container();
        },
      ),
    );
  }
}
