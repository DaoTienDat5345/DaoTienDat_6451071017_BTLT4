import 'package:flutter/material.dart';
import '../views/student_form_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Form Demo',
      debugShowCheckedModeBanner: false,
      home: StudentFormPage(),
    );
  }
}
