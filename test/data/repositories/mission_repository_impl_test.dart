import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kyrylo_kaun_test_task/data/datasources/spacex_remote_datasource.dart';
import 'package:kyrylo_kaun_test_task/data/repositories/mission_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../core/constants.dart';
import '../models/models.dart';
import 'mission_repository_impl_test.mocks.dart';

@GenerateMocks([SpaceXRemoteDatasource])
void main() {
  late MissionRepositoryImpl repository;
  late MockSpaceXRemoteDatasource mockRemoteDatasource;

  setUp(() {
    mockRemoteDatasource = MockSpaceXRemoteDatasource();
    repository = MissionRepositoryImpl(remoteDataSource: mockRemoteDatasource);
  });

  group('Remote API contracts', () {
    test('should return a remote data when the call to the remote data source is successful', () async {
      //arrange
      when(mockRemoteDatasource.searchForLaunches(missionNameFragment: tValidSearchFragment))
          .thenAnswer((_) async => mockLaunchesPage);
      //act
      final result = await repository.searchForLaunches(missionNameFragment: tValidSearchFragment);
      //assert
      verify(mockRemoteDatasource.searchForLaunches(missionNameFragment: tValidSearchFragment));
      expect(result, equals(Right(mockLaunchesPage)));
    });

    test('should return Left(failure) when the call to the remote data source is un_successful', () async {
      //arrange
      when(mockRemoteDatasource.searchForLaunches(missionNameFragment: tValidSearchFragment))
          .thenThrow(const ServerException());
      //act
      final result = await repository.searchForLaunches(missionNameFragment: tValidSearchFragment);
      //assert
      verify(mockRemoteDatasource.searchForLaunches(missionNameFragment: tValidSearchFragment));
      expect(result, isA<Left>());
    });
  });
}
