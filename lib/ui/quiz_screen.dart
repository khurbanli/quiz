import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quiz/db/flaq.dart';
import 'package:quiz/db/flaqdao.dart';
import 'package:quiz/ui/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var sorular = <Flaq>[];
  var yalnisSecenekler = <Flaq>[];
  late Flaq dogruSoru;
  var allSecenek = HashSet<Flaq>();

  int soruSayac = 0;
  int dogruSayac = 0;
  int yalnisSayac = 0;

  String flaqImageName = "placeholder.png";
  String butonA = "";
  String butonB = "";
  String butonC = "";
  String butonD = "";

  Future<void> sorulariAl() async {
    var sorular = await Flaqdao().rastGele();

    dogruSoru = sorular[soruSayac];
    flaqImageName = dogruSoru.flaq_image;
    var yalnisSecenekler = await Flaqdao().yalnisGetir(dogruSoru.flaq_id);

    allSecenek.clear();
    allSecenek.add(dogruSoru);
    allSecenek.add(yalnisSecenekler[0]);
    allSecenek.add(yalnisSecenekler[1]);
    allSecenek.add(yalnisSecenekler[2]);

    butonA = allSecenek.elementAt(0).flaq_name;
    butonB = allSecenek.elementAt(1).flaq_name;
    butonC = allSecenek.elementAt(2).flaq_name;
    butonD = allSecenek.elementAt(3).flaq_name;
    setState(() {});
  }

  void soruSayacKontrol() {
    soruSayac += 1;
    if (soruSayac != 5) {
      sorulariAl();
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ResultScreen(dogruSayac)));
    }
  }

  void dogruKontrol(String butonYazi) {
    if (dogruSoru.flaq_name == butonYazi) {
      dogruSayac += 1;
    } else {
      yalnisSayac += 1;
    }
  }

  @override
  void initState() {
    super.initState();
    sorulariAl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quiz",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("True: $dogruSayac",
                      style: const TextStyle(fontSize: 18)),
                  Text("False: $yalnisSayac",
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
              soruSayac != 5
                  ? Text("${soruSayac + 1}. question",
                      style: const TextStyle(fontSize: 30))
                  : const Text("5. question", style: TextStyle(fontSize: 30)),
              Image.asset("lib/flaqimage/$flaqImageName"),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    dogruKontrol(butonA);
                    soruSayacKontrol();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child:
                      Text(butonA, style: const TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    dogruKontrol(butonB);
                    soruSayacKontrol();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child:
                      Text(butonB, style: const TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      dogruKontrol(butonC);
                      soruSayacKontrol();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(butonC,
                        style: const TextStyle(color: Colors.white)),
                  )),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      dogruKontrol(butonD);
                      soruSayacKontrol();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(butonD,
                        style: const TextStyle(color: Colors.white)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
