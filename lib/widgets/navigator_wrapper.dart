import 'package:flutter/material.dart';

class NavigatorWrapper<T> extends MaterialPageRoute<T> {
  NavigatorWrapper({
    required WidgetBuilder builder,
    required RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Add custom transition animations here
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // Add custom styling here
    return super.buildPage(context, animation, secondaryAnimation);
  }
}
