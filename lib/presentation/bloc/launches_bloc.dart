import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kyrylo_kaun_test_task/domain/entites/launch_entities.dart';
import 'package:kyrylo_kaun_test_task/domain/repositories/mission_repository.dart';
import 'package:meta/meta.dart';

part 'launches_event.dart';
part 'launches_state.dart';

class LaunchesBloc extends Bloc<LaunchesEvent, LaunchesState> {
  final MissionRepository missionRepository;

  LaunchesBloc({required this.missionRepository}) : super(LaunchesInitial()) {
    on<LaunchesEvent>((event, emit) async {
      if (event is SearchLaunchesEvent) {
        emit(LaunchesLoading());
        final searchResult = await missionRepository.searchForLaunches(missionNameFragment: event.textFragment);
        searchResult.fold(
          (failure) {
            emit(LaunchesError(errorMessage: failure.errorText));
          },
          (data) {
            emit(LaunchesLoaded(page: data));
          },
        );
      }
    });
  }
}
