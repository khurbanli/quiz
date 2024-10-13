import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int dogruSayi;
  const ResultScreen(this.dogruSayi, {super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Result",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("True: ${widget.dogruSayi},\tFalse: ${5 - widget.dogruSayi}",
                style: const TextStyle(fontSize: 20)),
            Text("${(widget.dogruSayi * 100) ~/ 5} % Basarili",
                style: const TextStyle(fontSize: 30, color: Colors.pinkAccent)),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Try again",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
