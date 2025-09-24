import 'package:flutter/material.dart';

extension ScaffoldExtension on Widget {
  Widget get simpleScaffold => Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: this),
            ],
          ),
        ),
      );

  Widget simpleScaffoldWithProps({
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
  }) =>
      Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: this),
            ],
          ),
        ),
      );

  Widget get emptyScaffold => Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: false,
          top: false,
          child: this,
        ),
      );
}
