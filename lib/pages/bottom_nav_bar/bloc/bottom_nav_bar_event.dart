part of 'bottom_nav_bar_bloc.dart';

@immutable
sealed class BottomNavBarEvent {}

class ChangeNavEvent extends BottomNavBarEvent {
  final int index; 
  ChangeNavEvent({required this.index});
}
class ConnectivityChangedEvent extends BottomNavBarEvent {
  final bool isConnected;
  final String message;
  ConnectivityChangedEvent({required this.isConnected,required this.message});
}