import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/application_actions/index.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/auth/index.dart';
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
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ApplicationsBloc applicationsBloc =
        BlocProvider.of<ApplicationsBloc>(context);

    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

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
      body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Card(
          elevation: 1,
          margin: EdgeInsets.all(7.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        application.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      padding: EdgeInsets.all(15),
                    )
                  ],
                )
              ]),
              Divider(),
              Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Status',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      padding: EdgeInsets.all(15),
                    )
                  ],
                )
              ]),
              Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    BlocBuilder(
                      bloc: _applicationActionsBloc,
                      builder: (BuildContext context,
                          ApplicationActionsState state) {
                        if (state is ApplicationStatusChanged) {
                          return _buildSubmitChip(state.currentStatus);
                        } else {
                          return _buildSubmitChip(application.status);
                        }
                      },
                    )
                  ],
                )
              ]),
              ButtonTheme.bar(
                  child: Wrap(
                children: <Widget>[
                  BlocBuilder(
                    bloc: _applicationActionsBloc,
                    builder:
                        (BuildContext context, ApplicationActionsState state) {
                      if (state is ApplicationStatusChanged) {
                        return ButtonBar(
                          children: <Widget>[
                            _statusButton(state.currentStatus)
                          ],
                        );
                      } else {
                        return ButtonBar(
                          children: <Widget>[_statusButton(application.status)],
                        );
                      }
                    },
                  ),
                  BlocBuilder(
                    bloc: authBloc,
                    builder: (BuildContext context, AuthState state) {
                      if (state is AuthAsExecutor) {
                        return FlatButton(
                          child: Text('Search'),
                          onPressed: () {
//                            Scaffold.of(context).showSnackBar(
//                                SnackBar(content: Text("Not implemented")));
                            applicationsBloc.dispatch(
                                WantToSearch(productId: application.productId));
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              )),
            ],
          ),
        ),
        Container(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: application.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(application.tasks[index].toString()),
                  trailing: GestureDetector(
                      child: Icon(Icons.more_vert), onTap: () {}),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ]),
    ));
  }

  Widget _buildSubmitButtonText(int applicationStatus) {
    switch (applicationStatus) {
      case 10:
        return Text('UNSUBMIT');
        break;
      case 0:
      case 1:
        return Text('SUBMIT');
        break;
      default:
    }
    return Text('UNKNOWN STATUS');
  }

  Widget _chip(text, icon, backgroundColor, foregroundColor) {
    return Container(
      child: Chip(
        backgroundColor: backgroundColor,
        avatar: CircleAvatar(
            backgroundColor: backgroundColor,
            child: Icon(icon, color: foregroundColor)),
        label: Text(
          text,
          style: TextStyle(color: foregroundColor),
        ),
      ),
      padding: EdgeInsets.only(left: 15, bottom: 0),
    );
  }

  Widget _buildSubmitChip(int applicationStatus) {
    switch (applicationStatus) {
      case 10:
        return _chip('Submitted', Icons.check, Colors.green, Colors.black87);
        break;
      case 0:
      case 1:
        return _chip('Unsubmitted', Icons.cancel, Colors.red, Colors.black87);
        break;
    }
    return _chip(
        'Unknown status', Icons.warning, Colors.indigo, Colors.black87);
  }

  Widget _statusButton(int currentStatus) {
    switch (currentStatus) {
      case 10:
        return FlatButton(
          child: _buildSubmitButtonText(currentStatus),
          onPressed: () {
            _applicationActionsBloc
                .dispatch(UnSubmitApplication(id: application.id));
          },
        );
        break;
      case 0:
      case 1:
        return FlatButton(
          child: _buildSubmitButtonText(currentStatus),
          onPressed: () {
            _applicationActionsBloc
                .dispatch(SubmitApplication(id: application.id));
          },
        );
        break;
    }
    return Container();
  }
}
