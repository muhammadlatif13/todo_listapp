import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_listapp/app/config/global/init.dart';
import 'package:todo_listapp/app/config/router/router.dart';
import 'package:todo_listapp/app/utils/constants/routes.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppRouter.allBlocProviders()],
      child: MaterialApp(
        title: 'To-Do App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          useMaterial3: true,
        ),
        initialRoute: Routes.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
