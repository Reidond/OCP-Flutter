import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:open_copyright_platform/auth/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ApplicationsQuickSearch extends StatelessWidget {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final BottomAppBarBloc bottomAppBarBloc =
        BlocProvider.of<BottomAppBarBloc>(context);

    final ApplicationsBloc applicationsBloc =
        BlocProvider.of<ApplicationsBloc>(context);

    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    bottomAppBarBloc.dispatch(InitialBottomAppBar());

    return WillPopScope(
        onWillPop: () {
          bottomAppBarBloc.dispatch(ShowAddApplicationsFAB());
          applicationsBloc.dispatch(FetchApplications());
          Navigator.of(context).pop();
        },
        child: BlocProviderTree(
            blocProviders: [
              BlocProvider<ApplicationsBloc>(bloc: applicationsBloc),
              BlocProvider<BottomAppBarBloc>(bloc: bottomAppBarBloc),
              BlocProvider<AuthBloc>(bloc: authBloc),
            ],
            child: BlocBuilder(
              bloc: applicationsBloc,
              builder: (BuildContext context, ApplicationsState state) {
                if (state is ShowQuickSearch) {
                  return WebView(
                      initialUrl: state.url,
                      javascriptMode: JavascriptMode.unrestricted);
                } else {
                  return WebView(
                      initialUrl: 'http://ocp.zzz.com.ua',
                      javascriptMode: JavascriptMode.unrestricted);
                }
              },
            )));
  }
}
