import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kyrylo_kaun_test_task/core/services/graphql_service.dart';
import 'package:kyrylo_kaun_test_task/data/models/launch_models.dart';
import 'package:kyrylo_kaun_test_task/domain/entites/launch_entities.dart';

abstract class SpaceXRemoteDatasource {
  /// Throws a [ServerException] for all response errors for the sake of simplicity.
  Future<LaunchList> searchForLaunches({required String missionNameFragment});
}

class SpaceXRemoteDatasourceImpl implements SpaceXRemoteDatasource {
  final GraphQLService client = GraphQLService();

  SpaceXRemoteDatasourceImpl();

  @override
  Future<LaunchModelsList> searchForLaunches({required String missionNameFragment}) async {
    final result = await client.performQuery('''
          {
            launches(find: {mission_name: "$missionNameFragment"}) {
              mission_name
              details
            }
          }
        ''');
    if (result.hasException) throw const ServerException();
    return LaunchModelsList.fromMap(result.data!);
  }
}
