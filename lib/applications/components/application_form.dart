// Create a Form Widget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';

class ApplicationForm extends StatefulWidget {
  @override
  _ApplicationFormState createState() {
    return _ApplicationFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class _ApplicationFormState extends State<ApplicationForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ApplicationsBloc applicationsBloc =
        BlocProvider.of<ApplicationsBloc>(context);

    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Add application"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                tooltip: 'Back to applications',
                onPressed: () {
                  bottomAppBarBloc.dispatch(ShowAddApplicationsFAB());
                  applicationsBloc.dispatch(ApplicationFetch());
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  SizedBox(height: 40.0),
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
