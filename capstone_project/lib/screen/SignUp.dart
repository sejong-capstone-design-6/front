import 'package:capstone_project/model/signUpDto.dart';
import 'package:capstone_project/network/auth_service.dart';
import 'package:capstone_project/screen/Login.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<SignUp> {
  TextEditingController Emailinput = TextEditingController();
  TextEditingController Passwordinput = TextEditingController();
  bool _isAgreed = false;
  String email = "";
  String password = "";

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
            child: Form(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 48.0,
                  ),
                  Container(
                    height: 38.0,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(9.0, 0.0, 9.0, 0.0),
                    padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 2.0),
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
                    child: TextFormField(
                      onSaved: (value) async {
                        email = value!;
                      },
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 38.0,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(9.0, 0.0, 9.0, 0.0),
                    padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 2.0),
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
                    child: TextFormField(
                      onSaved: (value) async {
                        password = value!;
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 48.0,
                  ),
                  Container(
                    height: 18.0,
                    margin: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          value: _isAgreed,
                          onChanged: ((value) {
                            setState(() {
                              _isAgreed = value!;
                            });
                          }),
                          activeColor: const Color.fromARGB(255, 0, 125, 167),
                          checkColor: Colors.white,
                        ),
                        const Text(
                          "이용약관 동의",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 24.0,
                  ),
                  Container(
                    height: 56.0,
                    margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 0.0),
                    padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _isAgreed
                          ? () async {
                              if (email.isEmpty) {
                                showSnackEmailEmpty(context);
                              } else if (password.isEmpty) {
                                showSnackPasswordEmpty(context);
                              } else if (!EmailValidator.validate(
                                  email.toString())) {
                                showSnackEmailValidate(context);
                              } else {
                                dynamic statusCode = await authSercive
                                    .signUp(SignUpDto(email, password));
                                if (statusCode != 201) {
                                  showSnackDeny(context);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                }
                              }
                            }
                          : null,
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
          ),
        );
      }),
    );
  }
}

void showSnackDeny(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text(
      '문제가 발생했습니다.',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}

void showSnackEmailValidate(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text(
      '이메일 형식을 맞춰주세요.',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}

void showSnackEmailEmpty(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text(
      '이메일을 입력해주세요.',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}

void showSnackPasswordEmpty(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text(
      '비밀번호를 입력해주세요..',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}
