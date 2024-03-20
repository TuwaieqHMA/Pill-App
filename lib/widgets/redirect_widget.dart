import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/bottom_nav_bar/bottom_nav_bar_page.dart';
import 'package:pill_app/pages/start_page.dart';

class RedirectWidget extends StatelessWidget {
  const RedirectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RedirectUserState){
          (state.session != null) ? context.push(const BottomNavBarPage(), false) : context.push( const StartPage(), false);
        }
      },
      child: Container(),
    );
  }
}