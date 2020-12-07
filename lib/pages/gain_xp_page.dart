
import 'package:flutter/material.dart';
import 'package:one_punch_man_workout/app-settings/ranks_definition.dart';
import 'package:one_punch_man_workout/model/exercise_made_model.dart';
import 'package:flutter/painting.dart';

class GainXp extends StatefulWidget {
  final ExerciseMade exercise;
  GainXp(this.exercise);

  @override
  _GainXpState createState() => _GainXpState(this.exercise);
}

class _GainXpState extends State<GainXp> {
  final ExerciseMade exercise;
  double value;
  double rawXp = 0;
  int streakDays = 0;
  double streakMult = 0;
  double totalGainedXp = 0;
  int initialPlayerXp = 0;
  int nexClassXp = 0;
  double percentageClass = 0;
  List<Text> _messagesList = [];
  _GainXpState(this.exercise);
  
  void updateMessagesList() {
    List<Text> newList = [];
    if(_messagesList.isNotEmpty){
      for(Text messageWidget in _messagesList){
        Color oldColor = messageWidget.style.color;
        Color newColor = Colors.black.withOpacity((oldColor.opacity * 0.5));
        newList.add(
          Text( 
            messageWidget.data,
            style: TextStyle( 
              color: newColor,
              fontSize: messageWidget.style.fontSize * 0.5,
            ),
          )
        );
      }
    }
    _messagesList = List.from(newList);
  }

  void calculateRawXp() {
    double xp = PlayerRank.calculateRawXp(exercise);
    this.setState(() {
      this.rawXp = xp;
    });
  }

  void calculateMultStreak() async {
    int streak = await PlayerRank.getExerciseStreak();
    this.setState(() {
      this.streakDays = streak;
      this.streakMult = PlayerRank.calculateMultStreak(streak);
    });
  }

  void updatePercentage() {
    this.percentageClass = (this.initialPlayerXp + this.totalGainedXp) / this.nexClassXp;
  }


  void getPlayerInitialXp() async {
    int initialXp = await PlayerRank.getPlayerXP();
    int nextXp = await PlayerRank.getXpToNextRank();
    this.setState(() {
      this.initialPlayerXp = initialXp;
      this.nexClassXp = nextXp;
      this.percentageClass = initialXp / nextXp;      
    });
    
  }

  void addNewMessages() {
    Future.delayed(const Duration(milliseconds: 500), () {
      //updateMessagesList();
      setState((){
        _messagesList.insert(0,
          Text("XP " + rawXp.floor().toString(),
            style: TextStyle(  
              color: Colors.black,
              fontSize: 30
            )
          )
        );
        this.totalGainedXp = rawXp;
        this.updatePercentage();
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      updateMessagesList();
      setState((){
        double gainedCompletedXp = this.totalGainedXp * 0.5;
        _messagesList.insert(0,
          Text("Completed " + gainedCompletedXp.floor().toString(),
          style: TextStyle(  
              color: Colors.black,
              fontSize: 30
            )
          ),
        );
        this.totalGainedXp = totalGainedXp + gainedCompletedXp;
        this.updatePercentage();
      });
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      updateMessagesList();
      setState((){
        double gainedStreakXp = this.streakMult * this.totalGainedXp;
        _messagesList.insert(0,
          Text(this.streakDays.toString() + " days streak " + gainedStreakXp.floor().toString(),
          style: TextStyle(  
              color: Colors.black,
              fontSize: 30
            )
          ),
        );
        this.totalGainedXp = totalGainedXp + gainedStreakXp;
        this.updatePercentage();
      });
    });

  }

  @override
  void initState() {
    //PlayerRank.registerExercise(exercise);
    getPlayerInitialXp();
    calculateMultStreak();
    calculateRawXp();
    addNewMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(  
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(  
        title: Text("Teste"),
      ),
      body: Column(  
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("YOUR XP IS"),
          Text((this.totalGainedXp + this.initialPlayerXp).floor().toString(),
            style: TextStyle(  
              fontSize: 50,
            ),
          ),
          Container(
            width: 200,
            child: LinearProgressIndicator(
              value: this.percentageClass,
              minHeight: 10,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: _messagesList,
                )
              )
            )
          ),
        ]
      ),
    );
  }
  
}