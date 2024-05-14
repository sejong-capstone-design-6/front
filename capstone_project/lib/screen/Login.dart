import 'package:capstone_project/model/logInDto.dart';
import 'package:capstone_project/MainPage.dart';
import 'package:capstone_project/network/auth_service.dart';
import 'package:capstone_project/screen/MyScenarioPage.dart';
import 'package:capstone_project/screen/SignUp.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController Emailinput = TextEditingController();
  TextEditingController Passwordinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120.0,
        title: const Text(
          "마음의\n       소리",
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
        titleSpacing: 16.0,
      ),
      body: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 48.0,
                ),
                Container(
                  height: 38.0,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(9.0, 0.0, 9.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: const Text(
                    "Email",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Container(
                  height: 44.0,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(9.0, 0.0, 9.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: TextField(
                    controller: Emailinput,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(50, 255, 255, 255),
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(50, 255, 255, 255),
                          )),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  height: 38.0,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(9.0, 0.0, 9.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: const Text(
                    "Password",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Container(
                  height: 44.0,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(9.0, 0.0, 9.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: TextField(
                    controller: Passwordinput,
                    obscureText: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(50, 255, 255, 255),
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(50, 255, 255, 255),
                          )),
                    ),
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  height: 48.0,
                ),
                Container(
                  height: 56.0,
                  margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      dynamic statusCode = await authSercive
                          .logIn(LogInDto(Emailinput.text, Passwordinput.text));
                      if (Emailinput.text.isEmpty == false &&
                          Passwordinput.text.isEmpty == false &&
                          statusCode == 201) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    //MyScenarioPage(scenarioId: 1)));
                                    MainPage()));
                      } else if (Emailinput.text.isEmpty == true) {
                        showSnackEmailinput(context);
                      } else if (Passwordinput.text.isEmpty == true) {
                        showSnackPw(context);
                      } else {
                        showSnackError(context);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        side: const BorderSide(
                            color: Color.fromARGB(50, 255, 255, 255))),
                    child: const Text(
                      "로그인",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ),
                Container(
                  height: 56.0,
                  margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        side: const BorderSide(
                            color: Color.fromARGB(50, 255, 255, 255))),
                    child: const Text(
                      "회원가입",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

void showSnackEmailinput(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text(
      '이메일을 입력하세요',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}

void showSnackPw(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text(
      '비밀번호를 입력하세요',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}

void showSnackError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text(
      '로그인 에러',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}
