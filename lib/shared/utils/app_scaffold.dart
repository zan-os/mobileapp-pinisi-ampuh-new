// ignore_for_file: unused_element

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp_pinisi_ampuh_new/core/constants/constant_dimension.dart';

import 'keyboard_spacing.dart';

class _AppScaffold extends Scaffold {
  const _AppScaffold({
    super.key,
    super.appBar,
    super.body,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    super.persistentFooterButtons,
    super.drawer,
    super.onDrawerChanged,
    super.endDrawer,
    super.onEndDrawerChanged,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.backgroundColor,
    super.resizeToAvoidBottomInset,
    super.primary = true,
    super.drawerDragStartBehavior = DragStartBehavior.start,
    super.extendBody = false,
    super.extendBodyBehindAppBar = false,
    super.drawerScrimColor,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture = true,
    super.endDrawerEnableOpenDragGesture = true,
    super.restorationId,
  });

  @override
  ScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ScaffoldState {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Material(
      child: Column(
        children: [
          Expanded(child: super.build(context)),
          if (_resizeToAvoidBottomInset)
            KeyboardSpacing(
              color:
                  widget.backgroundColor ?? themeData.scaffoldBackgroundColor,
            )
        ],
      ),
    );
  }

  bool get _resizeToAvoidBottomInset {
    return widget.resizeToAvoidBottomInset ?? true;
  }
}

class AppScaffold extends StatelessWidget {
  final Widget? title;
  final Widget? backButton;
  final Widget body;
  final Widget? bottomBody;
  final double? toolbarElevation;

  const AppScaffold({
    super.key,
    this.title,
    this.backButton,
    this.toolbarElevation,
    required this.body,
    this.bottomBody,
  });

  @override
  Widget build(BuildContext context) {
    return _AppScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: false,
      appBar: title != null
          ? AppBar(
              elevation: toolbarElevation ?? AppDimensions.spacingx,
              leading: backButton,
              automaticallyImplyLeading: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
              forceMaterialTransparency: true,
              title: title,
              bottomOpacity: 0.0,
            )
          : null,
      body: body,
      bottomNavigationBar: bottomBody,
    );
  }
}
