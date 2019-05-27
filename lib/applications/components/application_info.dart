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
                    _buildSubmitChip(context, application.status)
                  ],
                )
              ]),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: _buildSubmitButton(context, application.status),
                      onPressed: () {},
                    ),
                    _canEdit(context, application.status),
                    _canDelete(context, application.status),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }

  Widget _buildSubmitButton(BuildContext context, int applicationStatus) {
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

  Widget _buildSubmitChip(BuildContext context, int applicationStatus) {
    switch (applicationStatus) {
      case 10:
        return Container(
          child: Chip(
            backgroundColor: Colors.green,
            avatar: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.check, color: Colors.black87)),
            label: Text(
              'Submitted',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          padding: EdgeInsets.only(left: 15, bottom: 0),
        );
        break;
      case 0:
      case 1:
        return Container(
          child: Chip(
            backgroundColor: Colors.red,
            avatar: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.cancel, color: Colors.black87)),
            label: Text(
              'Unsubmitted',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          padding: EdgeInsets.only(left: 15),
        );
        break;
    }
    return Container(
      child: Chip(
        backgroundColor: Colors.red,
        avatar: CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(Icons.check, color: Colors.black87)),
        label: Text(
          'Unknown status',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      padding: EdgeInsets.only(left: 15),
    );
  }

  Widget _canEdit(BuildContext context, int applicationStatus) {
    switch (applicationStatus) {
      case 10:
        return Container();
        break;
      case 0:
      case 1:
        return FlatButton(
          child: const Text('EDIT'),
          onPressed: () {},
        );
        break;
    }
    return Container();
  }

  Widget _canDelete(BuildContext context, int applicationStatus) {
    switch (applicationStatus) {
      case 10:
        return Container();
        break;
      case 0:
      case 1:
        return FlatButton(
          child: const Text('DELETE'),
          onPressed: () {},
        );
        break;
    }
    return Container();
  }
}
