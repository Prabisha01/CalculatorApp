import 'package:calculator/app/theme/theme_data.dart';
import 'package:calculator/view/calcutor_view.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const CalculatorView(),
        theme: getApplicatioTheme()
       
    );
  }
}
