import 'package:dio/dio.dart';
import 'package:fermer/core/auth/auth_manager.dart';
import 'package:fermer/ui/kit/colors.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

enum UserType { FM, BY, AD }

class _RegisterPageState extends State<RegisterPage> {
  final dio = Dio();

  var _nameController = TextEditingController();
  var _mailController = TextEditingController();
  var _passwordController = TextEditingController();
  UserType selectedUserType = UserType.BY;

  List<bool> isSelected = [false, true];

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
                      'Регистрация',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 35, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Имя',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: TextFormField(
                                controller: _nameController,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 2) {
                                    return 'Пожалуйста, введите имя';
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
                                  hintText: 'Иван',
                                ),
                                onSaved: (newValue) =>
                                    _nameController.text = newValue!,
                              )),
                        ]),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 30, 35, 50),
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      isSelected[0]
                                          ? CustomColors.deepGreen
                                          : CustomColors.grey,
                                      BlendMode.srcIn),
                                  child: Container(
                                      decoration: isSelected[0]
                                          ? BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      CustomColors.deepGreen),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )
                                          : null,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/farmer.png",
                                            height: 50,
                                          ),
                                          Text(
                                            "Продавец",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: isSelected[0]
                                                        ? CustomColors.deepGreen
                                                        : CustomColors.grey),
                                          ),
                                        ],
                                      )),
                                )),
                            onTap: () => setState(() {
                              selectedUserType = UserType.FM;
                              isSelected[1] = false;
                              isSelected[0] = true;
                            }),
                          ),
                          InkWell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    isSelected[1]
                                        ? CustomColors.deepGreen
                                        : CustomColors.grey,
                                    BlendMode.srcIn),
                                child: Container(
                                    decoration: isSelected[1]
                                        ? BoxDecoration(
                                            border: Border.all(
                                                color: CustomColors.deepGreen),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )
                                        : null,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/cart.png",
                                          height: 50,
                                        ),
                                        Text(
                                          "Покупатель",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: isSelected[1]
                                                      ? CustomColors.deepGreen
                                                      : CustomColors.grey),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            onTap: () => setState(() {
                              selectedUserType = UserType.BY;
                              isSelected[0] = false;
                              isSelected[1] = true;
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: Text(
                      "Уже есть аккаунт? Войти",
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
                                .registerAccount(
                                    _mailController.text,
                                    _nameController.text,
                                    _passwordController.text,
                                    selectedUserType.name);
                            if (response.isCreated == true) {
                              Navigator.pushNamed(context, '/login');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(response.errorMessage ?? 'Ошибка'),
                                  duration: const Duration(seconds: 5),
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Зарегистрироваться',
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
