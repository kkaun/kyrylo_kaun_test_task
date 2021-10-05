import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyrylo_kaun_test_task/data/datasources/spacex_remote_datasource.dart';
import 'package:kyrylo_kaun_test_task/data/models/launch_models.dart';
import 'package:kyrylo_kaun_test_task/data/repositories/mission_repository_impl.dart';
import 'package:kyrylo_kaun_test_task/presentation/bloc/launches_bloc.dart';
import 'package:kyrylo_kaun_test_task/presentation/screens/widgets/search_field.dart';

class LaunchesScreen extends StatefulWidget {
  const LaunchesScreen({Key? key}) : super(key: key);

  @override
  _LaunchesScreenState createState() => _LaunchesScreenState();
}

class _LaunchesScreenState extends State<LaunchesScreen> {
  late LaunchesBloc _bloc;

  @override
  void initState() {
    _bloc = LaunchesBloc(missionRepository: MissionRepositoryImpl(remoteDataSource: SpaceXRemoteDatasourceImpl()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _buildSearchBarSection(),
        ),
        body: BlocProvider<LaunchesBloc>(
            create: (_) => _bloc,
            child: BlocBuilder<LaunchesBloc, LaunchesState>(
              builder: (context, state) {
                if (state is LaunchesLoaded) {
                  return _buildContentSection(state);
                } else if (state is LaunchesError) {
                  return _buildInfo(text: state.errorMessage);
                } else if (state is LaunchesInitial) {
                  return _buildInfo();
                } else {
                  return _buildLoading();
                }
              },
            )));
  }

  Widget _buildContentSection(LaunchesLoaded state) {
    return state.page.launches.isEmpty
        ? _buildInfo(text: 'No launches found')
        : ListView.separated(
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(height: 1, color: Colors.black38),
                ),
            itemCount: state.page.launches.length,
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemBuilder: (context, index) {
              final LaunchModel launch = state.page.launches[index] as LaunchModel;
              return ListTile(
                title: Text(launch.missionName),
                subtitle: Text(launch.details),
              );
            });
  }

  Widget _buildSearchBarSection() {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: SearchField(
              key: const Key('search_field'),
              onEdit: (value) {
                _bloc.add(SearchLaunchesEvent(textFragment: value));
              },
              onClear: () {
                _bloc.add(SearchLaunchesEvent(textFragment: ''));
              }),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: SizedBox(height: 40, width: 40, child: CircularProgressIndicator()));
  }

  Widget _buildInfo({String text = ''}) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text.isEmpty ? 'Please enter mission name' : text,
        style: const TextStyle(fontSize: 22),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
