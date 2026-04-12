import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/widgets/notifications/app_flush_bar.dart';
import '../../presentation/widgets/dialogs/app_dialog.dart';

abstract class BaseNavigator {
  final BuildContext context;

  const BaseNavigator(this.context);

  /// Truy cập vào các loại Dialog của App
  AppDialog get dialog => AppDialog(context);

  /// Truy cập vào các loại thông báo của App
  AppFlushBar get notify => AppFlushBar(context);

  void safePop() {
    if (context.canPop()) {
      context.pop();
    }
  }

  void go(String path, {Object? extra}) {
    context.go(path, extra: extra);
  }

  void goNamed(String name, {Object? extra}) {
    context.goNamed(name, extra: extra);
  }

  void push(String path, {Object? extra}) {
    context.push(path, extra: extra);
  }

  void pushNamed(String name, {Object? extra}) {
    context.pushNamed(name, extra: extra);
  }

  void replace(String path, {Object? extra}) {
    context.replace(path, extra: extra);
  }

  void replaceNamed(String name, {Object? extra}) {
    context.replaceNamed(name, extra: extra);
  }
}
