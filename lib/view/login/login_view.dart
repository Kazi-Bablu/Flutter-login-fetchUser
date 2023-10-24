import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/res/components/round_button.dart';
import 'package:getx_mvvm/view_models/controller/login/login_view_model.dart';

import '../../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginViewModel = Get.put(LoginViewModel());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: loginViewModel.emailController.value,
                        focusNode: loginViewModel.emailFocusNode.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Utils.snackBar('Email', 'Enter email');
                          }
                        },
                        onFieldSubmitted: (value) {
                          Utils.fieldFocusChange(context,
                              loginViewModel.emailFocusNode.value,
                              loginViewModel.passwordFocusNode.value);
                        },
                        decoration: InputDecoration(
                            hintText: 'email_hint'.tr,
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: loginViewModel.passwordController.value,
                        focusNode: loginViewModel.passwordFocusNode.value,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Utils.snackBar('Password', 'Enter password');
                          }
                        },
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                            hintText: 'password_hint'.tr,
                            border: OutlineInputBorder()),
                      ),
                    ],
                  )),
              SizedBox(height: 40),
              Obx(() => RoundButton(
                  width: 200,
                  title: 'Login',
                  loading: loginViewModel.loading.value,
                  onPress: () {
                    if (_formkey.currentState!.validate()) {
                      loginViewModel.loginApi();
                    }
                  }))
            ],
          ),
        ));
  }
}
