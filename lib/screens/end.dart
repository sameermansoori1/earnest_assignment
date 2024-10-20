import 'package:earnest_assignment/data/questions.dart';
import 'package:earnest_assignment/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class End extends StatelessWidget {
  var score;
  final maxIndex = 9;
  End(int score) {
    this.score = score;
  }

  dynamic retText() {
    if (GetStorage().read("TotalScore") == null) {
      return "0";
    } else {
      return GetStorage().read("TotalScore").toString();
    }
  }

  List<Widget> listCard() {
    List<Widget> cards = [];

    for (int i = 0; i < maxIndex + 1; i++) {
      cards.add(CustomCard(i));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 37, 47, 68),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 50, 5, 0),
                width: double.infinity,
                child: Card(
                  color: const Color.fromARGB(55, 0, 0, 0),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(children: [
                      Expanded(
                          child: Column(
                        children: [
                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 10.0,
                            percent: score / 100,
                            center: Text(
                              "Score\n$score",
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            progressColor: Colors.green.shade800,
                            backgroundColor: Colors.grey.shade800,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Total Score",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            retText(),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          )
                        ],
                      )),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Welcome()),
                              );
                            },
                            icon: const Icon(
                              Icons.restart_alt_rounded,
                              size: 50,
                              color: Colors.green,
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.leaderboard_rounded,
                              color: Colors.blue,
                              size: 50,
                            )),
                      ),
                      const SizedBox(width: 25)
                    ]),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ListView(children: listCard()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  var index;
  CustomCard(index) {
    this.index = index;
  }

  dynamic retColor(int i) {
    if (answers[i] == true) {
      return Colors.green.shade800;
    } else {
      return Colors.grey.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: retColor(index),
      child: Container(
          margin: const EdgeInsets.all(10),
          child: Text(
            questions[index]["note"],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          )),
    );
  }
}
