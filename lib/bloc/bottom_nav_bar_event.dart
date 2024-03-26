part of 'bottom_nav_bar_bloc.dart';


sealed class BottomNavBarEvent {}

class ChangeNavEvent extends BottomNavBarEvent {
  final int index; 
  ChangeNavEvent({required this.index});
}