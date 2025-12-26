
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';
class validforget extends StatefulWidget {
  const validforget({super.key});

  @override
  State<validforget> createState() => _validforgetState();
}

class _validforgetState extends State<validforget> {
  TextEditingController forgetemail=TextEditingController();
  String ?validateforget(value){
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Padding(padding: EdgeInsets.all(20),child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child:Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey[100],
                ),
                padding: const EdgeInsets.all(6),
                child: GestureDetector(
                  child: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                )
            ),

          ),
          SizedBox(height: 120,),
   Column(
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       Text("Forget Password",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.black),),
       SizedBox(height: 8,),
       Text("Enter your email address to receive a reset link",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.grey),),
       Text("and regain access to ypur accout",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.grey),),
       SizedBox(height: 20,),
       TextFormField(
         controller: forgetemail,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         validator: validateforget,
         decoration: InputDecoration(
             labelText: "Forget Password",
             border: OutlineInputBorder()
         ),
       ),
       SizedBox(height: 20,),
       Container(
         width: double.infinity,
         height: 50,

         decoration: BoxDecoration(

         ),
         child:  ElevatedButton(
           style:ElevatedButton.styleFrom(
               backgroundColor: Colors.grey
           ) ,
           onPressed: ()async{
             var forget=forgetemail.text.trim();
             try{
               await FirebaseAuth.instance.sendPasswordResetEmail(email: forget).then((value)=>{
                 print("Email Sent"),
                 Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(builder: (context) => validsign()),
                 )

               });
             }on FirebaseAuthException catch(e){
               print("Error $e");
             }
           },
           child: Text("Confirm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
         ),
       ),

     ],
   )
        ],
      ),)),
    );
  }
}
