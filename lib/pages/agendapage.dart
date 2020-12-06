import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:one_punch_man_workout/bloc/exercise_made_bloc.dart';
import 'package:one_punch_man_workout/pages/custom_assets/custom_barless_scaffold.dart';
import 'custom_assets/custom_scaffold.dart';
import 'custom_assets/listexercisesmade.dart';
import 'package:one_punch_man_workout/dao/exercise_made_dao.dart';
import 'package:one_punch_man_workout/model/exercise_made_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AgendaPage extends StatefulWidget {
  AgendaPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AgendaPageState createState() => new _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {

  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format( DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  
  void _getExercisesAddAsEvents(DateTime currentDate) {
    ExerciseMadeBloc bloc = ExerciseMadeBloc();
    String month = currentDate.year.toString() + "/" + currentDate.month.toString();
    bloc.getExercisesMade(query: month);
    this._markedDateMap.clear();
    bloc.exercisesMade.listen(
      (data) {
        for(ExerciseMade exercise in data){
          this._markedDateMap.add(new DateTime(exercise.dtdone.year,exercise.dtdone.month,exercise.dtdone.day), new Event( 
            date: new DateTime(exercise.dtdone.year,exercise.dtdone.month,exercise.dtdone.day),
            title: 'Event 1',
            icon: _eventIcon,
          ));
          this.setState(() {
            
          });
        }
      }
    );
  }

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(
          color: Colors.grey, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );
  EventList<Event> _markedDateMap = new EventList();

  CalendarCarousel _calendarCarouselNoHeader;

  @override
  void initState() {
    _getExercisesAddAsEvents(this._targetDateTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      locale: AppLocalizations.of(context).localeName,
      todayBorderColor: Colors.grey,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.grey,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.black)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.white,
      ),
      todayButtonColor: Colors.grey,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey[300],
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
          _getExercisesAddAsEvents(this._targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },

    );

    return CustomScaffold(
        title: AppLocalizations.of(context).progress,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Center( 
                  child: Text(
                    AppLocalizations.of(context).yourRankIs,
                    style: TextStyle(fontSize: 10),
                  )
                )
              ),
              Center( 
                child: Text(
                  AppLocalizations.of(context).classString,
                  style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor),
                )
              ),
              Center( 
                child: Text(
                  AppLocalizations.of(context).rank,
                  style: TextStyle(fontSize: 27, fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor),
                )
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _currentMonth,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )),
                    FlatButton(
                      child: Text(AppLocalizations.of(context).prev),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    FlatButton(
                      child: Text(AppLocalizations.of(context).next),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month + 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarouselNoHeader,
              ), //
            ],
          ),
        ));
  }
}
