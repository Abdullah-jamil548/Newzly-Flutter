import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';

class splash extends StatefulWidget {
  const splash({super.key});
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewFirst()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 250,),
            Center(
              child: Container(
                width: 230,
                height: 230,
                child: Image(image: AssetImage("Assets/newloggo.png"),),
              ),
            ),
            SizedBox(height:200,),
            Text("Powered By",style:GoogleFonts.poppins(color: Colors.grey,fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("CBLOCK SOLUTION ",style:GoogleFonts.poppins(color: Colors.grey,fontWeight: FontWeight.bold),),
                Icon(Icons.do_not_disturb_on_total_silence_outlined,size: 16,color: Colors.grey,),
                Text(" 2025",style:GoogleFonts.poppins(color: Colors.grey,fontWeight: FontWeight.bold),),
              ],
            )
          ],
        ),
      ),
    )
    ;
  }
}