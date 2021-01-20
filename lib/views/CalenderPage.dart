import 'package:farm_app/models/Farmer.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class CalenderPage extends StatefulWidget {
  Farmer farmer;
  CalenderPage({this.farmer});
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage>
    with TickerProviderStateMixin {
  Map<DateTime, List> _visits;
  List _selectedVisits;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _visits = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Dove House',
        'Rabit House',
        'Turkey Farm'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Dog House'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Dog House',
        'Cow Huose',
        'Rabit House',
        'Vegetable Garden'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Turkey Farm', 'Goat House'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Turkey Farm',
        'Dog House',
        'Cow Huose',
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Turkey Farm',
        'Donkey Yard',
        'Goat House'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Donkey Yard', 'Goat House'],
      _selectedDay: [
        'Paultry Farm',
        'Turkey Farm',
        'Rabit House',
        'Sheep House'
      ],
      _selectedDay.add(Duration(days: 1)): [
        'Cow Huose',
        'Rabit House',
        'Vegetable Garden'
      ],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Paultry Farm',
        'Turkey Farm',
        'Rabit House',]).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Turkey Farm',
        'Donkey Yard',
        'Goat House'
      ],
      _selectedDay.add(Duration(days: 11)): [
        'Turkey Farm',
        'Donkey Yard',
      ],
      _selectedDay.add(Duration(days: 17)): [
        'Dove House',
        'Rabit House',
        'Turkey Farm'
        'Goat House'
      ],
      _selectedDay.add(Duration(days: 22)): ['Rabit House', 'Turkey Farm'],
      _selectedDay.add(Duration(days: 26)): [
        'Rabit House',
        'Turkey Farm'
        'Goat House'
      ],
    };

    _selectedVisits = _visits[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List visits, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedVisits = visits;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.farmer.name + "'s Calender"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          _buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'en_us',
      calendarController: _calendarController,
      events: _visits,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedVisits
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
