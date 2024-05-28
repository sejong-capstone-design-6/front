import 'package:capstone_project/component/ScenarioModel.dart';
import 'package:capstone_project/model/bringMovieDto.dart';
import 'package:capstone_project/network/movie_scenario_service.dart';
import 'package:capstone_project/screen/MyScenarioPage.dart';
import 'package:capstone_project/services/api_service.dart';
import 'package:capstone_project/component/MovieCard.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,

    /// 탭 변경 애니메이션 시간
    animationDuration: const Duration(milliseconds: 800),
  );

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  late BringMovieDto movies;
  late ScenarioList scenarioss;

  late BringMovieDto movieToUse;
  late ScenarioList scenarioListToUse;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
    fetchScenarios();
  }

  Future<void> fetchScenarios() async {
    ScenarioList fetchedScenarios = await ApiService().getMyScenarios();

    setState(() {
      scenarioss = fetchedScenarios;
      scenarioListToUse = scenarioss.deepCopy();
      isLoading = false;
    });
  }

  Future<void> fetchMovies() async {
    BringMovieDto dto = await movieScenarioService.bringScenario();

    setState(() {
      movies = dto;
      movieToUse = dto.deepCopy();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Expanded(
            child: Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Column(
                  children: [
                    TabBar(
                      controller: tabController,
                      labelColor: Colors.white,
                      labelStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(text: "My"),
                        Tab(text: "Movie"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 14),
                      child: SearchBar(
                        hintText: 'Search',
                        constraints: BoxConstraints(minHeight: 36),
                        leading: Icon(
                          Icons.search,
                          color: Color(0xff636366),
                        ),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xff1C1C1E)),
                        onChanged: (value) {
                          Logger().d(value);
                          setState(() {
                            if (value != "") {
                              // 조건에 맞는 새로운 리스트를 생성
                              List<ScenarioModel> filteredScenarios = scenarioss
                                  .scenarios
                                  .where((element) =>
                                      element.title.contains(value))
                                  .toList();

                              // scenarioListToUse의 scenarios를 filteredScenarios로 설정
                              scenarioListToUse.scenarios =
                                  List.from(filteredScenarios);

                              List<Scenario> filterdMovieSentence = movies
                                  .scenarios
                                  .where((element) =>
                                      element.title.contains((value)))
                                  .toList();

                              movieToUse.scenarios =
                                  List.from(filterdMovieSentence);

                                  Logger().d(movieToUse);
                                  Logger().d(movies);
                            } else {
                              movieToUse = movies.deepCopy();
                              scenarioListToUse = scenarioss.deepCopy();
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ScenarioTab(
                        scenarioss: scenarioListToUse,
                      ),
                      MovieTab(
                        movies: movieToUse,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ));
  }
}

class MovieTab extends StatefulWidget {
  final BringMovieDto movies;
  MovieTab({super.key, required this.movies});

  @override
  _MovieTab createState() => _MovieTab();
}

class _MovieTab extends State<MovieTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: widget.movies.scenarios.length,
            itemBuilder: (context, index) {
              return MovieCard(
                id: widget.movies.scenarios[index].id,
                title: widget.movies.scenarios[index].title,
                movie: widget.movies.scenarios[index].movie,
                url: widget.movies.scenarios[index].thumbnailUrl,
              );
            }));
  }
}

class ScenarioTab extends StatefulWidget {
  final ScenarioList scenarioss;

  ScenarioTab({super.key, required this.scenarioss});

  @override
  _ScenarioTabState createState() => _ScenarioTabState();
}

class _ScenarioTabState extends State<ScenarioTab> {
  late ScenarioList scenarioss;

  Future<void> fetchScenarios() async {
    ScenarioList fetchedScenarios = await ApiService().getMyScenarios();

    setState(() {
      scenarioss = fetchedScenarios;
    });
  }

  @override
  Widget build(BuildContext context) {
    scenarioss = widget.scenarioss;

    return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          onPressed: () {
            _showAddScenarioModal(context);
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: (widget.scenarioss.scenarios.length / 2).ceil(),
            itemBuilder: (context, index) {
              final int firstItemIndex = index * 2;
              final int secondItemIndex = firstItemIndex + 1;

              return Center(
                child: Wrap(
                  spacing: 14,
                  runSpacing: 8,
                  children: [
                    ScenarioModel(
                      id: widget.scenarioss.scenarios[firstItemIndex].id,
                      title: widget.scenarioss.scenarios[firstItemIndex].title,
                      sentence:
                          widget.scenarioss.scenarios[firstItemIndex].sentence,
                      type: widget.scenarioss.scenarios[firstItemIndex].type,
                    ),
                    if (secondItemIndex < widget.scenarioss.scenarios.length)
                      ScenarioModel(
                        id: widget.scenarioss.scenarios[secondItemIndex].id,
                        title:
                            widget.scenarioss.scenarios[secondItemIndex].title,
                        sentence: widget
                            .scenarioss.scenarios[secondItemIndex].sentence,
                        type: widget.scenarioss.scenarios[secondItemIndex].type,
                      ),
                  ],
                ),
              );
            }));
  }

  void _showAddScenarioModal(BuildContext context) {
    String mode = '연기'; // 초기 선택값
    String title = ''; // 초기 제목값
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Scenario'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: mode,
                    items: ['연기', '스피치'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        mode = value!;
                      });
                    },
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: '제목'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    int scenarioId =
                        await ApiService().postScenario(mode, title);
                    await fetchScenarios();
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyScenarioPage(scenarioId: scenarioId)));
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
