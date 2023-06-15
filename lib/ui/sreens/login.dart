import 'package:dio/dio.dart';
import 'package:fermer/core/auth/auth_manager.dart';
import 'package:fermer/ui/kit/colors.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dio = Dio();

  var _mailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 32, 51, 0.16),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
              BoxShadow(
                color: Color.fromRGBO(0, 32, 51, 0.02),
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ]),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(130, 30, 130, 0),
                    child: Image.asset('assets/icons/icon.png', height: 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                    child: Text(
                      'Авторизация',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 35, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Почта пользователя',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: TextFormField(
                                controller: _mailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Пожалуйста, введите почту';
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return 'Пожалуйста, введите корректную почту';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: const Color.fromRGBO(
                                              0, 32, 51, 0.35)),
                                  hintText: 'hello@test.ru',
                                ),
                                onSaved: (newValue) =>
                                    _mailController.text = newValue!,
                              )),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 35, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Пароль',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Пожалуйста, введите пароль';
                              } else if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(value)) {
                                return 'Пароль должен быть не менее 8 символов, содержать цифры, заглавные и строчные буквы, а также спецсимволы';
                              }
                              return null;
                            },
                            onSaved: (newValue) =>
                                _passwordController.text = newValue!,
                            decoration: InputDecoration(
                                errorMaxLines: 2,
                                hintText: '*********',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: const Color.fromRGBO(
                                            0, 32, 51, 0.35))),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text(
                      "Еще нет аккаунта? Зарегистрируйся",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 30, 35, 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.deepGreen,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.2,
                            MediaQuery.of(context).size.height * 0.04),
                      ),
                      onPressed: () async {
                        try {
                          if (_formKey.currentState!.validate()) {
                            var response = await AuthorizationManager()
                                .authorize(_mailController.text,
                                    _passwordController.text);
                            if (response.isAuthorized == true) {
                              if (response.type=="BY"){
                                Navigator.pushNamed(context, '/');
                              }
                              else if (response.type=="FM"){
                                Navigator.pushNamed(context, '/fermer');
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: CustomColors.deepGreen,
                                  content:
                                      Text(response.errorMessage ?? 'Ошибка', style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white)),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Войти',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ])));
  }
}
