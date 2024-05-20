import 'package:capstone_project/component/ScenarioModel.dart';
import 'package:capstone_project/model/bringMovieDto.dart';
import 'package:capstone_project/network/movie_scenario_service.dart';
import 'package:capstone_project/screen/MyScenarioPage.dart';
import 'package:capstone_project/services/api_service.dart';
import 'package:capstone_project/component/MovieCard.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _tabBar(),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [ScenarioTab(), MovieTab()],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _tabBar() {
    return Column(
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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
          child: SearchBar(
            hintText: 'Search',
            constraints: BoxConstraints(minHeight: 36),
            leading: Icon(Icons.search, color: Color(0xff636366),),
            backgroundColor: MaterialStatePropertyAll(Color(0xff1C1C1E)),
          ),
        ),
      ],
    );
  }
}

class MovieTab extends StatefulWidget {
  const MovieTab({super.key});

  @override
  _MovieTab createState() => _MovieTab();
}

class _MovieTab extends State<MovieTab> {
  late BringMovieDto movies;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    BringMovieDto dto = await movieScenarioService.bringScenario();

    setState(() {
      movies = dto;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: movies.scenarios.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    id: movies.scenarios[index].id,
                    title: movies.scenarios[index].title,
                    movie: movies.scenarios[index].movie,
                    url: movies.scenarios[index].thumbnailUrl,
                  );
                }));
  }
}

class ScenarioTab extends StatefulWidget {
  const ScenarioTab({super.key});

  @override
  _ScenarioTabState createState() => _ScenarioTabState();
}

class _ScenarioTabState extends State<ScenarioTab> {
  late ScenarioList scenarioss;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchScenarios();
  }

  Future<void> fetchScenarios() async {
    ScenarioList fetchedScenarios = await ApiService().getMyScenarios();

    setState(() {
      scenarioss = fetchedScenarios;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: (scenarioss.scenarios.length / 2).ceil(),
                itemBuilder: (context, index) {
                  final int firstItemIndex = index * 2;
                  final int secondItemIndex = firstItemIndex + 1;

                  return Center(
                    child: Wrap(
                      spacing: 14,
                      runSpacing: 8,
                      children: [
                        ScenarioModel(
                          id: scenarioss.scenarios[firstItemIndex].id,
                          title: scenarioss.scenarios[firstItemIndex].title,
                          sentence:
                              scenarioss.scenarios[firstItemIndex].sentence,
                          type: scenarioss.scenarios[firstItemIndex].type,
                        ),
                        if (secondItemIndex < scenarioss.scenarios.length)
                          ScenarioModel(
                            id: scenarioss.scenarios[secondItemIndex].id,
                            title: scenarioss.scenarios[secondItemIndex].title,
                            sentence:
                                scenarioss.scenarios[secondItemIndex].sentence,
                            type: scenarioss.scenarios[secondItemIndex].type,
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
