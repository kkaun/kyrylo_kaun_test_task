# kyrylo_kaun_test_task

Test task for TLVGenerator

## Set Up 

- Please ensure that your Flutter version supports null-safety before running/testing the project.
- For running the app and unit/BLoC tests, please use the config provided in .vscode/launch.json or create the own one.

## Candidate/tech comments:

- The task's app structure is done with Domain-Driven Design, Clean Code and TDD principles in mind (with respect to simplistic/KISS appraches where affordable and considering the fact that it's a test task with minimal fictionality and no further scaling).
- Though I could use more verbose (or independent) approaches for implementing such concepts as custom BLoC for state management or custom GraphQL client instead of common solutions from pub.dev, I declined re-inventing the wheel for that particular case to match mine and others' affordable timing frames.
- Despite the fact that I used an idiomatic GraphQL API which implies the usage of specific widgets for queries/mutations' UI integration, I managed to pass and adapt all client logic to data/datasource layer to comply and simplify DDD and TDD principles.

## Task explication:

An explication of points which I covered (+) and which didn't (-) with comments which might help to get into actual project functionality in minimal time.

Fundamental points:

•	The user must be able to type a text to search into the SpaceX missions: +

•	The search must be done by calling the GraphQL query "launches" filtering by the “mission_name” field exposed by this public backend: https://api.spacex.land/graphql/ : +

•	The user should see, as a result of the performed search, a list of items composed by the ***mission_name*** and ***details*** fields as returned by the server: +

•	The search should start only for search text longer than 3 characters: +

•	A reviewer should be able to download the project, install and launch it by reading the README file: +

Extra points:

•	Use bloc and repo pattern (P of EAA: Repository (martinfowler.com)) (2 points): +

•	Cover the project with bloc tests and unit tests (2 points): +

•	Use plain change notifier provider (1 point): - 

*Taking in mind that I chose BLoC as full-fledged state management solution, I don't see any reasonable sense in using plain old provider for any of UX/use-cases which could've been imagined for this particular task.
The only one I can imagine is that one could've use it for search input listening, smth like:*
```
//...
return ChangeNotifierProvider(
    create: (context) => Input(''),
    child: Consumer<Input>(
        builder: (context, input, child) {
        if (input.text.length > 3) {
            _bloc.add(SearchLaunchesEvent(textFragment: input.text));
        }
//...
Provider.of<Input>(context, listen: false).clear();
//...
Provider.of<Input>(context, listen: false).edit(value);
//...
```
*, but I used more simplistic void function callbacks from separated search stateful widget for that particular case.*

•	Paginated list of 10 items each: - 

*If I had more free time, I'd gladly implement this one (f.e. with inner BLoC/Cubit pagination logic). In the future talks I'd gladly discuss the details of possible approach which dev could use here.*