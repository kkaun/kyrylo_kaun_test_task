import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kyrylo_kaun_test_task/core/constants.dart';
import 'package:kyrylo_kaun_test_task/data/datasources/spacex_remote_datasource.dart';
import 'package:kyrylo_kaun_test_task/core/errors/failures.dart';
import 'package:kyrylo_kaun_test_task/domain/entites/launch_entities.dart';
import 'package:kyrylo_kaun_test_task/domain/repositories/mission_repository.dart';

class MissionRepositoryImpl implements MissionRepository {
  final SpaceXRemoteDatasource remoteDataSource;

  MissionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LaunchList>> searchForLaunches({required String missionNameFragment}) async {
    try {
      assert(missionNameFragment.length > 3);
      final result = await remoteDataSource.searchForLaunches(missionNameFragment: missionNameFragment);
      return Right(result);
    } on ServerException {
      return Left(Failure(errorText: externalErrorShortDescr));
    } on AssertionError {
      return Left(Failure(errorText: invalidInputErrorDescr));
    }
  }
}
