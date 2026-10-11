import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hourify/features/calender/calender_screen.dart';
import 'package:hourify/features/counter/counter_screen.dart';
import 'package:hourify/features/home/home_screen.dart';
import 'package:hourify/features/profile/profile_screen.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
              backgroundColor: Color(0xFFFFFFFF)
          ),
          BottomNavigationBarItem(icon: Icon(Icons.timer),backgroundColor: Color(0xFF000033),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month),backgroundColor: Color(0xFFFFFFFF),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle),backgroundColor: Color(0xFF000033),label: ''),
        ],
        currentIndex: _index,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.blue,
        unselectedFontSize: 12,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        onTap: (int index){
          setState(() {
            _index = index;
          });
        },

      ),
      body:IndexedStack(
        index: _index,
        children: [
          HomeScreen(),
          CounterScreen(),
          CalenderScreen(),
          ProfileScreen(),
        ],
      ),



    );
  }
}
