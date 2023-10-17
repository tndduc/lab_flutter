import 'package:flutter/material.dart';
import 'package:quiz/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  QuizBrain quizBrain = QuizBrain();

  void verifyAnswer(bool userAnswer) {
    bool questionAnswer = this.quizBrain.getQuestionAnswer();

    if (this.quizBrain.isFinished()) {
      Alert(
          context: context,
          type: AlertType.warning,
          title: "Finished",
          desc: "You've reached the end of the quiz.",
          buttons: [
            DialogButton(
              child: Text(
                'RESTART',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  this.quizBrain.reset();
                  this.scoreKeeper = [];
                });
                Navigator.pop(context);
              },
            ),
          ]).show();
    } else {
      Icon iconAnswer = Icon(
        (questionAnswer == userAnswer) ? Icons.check : Icons.clear,
        color: (questionAnswer == userAnswer) ? Colors.green : Colors.red,
      );

      setState(() {
        this.scoreKeeper.add(iconAnswer);
        this.quizBrain.nextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                this.quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              onPressed: () => this.verifyAnswer(true),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => this.verifyAnswer(false),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: this.scoreKeeper,
        ),
      ],
    );
  }
}
