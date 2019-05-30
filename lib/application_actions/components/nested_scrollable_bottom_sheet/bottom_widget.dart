import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/application_actions/index.dart';

import 'inner_list.dart';

const _persistantBottomSheetHeaderHeight = 30.0;

class BottomWidget extends StatefulWidget {
  final double fullSizeHeight;
  final ApplicationActionsBloc applicationActionsBloc;

  BottomWidget(
      {@required this.fullSizeHeight, @required this.applicationActionsBloc});

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  //start drag position of widget's gesture detector
  Offset startPosition;

  ApplicationActionsBloc get _applicationActionsBloc =>
      widget.applicationActionsBloc;

  //offset from startPosition within drag event of widget's gesture detector
  double dyOffset;

  //boundaries for height of widget (bottom sheet)
  List<double> heights;

  //current height of widget (bottom sheet)
  double height;

  //ScrollController for inner ListView
  ScrollController innerListScrollController;

  //is user scrolling down inner ListView
  bool isInnerScrollDoingDown;

  @override
  void initState() {
    super.initState();

    heights = [
      _persistantBottomSheetHeaderHeight,
      widget.fullSizeHeight / 2,
      widget.fullSizeHeight
    ];
    height = heights[0];

    //initialize inner list's scroll controller and listen to its changes
    innerListScrollController = ScrollController();
    innerListScrollController.addListener(_scrollOffsetChanged);
    isInnerScrollDoingDown = false;

    dyOffset = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    //GestureDetector can catch drag events only if inner ListView isn't scrollable (only if _getScrollEnabled() returns false)
    return GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails dragDetails) =>
            dyOffset += dragDetails.delta.dy,
        onVerticalDragStart: (DragStartDetails dragDetails) {
          startPosition = dragDetails.globalPosition;
          dyOffset = 0;
        },
        onVerticalDragEnd: (DragEndDetails dragDetails) => _changeHeight(),
        child: BlocProvider(
            bloc: _applicationActionsBloc,
            child: BlocBuilder(
                bloc: _applicationActionsBloc,
                builder: (BuildContext context, ApplicationActionsState state) {
                  if (state is BottomSelectUninitialized) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is BottomSelectError) {
                    return Center(
                        child: Center(child: Text('Failed to fetch products')));
                  }
                  if (state is BottomSelectLoaded) {
                    return Container(
                      color: Theme.of(context).appBarTheme.color,
                      child: InnerList(
                        products: state.products,
                        scrollEnabled: _getInnerScrollEnabled(),
                        listViewScrollController: innerListScrollController,
                      ),
                    );
                  }
                  if (state is ProductSelected) {
                    return Center(
                        child: Center(child: Text('Now swipe this down')));
                  }
                })));
  }

  //returns if inner ListView scroll is enabled
  //true if:
  // 1) container's height is height of entire screen
  // 2) inner ListView has not been scrolled down from first element
  bool _getInnerScrollEnabled() {
    bool isFullSize = heights.last == height;
    bool isScrollZeroOffset = innerListScrollController.hasClients
        ? innerListScrollController.offset == 0.0 && isInnerScrollDoingDown
        : false;
    bool result = isFullSize && !isScrollZeroOffset;

    //reset isInnerScrollDoingDown
    if (!result) isInnerScrollDoingDown = false;
    return result;
  }

  void _scrollOffsetChanged() {
    if (innerListScrollController.offset < 0.0) {
      isInnerScrollDoingDown = true;
    } else if (innerListScrollController.offset > 0.0) {
      isInnerScrollDoingDown = false;
    }

    if (innerListScrollController.offset <= 0.0) {
      setState(() {});
    }
  }

  void _changeHeight() {
    if (dyOffset < 0) {
      setState(() {
        int curIndex = heights.indexOf(height);
        int newIndex = curIndex + 1;
        height =
            newIndex >= heights.length ? heights[curIndex] : heights[newIndex];
      });
    } else if (dyOffset > 0) {
      setState(() {
        int curIndex = heights.indexOf(height);
        int newIndex = curIndex - 1;
        height = newIndex < 0 ? heights[curIndex] : heights[newIndex];
      });
    }
  }

  @override
  void dispose() {
    innerListScrollController.removeListener(_scrollOffsetChanged);

    super.dispose();
  }
}
