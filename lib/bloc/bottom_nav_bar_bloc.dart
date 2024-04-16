import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  final serviceLocator = GetIt.I.get<HomeData>();

  BottomNavBarBloc() : super(BottomNavBarInitial()) {
    on<BottomNavBarEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeNavEvent>(changeNavMethod);
  }

  FutureOr<void> changeNavMethod(
      ChangeNavEvent event, Emitter<BottomNavBarState> emit) {
    serviceLocator.selectedPage = event.index;
    emit(SuccessChangeNavState());
  }
}
