import 'package:earnest_assignment/screens/quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool LoggedIn = false;
    if (GetStorage().read("credential") != null) {
      LoggedIn = true;
    } else {
      LoggedIn = false;
    }

    // Read the previous score from GetStorage
    int previousTotalScore = GetStorage().read("TotalScore") ?? 0;
    int previousScore = GetStorage().read("PreviousScore") ?? 0;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        //appBar: AppBar(),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 37, 47, 68),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage("images/earnest_quiz.png"),
                      ),
                      Text(
                        "Powered By Earnest Fintech",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                "Welcome",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Let's play a quiz",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Display the previous score
              if (LoggedIn)
                Text(
                  "Your Previous Score : $previousScore",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.greenAccent,
                  ),
                ),
              if (LoggedIn)
                Text(
                  "Your Previous TotalScore : $previousTotalScore",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.greenAccent,
                  ),
                ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () async {
                    if (LoggedIn == false) {
                      if (GetStorage().read("credential") != null) {
                        FirebaseAuth.instance.signInWithCredential(
                            GetStorage().read("credential"));
                      } else {
                        GoogleSignInAccount? googleUser =
                            await GoogleSignIn().signIn();
                        GoogleSignInAuthentication? googleAuth =
                            await googleUser?.authentication;
                        AuthCredential credential =
                            GoogleAuthProvider.credential(
                                accessToken: googleAuth?.accessToken,
                                idToken: googleAuth?.idToken);
                        GetStorage().write("credential", credential);
                        FirebaseAuth.instance.signInWithCredential(
                            GetStorage().read("credential"));
                      }
                      LoggedIn = true;
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Quiz()),
                      );
                    }
                  },
                  child: const TextState(),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class TextState extends StatefulWidget {
  const TextState({Key? key}) : super(key: key);

  @override
  _TextStateState createState() => _TextStateState();
}

class _TextStateState extends State<TextState> {
  @override
  Widget build(BuildContext context) {
    String btnText;
    if (GetStorage().read("credential") != null) {
      btnText = "Start the Quiz";
    } else {
      btnText = "Continue to Login";
    }
    GetStorage().listenKey("credential", (value) {
      setState(() {
        if (GetStorage().read("credential") != null) {
          btnText = "Start the Quiz";
        } else {
          btnText = "Continue to Login";
        }
      });
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (GetStorage().read("credential") == null)
          Image.asset('images/google.png', height: 24, fit: BoxFit.fitHeight),
        const SizedBox(width: 10),
        Text(
          btnText,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
