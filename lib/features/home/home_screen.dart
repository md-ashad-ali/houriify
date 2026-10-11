import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hourify/contoler/app_catagories.dart';
import 'package:hourify/contoler/counter_storage.dart';
import 'package:hourify/features/home/widgets/hs_custom_app_color.dart';
import 'package:hourify/features/home/widgets/hs_custom_textstyle.dart';
import 'package:hourify/helper/app_bar_design/customappbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Home',style: Customappbar.customAppBarDesign,)),),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
          itemCount:AppCatagories.Catagories.length,
          itemBuilder: (context,index){

            String Catagori = AppCatagories.Catagories[index];
            final int totalSecond = CounterStorage.getTime(Catagori);
            final String formattedTime =
                '${(totalSecond ~/ 3600).toString().padLeft(2, '0')}:'
                '${((totalSecond % 3600) ~/ 60).toString().padLeft(2, '0')}:'
                '${(totalSecond % 60).toString().padLeft(2, '0')}';


            return   Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: HsAppColor.backgroudn,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(Catagori,
                        style: HsCustomTextstyle.headingText,
                    ),
                  ),
                  Divider(color: HsAppColor.borderColor,),
                  Expanded(child: Center(child: Text(formattedTime,style: HsCustomTextstyle.counterText,))),
                  SizedBox(height: 20,),

              ],),
                        ),
            );

          }


      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Image.asset('assets/profile_image.png',width: 200,height: 200,),
            Divider(color: Colors.black,),

            ListTile(
              title: Text('Today Report'),
              leading: Icon(Icons.report),
              onTap: (){},
            ),
            ListTile(
              title: Text('Weekly Report'),
              leading: Icon(Icons.report),
              onTap: (){},
            ),
            ListTile(
              title: Text('Monthly Report'),
              leading: Icon(Icons.report),
              onTap: (){},
            ),


          ],
        )
      ),
    );
  }
}
