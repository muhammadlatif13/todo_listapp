// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_listapp/app/domain/models/route.dart';
import 'package:todo_listapp/app/presentation/views/addtasks/addtasks.dart';
import 'package:todo_listapp/app/presentation/views/addtasks/bloc/addtasks_bloc.dart';
import 'package:todo_listapp/app/presentation/views/error/route_not_found_page.dart';
import 'package:todo_listapp/app/presentation/views/home/bloc/home_bloc.dart';
import 'package:todo_listapp/app/presentation/views/home/home.dart';
import 'package:todo_listapp/app/utils/constants/routes.dart';

class AppRouter {
  static List<AppRoute> routes() => [
        AppRoute(
          route: Routes.home,
          view: const HomePage(),
          bloc: BlocProvider(
            create: (context) => HomeBloc(),
          ),
        ),
        AppRoute(
          route: Routes.addTasks,
          view: const AddTaskPage(),
          bloc: BlocProvider(
            create: (context) => AddtasksBloc(),
          ),
        ),
      ];

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    if (settings.name != null) {
      var results = routes().where((element) => element.route == settings.name);
      if (results.isNotEmpty) {
        return MaterialPageRoute(builder: (context) => results.first.view);
      }
    }
    return MaterialPageRoute(builder: (context) => const RouteNotFound());
  }

  static allBlocProviders() {
    var blocProviders = [];
    for (var i in routes()) {
      blocProviders.add(i.bloc);
    }
    return blocProviders;
  }
}
