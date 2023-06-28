import 'package:expense_tracker/home_screen/view/home_screen.dart';
import 'package:expense_tracker/read_screen/read_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => Home_Screen(),
        ),
        GetPage(
          name: '/read',
          page: () => Read_Screen(),
        ),
      ],
    ),
  );
}
