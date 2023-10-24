import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/data/repository/login_repository/login_repository.dart';
import 'package:getx_mvvm/models/login/user_modal.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/utils/utils.dart';
import 'package:getx_mvvm/view_models/controller/user_preference/user_prefernce_view_model.dart';

class LoginViewModel extends GetxController {
  final _api = LoginRepository();

  UserPreference userPreference = UserPreference();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  void loginApi() {
    loading.value = true;
    Map data = {
      'email': emailController.value.text,
      'password': passwordController.value.text,
    };
    _api.loginApi(data).then((value) {
      loading.value = false;
      if (value['error'] == 'User Not Found') {
        Utils.snackBar('Login', value['error']);
      } else {
        UserModel userModel = UserModel(
          token: value['token'],
          isLogin: true,
        );
        userPreference.saveUser(userModel).then((value) {
          Get.toNamed(RouteName.homeView);
        }).onError((error, stackTrace) {});
        Utils.snackBar('Login', 'Login Successfully');
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar('Error', error.toString());
    });
  }
}
