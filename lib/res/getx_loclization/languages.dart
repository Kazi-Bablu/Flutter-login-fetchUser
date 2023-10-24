import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys =>{
    'en_US':{
      'internet_exception': "We are unable to show result.\nPlease check "
          "your data\n connection",
      'general_exception':"We are unable to process your request.\n Please try again",
      'email_hint':'Email',
      'password_hint':'Password'
    },
    'ur_PK':{
      'email_hint': 'as'
    }
  };
}