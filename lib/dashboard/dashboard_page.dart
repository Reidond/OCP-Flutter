import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/index.dart';

import '../bottom_app_bar/index.dart';

import '../products/index.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);

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
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Products'),
                onTap: () {
                  bottomAppBarBloc.dispatch(BottomAppBarAddProducts());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Applications'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
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
                  label: const Text('Add a task'),
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
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  authenticationBloc.dispatch(LoggedOut());
                },
              )
            ],
          ),
        ),
        body: BlocProvider(
          bloc: productsBloc,
          child: MaterialApp(
            title: 'Open Copyright Platform',
            theme: ThemeData.light(),
            home: BlocBuilder<ProductsEvent, ProductsState>(
              bloc: productsBloc,
              builder: (BuildContext context, ProductsState state) {
                if (state is AuthenticationUnauthenticated) {
                  //return LoginPage(userRepository: _userRepository);
                }
              },
            ),
          ),
        ));
  }
}
