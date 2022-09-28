import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Calendar());
}

class Calendar extends StatelessWidget {
  // 필요한거:
  // 선택: 연도/달 -> 디폴트값은 DateTime.now()
  // 처음과 끝
  // 달 기준으로 뷰
  // 날짜/요일 불러오고
  // 요일기준으로 일월화수목금토 정리

  DateTime nowTime = DateTime.now();

  late DateTime selectedTime = nowTime;

  List<DateTime> getFirstAndLastDays(int year, int month) {
    DateTime selectedDateTime = DateTime(year, month);
    debugPrint(selectedDateTime.toString());
    debugPrint(DateFormat('E').format(selectedDateTime));

    DateTime firstDay = DateTime(year, month);
    DateTime lastDay = DateTime(year, month + 1, 0);

    return [firstDay, lastDay];
  }

  // index <-> day name 변환
  List indexToDay = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  int dayToIndex(DateTime day) {
    String startDateDay = DateFormat('E').format(day);
    return indexToDay.indexOf(startDateDay);
  }

  int getNumberOfRows(DateTime startDate, DateTime endDate) {
    int startDayIndex = dayToIndex(startDate);
    int endDayNumber = int.parse(DateFormat('dd').format(endDate)); //30 or 31

    int endPoint = startDayIndex + endDayNumber;
    int quotient = endPoint ~/ 7;

    return quotient + 1;
  }

  // 필요한 arguments -> NumberOfRows(FirstDay, LastDay에 의해 결정됨),
  Widget getCalendarTable(int year, int month) {
    List<DateTime> firstNlastday = getFirstAndLastDays(year, month);
    DateTime firstDay = firstNlastday[0];
    DateTime lastDay = firstNlastday[1];
    int numberOfRows = getNumberOfRows(firstDay, lastDay);

    int startDayIndex = dayToIndex(firstDay);

    debugPrint('startDayIndex = ' + startDayIndex.toString());

    return Column(
      children: [
        Text('${year}년 ${month}월'),
        Table(
          border: TableBorder.all(color: Colors.transparent),
          children: [
            TableRow(children: [
              for (int k = 0; k < 7; k++)
                SizedBox(
                    height: 64,
                    child: Column(
                      children: [
                        SizedBox(height: 30), // <--flex로 추후 변경
                        Text('${indexToDay[k]}'),
                      ],
                    ))
            ]),
            for (int i = 0; i < numberOfRows; i++)
              TableRow(children: [
                for (int j = 0; j < 7; j++)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              spreadRadius: 2.0)
                        ],
                        borderRadius: BorderRadius.circular(8.0)),
                    height: 64,
                    child: ((i * 7 + j - startDayIndex) <
                                int.parse(DateFormat('dd').format(lastDay)) &&
                            (i * 7 + j - startDayIndex) >= 0)
                        ? Text(
                            '${i * 7 + j - startDayIndex + 1}',
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(''),
                  ),
              ]),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
              child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: getCalendarTable(2022, 3)),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                getFirstAndLastDays(2022, 3);
              },
            )));
  }
}

// calendar -> 주단위 -> 일단위(timetable)
