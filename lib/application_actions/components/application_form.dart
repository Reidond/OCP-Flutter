import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:open_copyright_platform/application_actions/components/nested_scrollable_bottom_sheet/bottom_widget.dart';
import 'package:open_copyright_platform/application_actions/index.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ApplicationForm extends StatefulWidget {
  final productActions = ProductsActions();
  final applicationActions = ApplicationActions();

  @override
  _ApplicationFormState createState() {
    return _ApplicationFormState();
  }
}

class _ApplicationFormState extends State<ApplicationForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  List _tasks = new List();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _taskController = TextEditingController();

  final _taskScroll = ScrollController();

  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ApplicationsBloc applicationsBloc =
        BlocProvider.of<ApplicationsBloc>(context);

    double fullSizeHeight = MediaQuery.of(context).size.height;

    final ApplicationActionsBloc applicationActionsBloc =
        BlocProvider.of<ApplicationActionsBloc>(context);

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
                  labelText: "Description", border: new OutlineInputBorder()),
              controller: _descriptionController,
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
                  bloc: applicationActionsBloc,
                  builder:
                      (BuildContext context, ApplicationActionsState state) {
                    if (state is ProductSelected) {
                      return ListTile(
                          onTap: () {
                            applicationActionsBloc
                                .dispatch(WantToSelectProduct());
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomWidget(
                                      applicationActionsBloc:
                                          applicationActionsBloc,
                                      fullSizeHeight: fullSizeHeight);
                                });
                          },
                          title: Text(state.product.name,
                              style: TextStyle(fontSize: 16.0)),
                          subtitle: Text(state.product.description),
                          dense: true);
                    } else {
                      return ListTile(
                          onTap: () {
                            applicationActionsBloc
                                .dispatch(WantToSelectProduct());
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomWidget(
                                      applicationActionsBloc:
                                          applicationActionsBloc,
                                      fullSizeHeight: fullSizeHeight);
                                });
                          },
                          title: Text('No product choosen',
                              style: TextStyle(fontSize: 16.0)),
                          subtitle: Text('Tap to choose product'),
                          dense: true);
                    }
                  },
                )
              ],
            )),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: new InputDecoration(
                  labelText: "Task", border: new OutlineInputBorder()),
              controller: _taskController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
            ),
            SizedBox(height: 12.0),
            Container(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              controller: _taskScroll,
              itemBuilder: (BuildContext context, int index) => Card(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                          onTap: () {},
                          title: Text(_tasks[index]['title'],
                              style: TextStyle(fontSize: 16.0)),
                          dense: true)
                    ],
                  )),
              itemCount: _tasks.length,
            )),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('Add task'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      List newTasks = new List.from(_tasks)
                        ..add({'title': _taskController.text});
                      setState(() => _tasks = newTasks);
                    }
                  },
                ),
                RaisedButton(
                  child: Text('Create'),
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, we want to show a Snackbar
                      applicationActionsBloc.dispatch(CreateApplication(
                          productId: await storage.read(key: 'product_id'),
                          title: _titleController.text,
                          description: _descriptionController.text,
                          tasks: _tasks));
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
