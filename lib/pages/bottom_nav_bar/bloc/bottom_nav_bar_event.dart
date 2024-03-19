part of 'bottom_nav_bar_bloc.dart';

@immutable
sealed class BottomNavBarEvent {}

class ChangeNavEvent extends BottomNavBarEvent {
  final int index; 
  ChangeNavEvent({required this.index});
}