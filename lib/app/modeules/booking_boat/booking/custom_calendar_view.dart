import 'package:boat/app/themes/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendarView extends StatefulWidget {
  const CustomCalendarView(
      {Key? key,
      this.initialStartDate,
      this.initialEndDate,
      this.startEndDateChange,
      this.minimumDate,
      this.maximumDate})
      : super(key: key);

  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  final Function(DateTime, DateTime)? startEndDateChange;

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  List<DateTime> dateList = <DateTime>[];
  DateTime currentMonthDate = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    setListOfDate(currentMonthDate);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    final DateTime newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMothDay = 0;
    if (newDate.weekday < 7) {
      previousMothDay = newDate.weekday;
      for (int i = 1; i <= previousMothDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMothDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMothDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
          child: Row(
            children: <Widget>[

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    DateFormat('MMMM, yyyy').format(currentMonthDate),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: AppColors.black_type),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    onTap: () {
                      setState(() {
                        currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month, 0);
                        setListOfDate(currentMonthDate);
                      });
                    },
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    onTap: () {
                      setState(() {
                        currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month + 2, 0);
                        setListOfDate(currentMonthDate);
                      });
                    },
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
          child: Row(
            children: getDaysNameUI(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: Column(
            children: getDaysNoUI(),
          ),
        ),
      ],
    );
  }

  List<Widget> getDaysNameUI() {
    final List<Widget> listUI = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat('EE').format(dateList[i]),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff989DB2
              )),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  List<Widget> getDaysNoUI() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    for (int i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 9, bottom: 9),
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 2,
                              bottom: 2,
                              left: isStartDateRadius(date) ? 12 : 0,
                              right: isEndDateRadius(date) ? 12 : 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: startDate != null && endDate != null
                                  ? getIsItStartAndEndDate(date) || getIsInRange(date)
                                      ? Color(0xff494AFF).withOpacity(0.2)
                                      : Colors.transparent
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                bottomLeft:
                                    isStartDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                                topLeft:
                                    isStartDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                                topRight:
                                    isEndDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                                bottomRight:
                                    isEndDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (currentMonthDate.month == date.month) {
                            if (widget.minimumDate != null && widget.maximumDate != null) {
                              final DateTime newminimumDate = DateTime(
                                  widget.minimumDate!.year, widget.minimumDate!.month, widget.minimumDate!.day - 1);
                              final DateTime newmaximumDate = DateTime(
                                  widget.maximumDate!.year, widget.maximumDate!.month, widget.maximumDate!.day + 1);
                              if (date.isAfter(newminimumDate) && date.isBefore(newmaximumDate)) {
                                onDateClick(date);
                              }
                            } else if (widget.minimumDate != null) {
                              final DateTime newminimumDate = DateTime(
                                  widget.minimumDate!.year, widget.minimumDate!.month, widget.minimumDate!.day - 1);
                              if (date.isAfter(newminimumDate)) {
                                onDateClick(date);
                              }
                            } else if (widget.maximumDate != null) {
                              final DateTime newmaximumDate = DateTime(
                                  widget.maximumDate!.year, widget.maximumDate!.month, widget.maximumDate!.day + 1);
                              if (date.isBefore(newmaximumDate)) {
                                onDateClick(date);
                              }
                            } else {
                              onDateClick(date);
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: getIsItStartAndEndDate(date) ? Color(0xff494AFF
                              ) : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                bottomLeft:
                                isStartDateRadius(date) ? const Radius.circular(8.0) : const Radius.circular(0.0),
                                topLeft:
                                isStartDateRadius(date) ? const Radius.circular(8.0) : const Radius.circular(0.0),
                                topRight:
                                isEndDateRadius(date) ? const Radius.circular(11.0) : const Radius.circular(0.0),
                                bottomRight:
                                isEndDateRadius(date) ? const Radius.circular(11.0) : const Radius.circular(0.0),
                              ),


                            ),
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style: TextStyle(
                                    color: getIsItStartAndEndDate(date)
                                        ? Colors.white
                                        : currentMonthDate.month == date.month
                                            ? Color(0xff333333
                                    )
                                            : Colors.white,
                                    fontSize: MediaQuery.of(context).size.width > 360 ? 14 : 29,
                                    fontWeight: getIsItStartAndEndDate(date) ? FontWeight.w500 : FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom:0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            color: DateTime.now().day == date.day &&
                                    DateTime.now().month == date.month &&
                                    DateTime.now().year == date.year
                                ? getIsInRange(date)
                                    ? Colors.transparent
                                    : Theme.of(context).primaryColor
                                : Colors.transparent,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        count += 1;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  bool getIsInRange(DateTime date) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate!) && date.isBefore(endDate!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getIsItStartAndEndDate(DateTime date) {
    if (startDate != null &&
        startDate!.day == date.day &&
        startDate!.month == date.month &&
        startDate!.year == date.year) {
      return true;
    } else if (endDate != null &&
        endDate!.day == date.day &&
        endDate!.month == date.month &&
        endDate!.year == date.year) {
      return true;
    } else {
      return false;
    }
  }


  bool isStartDateRadius(DateTime date) {
    if (startDate != null && startDate!.day == date.day && startDate!.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    if (endDate != null && endDate!.day == date.day && endDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void onDateClick(DateTime date) {
    if (startDate == null) {
      startDate = date;
    } else if (startDate != date && endDate == null) {
      endDate = date;
    } else if (startDate!.day == date.day && startDate!.month == date.month) {
      startDate = null;
    } else if (endDate!.day == date.day && endDate!.month == date.month) {
      endDate = null;
    }
    if (startDate == null && endDate != null) {
      startDate = endDate;
      endDate = null;
    }
    if (startDate != null && endDate != null) {
      if (!endDate!.isAfter(startDate!)) {
        final DateTime d = startDate!;
        startDate = endDate;
        endDate = d;
      }
      if (date.isBefore(startDate!)) {
        startDate = date;
      }
      if (date.isAfter(endDate!)) {
        endDate = date;
      }
    }
    setState(() {
      try {
        widget.startEndDateChange!(startDate!, endDate!);
      } catch (_) {}
    });
  }
}
