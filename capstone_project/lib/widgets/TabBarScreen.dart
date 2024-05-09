import 'package:capstone_project/screen/Scenario.dart';
import 'package:capstone_project/services/api_service.dart';
import 'package:capstone_project/widgets/MovieCard.dart';
import 'package:capstone_project/widgets/ScenarioCard.dart';
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
      height: 600,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            _tabBar(),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  ScenarioTab(scenarios: scenarios),
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
  final List<String> scenarios;

  const ScenarioTab({super.key, required this.scenarios});

  @override
  _ScenarioTabState createState() => _ScenarioTabState();
}

class _ScenarioTabState extends State<ScenarioTab> {
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
      body: GridView.builder(
        itemCount: widget.scenarios.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Card(
              color: Colors.grey.withOpacity(0.2),
              child: ListTile(
                title: Text(
                  widget.scenarios[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddScenarioModal(BuildContext context) {
    String mode = '연기'; // 초기 선택값
    String title = ''; // 초기 제목값

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                  title = value;
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
              onPressed: () {
                setState(() {
                  widget.scenarios.add(title);
                  ApiService().postScenario(mode, title);
                });
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Scenario()));
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
