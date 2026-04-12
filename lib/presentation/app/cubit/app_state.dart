part of 'app_cubit.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class Authenticated extends AppState {
  final String userId;
  Authenticated(this.userId);
}

class Unauthenticated extends AppState {}
