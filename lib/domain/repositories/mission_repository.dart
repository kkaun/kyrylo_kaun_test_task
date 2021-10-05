import 'package:dartz/dartz.dart';
import 'package:kyrylo_kaun_test_task/core/errors/failures.dart';
import 'package:kyrylo_kaun_test_task/domain/entites/launch_entities.dart';

abstract class MissionRepository {
  Future<Either<Failure, LaunchList>> searchForLaunches({required String missionNameFragment});
}
