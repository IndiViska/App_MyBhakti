import 'package:flutter/material.dart';

class KnowledgePage extends StatelessWidget {
  const KnowledgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Knowledge"),
        backgroundColor: const Color(0xffB1121B),
      ),

      body: const Center(
        child: Text(
          "Knowledge Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}