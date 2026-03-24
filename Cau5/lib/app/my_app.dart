import 'package:flutter/material.dart';

import '../views/student_form_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bai 5 Form upload ho so',
      debugShowCheckedModeBanner: false,
      home: const StudentFormPage(),
    );
  }
}

