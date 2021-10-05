part of 'launches_bloc.dart';

@immutable
abstract class LaunchesEvent extends Equatable {}

class SearchLaunchesEvent extends LaunchesEvent {
  final String textFragment;

  SearchLaunchesEvent({required this.textFragment});

  @override
  List<Object?> get props => [textFragment];
}
