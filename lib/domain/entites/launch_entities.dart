import 'package:equatable/equatable.dart';

class LaunchList {
  final List<Launch> launches;

  LaunchList({required this.launches});
}

class Launch extends Equatable {
  final String missionName;
  final String details;

  const Launch({required this.missionName, required this.details});

  @override
  List<Object?> get props => [missionName, details];
}
