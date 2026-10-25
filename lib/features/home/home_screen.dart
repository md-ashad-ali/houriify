import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hourify/contoler/app_catagories.dart';
import 'package:hourify/contoler/counter_storage.dart';
import 'package:hourify/contoler/counter_stroge_sf.dart';
import 'package:hourify/features/home/widgets/hs_custom_app_color.dart';
import 'package:hourify/features/home/widgets/hs_custom_textstyle.dart';
import 'package:hourify/helper/app_bar_design/customappbar.dart';
import 'package:lottie/lottie.dart';

import '../../contoler/assets_path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HsAppColor.backgroudnColor,
      appBar: AppBar(
        title: Center(
          child: Text('Home', style: Customappbar.customAppBarDesign),
        ),
      ),

      body: ListView.builder(
        itemCount: AppCatagories.Catagories.length,
        itemBuilder: (context, index) {
          String Catagori = AppCatagories.Catagories[index];

          return FutureBuilder<int>(
            future: CounterStrogeSf.getTime(Catagori),
            builder: (context, snapshot) {

              final totalSecond = snapshot.data ?? 0;
              final String formattedTime =
                  '${(totalSecond ~/ 3600).toString().padLeft(2, '0')}:'
                  '${((totalSecond % 3600) ~/ 60).toString().padLeft(2, '0')}:'
                  '${(totalSecond % 60).toString().padLeft(2, '0')}';

              if(Catagori == 'Entertainment'){
                return _custom_activity_cardview(context: context,Catagori: Catagori,formattedTime: formattedTime,imagePath: AssetsPath.entertainment);
              }else if(Catagori == 'Office'){
                return _custom_activity_cardview(context: context,Catagori: Catagori,formattedTime: formattedTime,imagePath: AssetsPath.office);
              } else if( Catagori == 'Exercise'){
                return _custom_activity_cardview(context: context,Catagori: Catagori,formattedTime: formattedTime,imagePath: AssetsPath.exercise);
              }else if(Catagori == 'Sleeping'){
                return _custom_activity_cardview(context: context,Catagori: Catagori,formattedTime: formattedTime,imagePath: AssetsPath.sleeping);
              }else if(Catagori == 'Work'){
                return _custom_activity_cardview(context: context,Catagori: Catagori,formattedTime: formattedTime,imagePath: AssetsPath.workPath);
              }else if(Catagori == 'Education'){
                return _custom_activity_cardview(context: context,Catagori: Catagori,formattedTime: formattedTime,imagePath: AssetsPath.education);
              }

              return Text('');

              /*return Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: HsAppColor.backgroudn,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          Catagori,
                          style: HsCustomTextstyle.headingText,
                        ),
                      ),
                      Divider(color: HsAppColor.borderColor),
                      Expanded(
                        child: Center(
                          child: Text(
                            formattedTime,
                            style: HsCustomTextstyle.counterText,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );*/


            },
          );
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset('assets/profile_image.png', width: 200, height: 200),
            Divider(color: Colors.black),

            ListTile(
              title: Text('Today Report'),
              leading: Icon(Icons.report),
              onTap: () {},
            ),
            ListTile(
              title: Text('Weekly Report'),
              leading: Icon(Icons.report),
              onTap: () {},
            ),
            ListTile(
              title: Text('Monthly Report'),
              leading: Icon(Icons.report),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _custom_activity_cardview(
      { required BuildContext context,required String imagePath, required String Catagori,required String formattedTime}) {
    return Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Catagori,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: HsAppColor.taitle_textColor),),
                              SizedBox(height: 20,),
                              Text(formattedTime,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: HsAppColor.subtaitle_textColor),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Lottie.asset(imagePath,width: 140,height: 140),
                        ),
                      ],
                    ),

                  ),
                ),
              );
  }
}
