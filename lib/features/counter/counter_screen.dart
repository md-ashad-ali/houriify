import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hourify/contoler/app_catagories.dart';
import 'package:hourify/contoler/counter_storage.dart';
import 'package:hourify/contoler/counter_stroge_sf.dart';
import 'package:hourify/features/counter/widgets/catagori.dart';
import 'package:hourify/features/counter/widgets/cs_custom_app_color.dart';
import 'package:hourify/features/counter/widgets/cs_custom_button_style.dart';
import 'package:hourify/features/counter/widgets/cs_custom_textstyle.dart';
import 'package:hourify/helper/app_bar_design/customappbar.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with WidgetsBindingObserver {
  String selectedItem = 'Select Item';

  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  DateTime? _startTime;
  int _elapsedBeforePause = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _isRunning) {
      _updateSeconds();
    }
  }
  void _updateSeconds() {
    if (_startTime != null && _isRunning) {
      final now = DateTime.now();
      final difference = now.difference(_startTime!).inSeconds;
      setState(() {
        _seconds = _elapsedBeforePause + difference;
      });
    }
  }


  String _formateTime(int totalsecond){
    int hours = totalsecond ~/ 3600;
    int minutes = (totalsecond % 3600) ~/ 60;
    int seconds = totalsecond % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }


  void _startTimer() {
    if (selectedItem == 'Select Item') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an item first!'),
        ),
      );
      return;
    }

    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _startTime = DateTime.now();
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        setState(() {
          _seconds++;
        });
      },
    );
  }


  void _pauseTimer(){
    if(_timer != null && _timer!.isActive){
      _timer!.cancel();
      setState(() {
        _elapsedBeforePause = _seconds;
        _isRunning = false;
        _startTime = null;

      });
    }
  }

  void _resetTimer(){
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

void _saveData() async{
    if(selectedItem == 'Select Item'){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an item first!'))
      );
      return;
    }
    
    if(_seconds == 0){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No time to save!'))
      );
      return;
    }
    _timer?.cancel();

    await CounterStrogeSf.SvateTime(selectedItem, _seconds);

    CounterStorage.saveTime(selectedItem, _seconds);

    setState(() {
      _seconds= 0;
      _isRunning = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Svae Succesfully')));

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Counter',style: Customappbar.customAppBarDesign,)),),
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            SizedBox(height: 50,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width/1.5,
                height: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  color: CsCustomAppColor.appContainerColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text(_formateTime(_seconds),style: CsCustomTextstyle.timerCounterTextstyle,)),
              ),
            ),
            SizedBox(height: 30,),
//===================================>>Drawer Design<<=================================================================
          Container(
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(10),
              color: CsCustomAppColor.dropDownButtonColur
            ),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                  isExpanded: true,
                  value:  selectedItem == 'Select Item'
                      ? null
                      : selectedItem,
                  hint: const Text('Select Item'),
                  icon: const Icon(Icons.chevron_right),
                  items: AppCatagories.Catagories.map((String item){
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? value){
                    setState(() {
                      selectedItem = value!;
                    });
                  }
              ),
            ),
          ),

//========================================================================================================

            SizedBox(height: 30,),
            Column(
        
              children: [
                ElevatedButton(onPressed:_startTimer, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [ Icon(Icons.start),SizedBox(width: 7,),Text("Start")],),style: CsCustomButtonStyle.CustomButtonDesign,),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: _pauseTimer, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [ Icon(Icons.pause),SizedBox(width: 7,),Text("Pause")],),style: CsCustomButtonStyle.CustomButtonDesign,),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: _saveData, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [ Icon(Icons.save_alt),SizedBox(width: 7,),Text("Save")],),style: CsCustomButtonStyle.CustomButtonDesign,),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: _resetTimer, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [ Icon(Icons.lock_reset),SizedBox(width: 7,),Text("Reset")],),style: CsCustomButtonStyle.CustomButtonDesign,),

        
        
            ],)
        
          ],
        ),
      ),

    );
  }
}
