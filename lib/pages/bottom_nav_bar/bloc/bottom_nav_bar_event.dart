part of 'bottom_nav_bar_bloc.dart';

@immutable
sealed class BottomNavBarEvent {}

class ChangeNavEvent extends BottomNavBarEvent {
  int index; 
  ChangeNavEvent({required this.index});
}