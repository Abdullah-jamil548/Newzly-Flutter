import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
class validlogin extends StatefulWidget {
  const validlogin({super.key});
  @override
  State<validlogin> createState() => _validloginState();
}
class _validloginState extends State<validlogin> {
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  TextEditingController usernamefirst=TextEditingController();
  TextEditingController useremailfirst=TextEditingController();
  TextEditingController userpaswordfirst=TextEditingController();
  User? currentuser=FirebaseAuth.instance.currentUser;

  void _submitForm() {
    if (formKey.currentState!.validate()) {
    }
  }
  String ?validateemail(value){
    if (value == null || value.isEmpty) {
      return "Please enter email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }

  }
  String ?validatepassword(value){
    if (value == null || value.isEmpty) {
      return "Please enter password";
    }
  }
  String ?username(value){
    if (value == null || value.isEmpty) {
      return "Please enter username";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(padding: EdgeInsets.all(20),child: Form(
              key: formKey,
              child: Column(
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
                  SizedBox(height: 100,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Create Account",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.black),),
                      Text("Fill your information below or register",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey),),
                      Text("with your social account",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey),),

                      SizedBox(height: 40,),
                      TextFormField(
                        controller: usernamefirst,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: username,
                        decoration: InputDecoration(
                            labelText: "Usename",
                            border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: useremailfirst,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateemail,
                        decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller:userpaswordfirst,
                        obscureText: obscureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validatepassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText ? Icons.visibility_off : Icons.visibility,
                              ), onPressed: () {
                              setState(() {
                                obscureText=!obscureText;
                              });
                            },
                            ),
                            labelText: "Password",
                            border: OutlineInputBorder()

                        ),

                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        obscureText: obscureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validatepassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText ? Icons.visibility_off : Icons.visibility,
                              ), onPressed: () {
                              setState(() {
                                obscureText=!obscureText;
                              });
                            },
                            ),
                            labelText:"Confirm Password",
                            border: OutlineInputBorder()
                        ),

                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                        ),
                        child: ElevatedButton(
                          child: Text("Sign up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
                          style:ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey
                          ) ,
                          onPressed: () async {
                            _submitForm();

                            var namefirst = usernamefirst.text.trim();
                            var emailfirst = useremailfirst.text.trim();
                            var passwordfirst = userpaswordfirst.text.trim();

                            try {
                              // Step 1: Create user in Firebase Auth
                              UserCredential userCredential =
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: emailfirst,
                                password: passwordfirst,
                              );

                              User? newUser = userCredential.user;
                              await FirebaseFirestore.instance
                                  .collection("newusers")
                                  .doc(newUser!.uid)
                                  .set({
                                'userName': namefirst,
                                'userEmail': emailfirst,
                                'createdAt': DateTime.now(),
                                'userid': newUser.uid,
                              });

                              log("User Created Successfully");

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Account Created Successfully!")),
                              );

                              // Step 3: Clear fields
                              formKey.currentState!.reset();
                              usernamefirst.clear();
                              useremailfirst.clear();
                              userpaswordfirst.clear();

                            } on FirebaseAuthException catch (e) {
                              print("FirebaseAuth Error: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: ${e.message}")),
                              );
                            } catch (e) {
                              print("General Error: $e");
                            }
                          }, 
                        ),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>validsign()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have account? ",style: GoogleFonts.poppins(color: Colors.grey),),
                              Text("Sign In",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold),),

                            ],
                          )
                      ),
                      SizedBox(height: 20,),
                    ],
                  )
                ],
              ),))),
      )
    );
  }
}
