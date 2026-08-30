import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DScaffold extends StatelessWidget {
  const DScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.restorationId,
    this.padding = const EdgeInsets.all(16),
    this.dismissKeyboard = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;

  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  final List<Widget>? persistentFooterButtons;

  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;

  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;

  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;

  final Color? backgroundColor;

  final bool? resizeToAvoidBottomInset;
  final bool primary;

  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;

  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;

  final bool extendBody;
  final bool extendBodyBehindAppBar;

  final Color? drawerScrimColor;

  final String? restorationId;

  final EdgeInsetsGeometry padding;
  final bool dismissKeyboard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,

      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: dismissKeyboard ? () => FocusScope.of(context).unfocus() : null,
        child: Padding(padding: padding, child: body),
      ),

      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,

      persistentFooterButtons: persistentFooterButtons,

      drawer: drawer,
      onDrawerChanged: onDrawerChanged,

      endDrawer: endDrawer,
      onEndDrawerChanged: onEndDrawerChanged,

      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,

      backgroundColor: backgroundColor,

      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,

      drawerDragStartBehavior: drawerDragStartBehavior,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,

      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,

      drawerScrimColor: drawerScrimColor,

      restorationId: restorationId,
    );
  }
}
