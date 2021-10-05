import 'package:flutter_test/flutter_test.dart';
import 'package:kyrylo_kaun_test_task/core/constants.dart';
import 'package:kyrylo_kaun_test_task/presentation/bloc/launches_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../core/constants.dart';
import '../../data/models/models.dart';
import '../../data/repositories/mission_repository_impl.dart';
import '../../domain/repositories/mission_repository.dart';

void main() {
  group('LaunchesBloc', () {
    late LaunchesBloc bloc;
    late MockMissionRepository mockMissionRepository;

    setUp(() {
      mockMissionRepository = MockMissionRepositoryImpl();
      bloc = LaunchesBloc(missionRepository: mockMissionRepository);
    });

    blocTest<LaunchesBloc, LaunchesState>('''emits [LaunchesLoading, LaunchesLoaded] states 
      for valid search input and successful search''',
        build: () => bloc,
        act: (bloc) => bloc.add(SearchLaunchesEvent(textFragment: tValidSearchFragment)),
        expect: () => [LaunchesLoading(), LaunchesLoaded(page: mockLaunchesPage)]);

    blocTest<LaunchesBloc, LaunchesState>('''throws [AssertionError] and emits 
      [LaunchesLoading, LaunchesError] on invalid(short) input''',
        build: () => bloc,
        act: (bloc) => bloc.add(SearchLaunchesEvent(textFragment: tInValidSearchFragment)),
        expect: () => [LaunchesLoading(), LaunchesError(errorMessage: invalidInputErrorDescr)]);

    tearDown(() {
      bloc.close();
    });
  });
}
