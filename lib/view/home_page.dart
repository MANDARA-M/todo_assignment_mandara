import 'package:flutter/material.dart';
import 'package:todo/services/dataservice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Todo App'),
        ),
        body: _buildListView()
      ),
    );
  }

  Widget _buildListView() {
    return SafeArea(
      child:
        StreamBuilder(
            stream: dataService.getToDos(),
            builder: (context, snapshot) {
              return ListView();
            }
        ),

    );
  }

}
