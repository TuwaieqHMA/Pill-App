import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/pages/bottom_nav_bar/bottom_nav_bar_page.dart';
import 'package:pill_app/pages/home_page.dart';
import 'package:pill_app/pages/login_page.dart';
import 'package:pill_app/pages/start_page.dart';
import 'package:pill_app/utils/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setupDatabase();
  await setup();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavBarPage(),
        // HomePage(),
      )
    );
  }
}
