import 'dart:async';

import 'package:seller/core/auth/bloc/authenticated.dart';
import 'package:sstream/sstream.dart';

import 'package:seller/core/auth/bloc/bloc_auth.dart';

import 'route_page.dart';

class RouteBloc extends Authenticated {
  // private constructor
  RouteBloc._() {
    _state();
  }
  // make singletone
  static final RouteBloc _instance = RouteBloc._();
  factory RouteBloc() {
    return _instance;
  }

  @override
  Future<void> onLogin() async {
    _pageController.add([RouteHome()]);
  }

  @override
  Future<void> onLogout() async {
    print(
        '================ROUTE==========================${_currentPages.length}');
    _currentPages.removeWhere((element) => element.name == RouteLogin().name);
    _currentPages.add(RouteLogin());
    _state();
    print(
        '================ROUTE==========================${_currentPages.length}');
  }

  _state() {
    _pageController.add(_currentPages);
    // print('================ROUTE==========================${_currentPages.length}');
  }

  final _auth = AuthBloc();
  final List<RoutePage> _currentPages =
      // List<RoutePage>.filled(1, RouteHome(), growable: true);
      List<RoutePage>.filled(1, RouteLogin(), growable: true);

  final _pageController = SStream<List<RoutePage>>([]);
  SStream<List<RoutePage>> get pages => _pageController; //state

  push(RoutePage page) {
    if (page.isProtected && !_auth.isAuthenticated) {
      _currentPages.add(RouteLogin());
      _state();
      return;
    }
    final latest = _pageController.value;
    latest.add(page);
    _pageController.add(latest);
  }

  bool pop() {
    final latest = _pageController.value;
    if (latest.length > 1) {
      latest.removeLast();
      _pageController.add(latest);
      return false;
    }
    return true;
  }

  popThenPush(RoutePage page) {
    pop();
    push(page);
  }

  backHome() {
    final latest = _pageController.value;
    latest.removeWhere((element) => element is! RouteHome);
    _pageController.add(latest);
  }
}
