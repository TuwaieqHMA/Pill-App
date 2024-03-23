import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/bloc/chat_bloc.dart';
import 'package:pill_app/utils/setup.dart';
import 'package:pill_app/widgets/redirect_widget.dart';


// Import other BLoCs as needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDatabase();
  await setup();

  runApp( MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key ?key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc()..add(CheckSessionAvailabilityEvent()),
        ),
        // Add more BlocProviders for other BLoCs as needed
       BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RedirectWidget(),
      ),
    );
  }
}
