part of 'launches_bloc.dart';

@immutable
abstract class LaunchesState extends Equatable {}

class LaunchesInitial extends LaunchesState {
  @override
  List<Object?> get props => [];
}

class LaunchesLoading extends LaunchesState {
  @override
  List<Object?> get props => [];
}

class LaunchesLoaded extends LaunchesState {
  final LaunchList page;

  LaunchesLoaded({required this.page});

  @override
  List<Object?> get props => [page.launches.length];
}

class LaunchesError extends LaunchesState {
  final String errorMessage;

  LaunchesError({this.errorMessage = ''});

  @override
  List<Object?> get props => [errorMessage];
}

//TODO make GraphQL pagination