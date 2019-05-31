import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/application_actions/index.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/auth/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/home2/index.dart';
import 'package:open_copyright_platform/products/index.dart';
import 'package:open_copyright_platform/settings/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class Home2Page extends StatefulWidget {
  final productsActions = ProductsActions();
  final applicationsActions = ApplicationActions();

  @override
  State<StatefulWidget> createState() {
    return _Home2State();
  }
}

class _Home2State extends State<Home2Page> {
  ProductsActions get _productsActions => widget.productsActions;

  ApplicationActions get _applicationActions => widget.applicationsActions;

  ApplicationActionsBloc _applicationActionsBloc;

  ApplicationsBloc _applicationsBloc;

  @override
  void initState() {
    _applicationActionsBloc = ApplicationActionsBloc(
        productsActions: _productsActions,
        applicationActions: _applicationActions);

    _applicationsBloc = ApplicationsBloc(_applicationActionsBloc,
        applicationActions: _applicationActions);

    super.initState();
  }

  @override
  void dispose() {
    _applicationActionsBloc.dispose();

    _applicationsBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ThemeBloc _themeBloc = BlocProvider.of<ThemeBloc>(context);

    final Home2Bloc home2Bloc = BlocProvider.of<Home2Bloc>(context);

    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return new Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image.asset('assets/icon.png'),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor ==
                          ThemeData.light().backgroundColor
                      ? Colors.white
                      : Colors.black12,
                ),
              ),
              ListTile(
                title: Text('Products'),
                onTap: () {
                  home2Bloc.dispatch(ProductsDrawerButtonPressed());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Applications'),
                onTap: () {
                  home2Bloc.dispatch(ApplicationsDrawerButtonPressed());
                  Navigator.pop(context);
                },
              ),
              // ListTile(
              //   title: Text('Profile'),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<BottomAppBarEvent, BottomAppBarState>(
            bloc: bottomAppBarBloc,
            builder: (BuildContext context, BottomAppBarState state) {
              if (state is InitialBottomAppBarState) {
                return Container(width: 0.0, height: 0.0);
              }
              if (state is ShowAddProductsFABState) {
                return FloatingActionButton.extended(
                  elevation: 4.0,
                  icon: const Icon(Icons.add),
                  label: const Text('Add a product'),
                  onPressed: () {},
                );
              }
              if (state is ShowAddApplicationsFABState) {
                return FloatingActionButton.extended(
                  elevation: 4.0,
                  icon: const Icon(Icons.add),
                  label: const Text('Add application'),
                  onPressed: () {
                    _applicationsBloc.dispatch(AddApplication());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ApplicationsAdd(
                              bottomAppBarBloc: bottomAppBarBloc,
                              applicationsBloc: _applicationsBloc,
                              applicationActionsBloc: _applicationActionsBloc,
                            )));
                  },
                );
              }
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SettingsPage(
                            themeBloc: _themeBloc,
                            authBloc: authBloc,
                          )));
                },
              )
            ],
          ),
        ),
        body: BlocProviderTree(
            blocProviders: [
              BlocProvider<BottomAppBarBloc>(bloc: bottomAppBarBloc),
              BlocProvider<ThemeBloc>(bloc: _themeBloc),
              BlocProvider<ApplicationsBloc>(bloc: _applicationsBloc),
              BlocProvider<ApplicationActionsBloc>(
                  bloc: _applicationActionsBloc)
            ],
            child: BlocBuilder(
              bloc: _themeBloc,
              builder: (_, ThemeData theme) {
                return MaterialApp(
                  theme: theme,
                  home: BlocBuilder<Home2Event, Home2State>(
                    bloc: home2Bloc,
                    builder: (BuildContext context, Home2State state) {
                      if (state is InitialHome2State) {
                        return Container(child: Center(child: Text("Henlo")));
                      }
                      if (state is ProductsDrawerButton) {
                        return ProductsPage(productsActions: _productsActions);
                      }
                      if (state is ApplicationsDrawerButton) {
                        return ApplicationsPage(
                            applicationActions: _applicationActions);
                      }
                    },
                  ),
                );
              },
            )));
  }
}
