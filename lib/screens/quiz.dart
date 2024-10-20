import 'package:earnest_assignment/data/questions.dart';
import 'package:earnest_assignment/screens/end.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int index = 0;
  int score = 0;
  bool answerSelected = false;
  int? selectedOption;
  final maxIndex = 9;
  List<bool> answers = List.filled(10, false);

  _QuizState() {
    clearAnswers();
    index = 0;
    score = 0;
  }

  void check(int opt) {
    setState(() {
      if (selectedOption != null) {
        if (questions[index]["answer"] ==
            questions[index]["option"][selectedOption!]) {
          score -= 10;
        }
      }

      selectedOption = opt;

      if (questions[index]["answer"] == questions[index]["option"][opt]) {
        score += 10;
        answers[index] = true;
      } else {
        answers[index] = false;
      }

      answerSelected = true;
    });
  }

  void nextQuestion() {
    setState(() {
      if (index == maxIndex) {
        if (GetStorage().read("TotalScore") == null) {
          GetStorage().write("TotalScore", score);
        } else {
          int ts = GetStorage().read("TotalScore") + score;
          GetStorage().write("TotalScore", ts);
        }
        GetStorage().write("PreviousScore", score);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => End(score, answers)),
        );
      } else {
        index++;
        selectedOption = null;
        answerSelected = false;
      }
    });
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
          child: Column(children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 40,
                ),
                width: double.infinity,
                height: double.infinity,
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          const Text(
                            "Questions",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            "${index + 1} / ${maxIndex + 1}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                      Divider(
                        color: Colors.grey.shade700,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.amber,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                questions[index]["question"],
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            ...List.generate(4, (optIndex) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedOption == optIndex
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                  onPressed: () => check(optIndex),
                                  child: Text(
                                    questions[index]["option"][optIndex],
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }),
                            // next button
                            if (answerSelected)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: ElevatedButton(
                                    onPressed: nextQuestion,
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
