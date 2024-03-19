part of 'bottom_nav_bar_bloc.dart';

@immutable
sealed class BottomNavBarState {}

final class BottomNavBarInitial extends BottomNavBarState {}

final class SuccessChangeNavState extends BottomNavBarState {}
