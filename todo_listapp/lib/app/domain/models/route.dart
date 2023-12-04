import 'package:flutter/material.dart';

class AppRoute {
  String route;
  Widget view;
  dynamic bloc;
  AppRoute({
    required this.route,
    required this.view,
    required this.bloc,
  });
}