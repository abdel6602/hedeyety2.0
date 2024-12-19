import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/app_colors.dart';
import './pages/login_page.dart';

//main
void main() {
  final darkModeEnabled = isDarkModeEnabled();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

Future<bool> isDarkModeEnabled() async {
  final _instance = await SharedPreferences.getInstance();
  final enabled = _instance.getBool("Theme");
  if(enabled == null){
    return true;
  }
  else{
    return enabled;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primaryDark,
      body: LoginPage(),
    );
  }
}


