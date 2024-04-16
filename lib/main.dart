import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/bloc/chat_bloc.dart';
import 'package:pill_app/bloc/medication_bloc.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/utils/setup.dart';
import 'package:pill_app/widgets/redirect_widget.dart';

import 'pages/disconnect_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  InternetConnection().onStatusChange.listen((status) async {
    if (status == InternetStatus.connected) {
      if (GetIt.I.get<HomeData>().isInitializeSupabase == false &&
          GetIt.I.get<HomeData>().isInitializeFierbase == false) {
        await setupFireBase();
        await setupDatabase();
      }
      runApp(const MainApp());
    } else {
      runApp(const Disconnect());
    }
  });
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc()..add(CheckSessionAvailabilityEvent()),
        ),
        BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => MedicationBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RedirectWidget(),
      ),
    );
  }
}
