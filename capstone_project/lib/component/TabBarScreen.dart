import 'package:capstone_project/component/ScenarioModel.dart';
import 'package:capstone_project/network/auth_service.dart';
import 'package:capstone_project/provider/data_provider.dart';
import 'package:capstone_project/screen/CreateScenarioPage.dart';
import 'package:capstone_project/screen/MyScenarioPage.dart';
import 'package:capstone_project/screen/Scenario.dart';
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
  List<String> scenarios = ['Scenario 1', 'Scenario 2', 'Scenario 3'];

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 576,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            _tabBar(),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  ScenarioTab(),
                  ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, idx) {
                        return MovieCard();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SearchBar(
            hintText: 'Search',
            constraints: BoxConstraints(minHeight: 50),
            leading: Icon(Icons.search),
            backgroundColor: MaterialStatePropertyAll(Colors.grey),
          ),
        ),
      ],
    );
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
          : GridView.builder(
              itemCount: scenarioss.scenarios.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: ScenarioModel(
                    id: scenarioss.scenarios[index].id,
                    title: scenarioss.scenarios[index].title,
                    type: scenarioss.scenarios[index].type,
                  ),
                );
              },
            ),
    );
  }

  void _showAddScenarioModal(BuildContext context) {
    String mode = '연기'; // 초기 선택값
    String title = ''; // 초기 제목값
    var scenarioId;
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
                    ApiService().postScenario(mode, title);
                    await fetchScenarios();
                    Navigator.of(context).pop();
                    /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyScenarioPage(scenarioId: authSercive.userId!)));*/
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
