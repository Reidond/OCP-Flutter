import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/products/index.dart';

class ApplicationForm extends StatefulWidget {
  @override
  _ApplicationFormState createState() {
    return _ApplicationFormState();
  }
}

class _ApplicationFormState extends State<ApplicationForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ApplicationsBloc applicationsBloc =
        BlocProvider.of<ApplicationsBloc>(context);

    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);

    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Add application"),
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
            body: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  SizedBox(height: 24.0),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Title",
                      border: new OutlineInputBorder(),
                    ),
                    controller: _titleController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Description",
                        border: new OutlineInputBorder()),
                    controller: _descriptionController,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                  SizedBox(height: 12.0),
                  Card(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      BlocBuilder(
                        bloc: productsBloc,
                        builder: (BuildContext context, ProductsState state) {
                          return ListTile(
                              onTap: () {
                                _settingModalBottomSheet(context, productsBloc);
                              },
                              title: Text('No product choosen',
                                  style: TextStyle(fontSize: 16.0)),
                              subtitle: Text('Tap to choose product'),
                              dense: true);
                        },
                      )
                    ],
                  )),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Create'),
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, we want to show a Snackbar
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}

void _settingModalBottomSheet(context, productsBloc) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return BlocBuilder(
          bloc: productsBloc,
          builder: (BuildContext context, ProductsState state) {
            return Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.music_note),
                      title: new Text('Music'),
                      onTap: () => {}),
                  new ListTile(
                    leading: new Icon(Icons.videocam),
                    title: new Text('Video'),
                    onTap: () => {},
                  ),
                ],
              ),
            );
          },
        );
      });
}
