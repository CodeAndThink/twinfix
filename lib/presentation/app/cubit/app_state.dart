part of 'app_cubit.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class Authenticated extends AppState {
  final String userId;
  final String? email;
  Authenticated(this.userId, {this.email});
}

class NeedSync extends AppState {
  final String userId;
  final String? email;
  NeedSync(this.userId, {this.email});
}

class Unauthenticated extends AppState {}
