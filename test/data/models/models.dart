import 'package:kyrylo_kaun_test_task/data/models/launch_models.dart';

final LaunchModelsList mockLaunchesPage = LaunchModelsList(
    list: List<int>.generate(10, (i) => i + 1)
        .map((e) => LaunchModel(missionName: 'CRS-$e', details: 'Mission details $e'))
        .toList());
