/* 
Homepage (after login?) where the user can have a small view of tasks and navigate to other pages
*/
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                'Task Pals',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
              centerTitle: true,
            ),
            body: const Center(
              child: SizedBox(
                child: Text(
                  'Yes',
                ),
              ),
            )
        )
    );
  }
}