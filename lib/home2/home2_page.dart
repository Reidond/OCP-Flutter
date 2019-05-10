import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/home2/index.dart';
import 'package:open_copyright_platform/settings/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

import '../authentication/index.dart';

import '../bottom_app_bar/index.dart';

import '../products/index.dart';

class Home2Page extends StatefulWidget {
  final productsActions = ProductsActions();

  @override
  State<StatefulWidget> createState() {
    return _Home2State();
  }
}

class _Home2State extends State<Home2Page> {
  ProductsActions get _productsActions => widget.productsActions;

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

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
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<BottomAppBarEvent, BottomAppBarState>(
            bloc: bottomAppBarBloc,
            builder: (BuildContext context, BottomAppBarState state) {
              if (state is InitialBottomAppBarState) {
                return Container(width: 0.0, height: 0.0);
              }
              if (state is ProductsPageState) {
                return FloatingActionButton.extended(
                  elevation: 4.0,
                  icon: const Icon(Icons.add),
                  label: const Text('Add a product'),
                  onPressed: () {},
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
                            authenticationBloc: authenticationBloc,
                          )));
                },
              )
            ],
          ),
        ),
        body: BlocProviderTree(
          blocProviders: [
            BlocProvider<BottomAppBarBloc>(bloc: bottomAppBarBloc),
            BlocProvider<ThemeBloc>(bloc: _themeBloc)
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
                  },
                ),
              );
            },
          )
        )
    );
  }
}
