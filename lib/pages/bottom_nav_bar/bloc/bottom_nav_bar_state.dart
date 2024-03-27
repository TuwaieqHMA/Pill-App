part of 'bottom_nav_bar_bloc.dart';

@immutable
sealed class BottomNavBarState {}

final class BottomNavBarInitial extends BottomNavBarState {}

final class SuccessChangeNavState extends BottomNavBarState {}
class ConnectedState extends BottomNavBarState {
  final String message;
  ConnectedState({required this.message});
}

class DisconnectedState extends BottomNavBarState {
    final String message;
  DisconnectedState({required this.message});}