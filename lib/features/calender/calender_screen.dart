import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hourify/features/calender/widgets/ca_custom_colors.dart';
import 'package:hourify/features/calender/widgets/ca_textStyle.dart';
import 'package:hourify/helper/app_bar_design/customappbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Center(child: Text("Calender",style: Customappbar.customAppBarDesign,)),),
      body: Column(children: [
        //===========================

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.shade100
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _selectedDay != null
              ? DateFormat('EEEE, dd MMMM').format(_selectedDay!)
                  : DateFormat('EEEE,dd MMMM').format(_focusedDay)
              ,
            style: CaTextstyle.headerTextStyle,),
          ),
        ),

        const SizedBox(height: 12),

        TableCalendar(
        focusedDay: _focusedDay,
        calendarFormat:_calendarFormat ,
        firstDay: DateTime.utc(2026,1,1),
        lastDay: DateTime.utc(2040,01,01),

          headerStyle: HeaderStyle(
            titleCentered: false,
            formatButtonVisible: true,
            formatButtonShowsNext: false,
            formatButtonDecoration: BoxDecoration(
              color: CaCustomColors.calanderformateColor,
              borderRadius: BorderRadiusGeometry.circular(8)
            ),

            formatButtonTextStyle: CaTextstyle.formatTextStylemonth,
            titleTextStyle: CaTextstyle.formatTextStyle,

          ),

          selectedDayPredicate: ((day) {
            return isSameDay(_selectedDay, day);
          }),
          onDaySelected: (selectedDay, focusedDay) {
            if(!isSameDay(_selectedDay,selectedDay)){
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if(_calendarFormat != format){
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },

          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: CaCustomColors.caldenderSelectColor,
              shape: BoxShape.circle
            ),
            selectedDecoration: const BoxDecoration(
              color: CaCustomColors.caldenderunSelectColor,
              shape: BoxShape.circle
            )
          ),



        )

        //=============================
      ],),

    );
  }

}

