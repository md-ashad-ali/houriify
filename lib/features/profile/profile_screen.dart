import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hourify/contoler/activityData.dart';
import 'package:hourify/contoler/app_catagories.dart';
import 'package:hourify/contoler/counter_storage.dart';

import '../../helper/app_bar_design/customappbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }


  @override
  Widget build(BuildContext context) {

    final categories = AppCatagories.Catagories;

    final times = categories
        .map((category) => CounterStorage.getTime(category))
        .toList();

    final maxTime = times.fold<int>(
      0,
          (previous, current) =>
      current > previous ? current : previous,
    );

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Profile',style: Customappbar.customAppBarDesign,))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/profile_image.png',
                width: 200,
                height: 200,
              ),
            ),

            //================================
            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index){
                    final item = categories[index];
                    final totalSeconds = times[index];

                    final fillFactor = maxTime == 0
                        ? 0.0
                        : totalSeconds / maxTime;

                    return _buildActivitybar(
                        title: item,
                        timeText: formatTime(totalSeconds),
                        fillHeightFactor: fillFactor,
                        barColor: Colors.blue.shade300,
                    );
                  }
              ),
            ),
            const SizedBox(height: 40),

            //================================
          ],
        ),
      ),
    );
  }

  // Highlight 3: Reusable Custom Widget Method (Beginner der jonno code concise rakhar shera upay)

Widget _buildActivitybar({
    required String title,
    required String timeText,
    required double fillHeightFactor,
    required Color barColor,
}){
return Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const SizedBox(height: 15),
    Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    const SizedBox(height: 10),
    Container(
      height: 25,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: fillHeightFactor,
            child: Container(
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
          Positioned.fill(
            left: 10,
              child: Center(
                child: Text(timeText,style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),),
              )
          ),
        ],
      ),
    )

  ],
);

}



}