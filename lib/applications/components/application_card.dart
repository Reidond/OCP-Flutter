import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ApplicationCard extends StatefulWidget {
  final Application application;

  ApplicationCard(this.application);

  @override
  State<StatefulWidget> createState() {
    return ApplicationCardState(application);
  }
}

class ApplicationCardState extends State<ApplicationCard> {
  Application application;

  ApplicationCardState(this.application);

  Widget get applicationCard {
    return Card(
        margin:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                onTap: () {
                  BlocProvider.of<ApplicationsBloc>(context)
                      .dispatch(ShowApplication(id: application.id));
                },
                leading: Text(application.status.toString(),
                    style: TextStyle(fontSize: 12.0)),
                title:
                    Text(application.title, style: TextStyle(fontSize: 16.0)),
                subtitle: Text(application.description),
                dense: true)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: applicationCard);
  }
}
