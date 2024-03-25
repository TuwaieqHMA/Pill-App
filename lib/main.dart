import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/bloc/chat_bloc.dart';
import 'package:pill_app/bloc/medication_bloc.dart';
import 'package:pill_app/utils/setup.dart';
import 'package:pill_app/widgets/redirect_widget.dart';

//test
// Import other BLoCs as needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFireBase();
  await setupDatabase();
  await setup();

  // var cron = Cron();
  // cron.schedule(Schedule.parse('0 0 * * *'), () async {
  //   // context.read<MedicationBloc>().add();
  //   //   print('every three minutes ${DateTime.now()}');
  //   //   await DBService().dailyUpdate();
  //   //   print('every three minutes ${DateTime.now()}');
  // });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key ?key});

  @override
  Widget build(BuildContext context) {
    dailyUpdate() {
      context.read<MedicationBloc>().add(ShowUserMedicationsEvent());
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc()..add(CheckSessionAvailabilityEvent()),
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
        home:
        RedirectWidget(),
      ),
    );
  }
}
