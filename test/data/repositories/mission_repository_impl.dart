import 'package:kyrylo_kaun_test_task/data/models/launch_models.dart';
import 'package:kyrylo_kaun_test_task/domain/entites/launch_entities.dart';
import 'package:kyrylo_kaun_test_task/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kyrylo_kaun_test_task/domain/repositories/mission_repository.dart';
import '../../domain/repositories/mission_repository.dart';
import '../models/models.dart';

class MockMissionRepositoryImpl extends MockMissionRepository implements MissionRepository {
  @override
  Future<Either<Failure, LaunchList>> searchForLaunches({required String missionNameFragment}) async {
    try {
      assert(missionNameFragment.length > 3);
      return Right(LaunchModelsList(list: mockLaunchesPage.list));
    } on AssertionError {
      return Left(Failure(errorText: 'Mission name fragment length must be bigger than 3 to perform search!'));
    }
  }
}
