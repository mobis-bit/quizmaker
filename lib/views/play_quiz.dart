import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/models/question_model.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/widgets/quiz_play_widgets.dart';
import 'package:quizmaker/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = DatabaseService();
  QuerySnapshot questionsSnapshot;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"]
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuestionData(widget.quizId).then((value) {
      questionsSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            questionsSnapshot.documents == null
                ? Container()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: questionsSnapshot.documents.length,
                    itemBuilder: (context, index) {
                      return QuizPlayTile(
                        questionModel: getQuestionModelFromDatasnapshot(
                            questionsSnapshot.documents[index]),
                        index: index,
                      );
                    })
          ],
        ),
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(widget.questionModel.question),
          SizedBox(height: 4),
          OptionTile(
            correctAnswer: widget.questionModel.option1,
            description: widget.questionModel.option1,
            option: "A",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4),
          OptionTile(
            correctAnswer: widget.questionModel.option1,
            description: widget.questionModel.option2,
            option: "B",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4),
          OptionTile(
            correctAnswer: widget.questionModel.option1,
            description: widget.questionModel.option3,
            option: "C",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4),
          OptionTile(
            correctAnswer: widget.questionModel.option1,
            description: widget.questionModel.option4,
            option: "D",
            optionSelected: optionSelected,
          ),
        ],
      ),
    );
  }
}
