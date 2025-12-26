import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newspaper/Auth/forgetpassword_screen.dart';
import 'package:newspaper/view/home_screen.dart';
import 'Signup_screen.dart';
class validsign extends StatefulWidget {
  const validsign({super.key});
  @override
  State<validsign> createState() => _validsignState();
}
class _validsignState extends State<validsign> {
  TextEditingController useremail=TextEditingController();
  TextEditingController userpassword=TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
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
                  SizedBox(height: 120,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(" Login In",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.black),),
                      SizedBox(height: 8,),
                      Text("Enter your email and password to securely access",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.grey),),
                      Text("your account and manage your services",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.grey),),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: useremail,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateemail,
                        decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: userpassword,
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
                      SizedBox(height: 7,),
                      Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: GestureDetector(
                            child: Text("Forget Password",style: TextStyle(color: Colors.black),),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>validforget()));
                            },
                          )
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: double.infinity,
                        height: 50,

                        decoration: BoxDecoration(

                        ),
                        child: ElevatedButton(
                          style:ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey
                          ) ,
                          onPressed: ()async{
                            _submitForm();
                            var logoinemail=useremail.text.trim();
                            var loginpassword=userpassword.text.trim();
                            try{
                              final User? firebaseuser=(await FirebaseAuth.instance.signInWithEmailAndPassword(email: logoinemail, password: loginpassword)).user;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login Successfully")),
                              );

                              formKey.currentState!.reset();

                              useremail.clear();
                              userpassword.clear();
                              if(firebaseuser!=null)
                              {
                                Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) =>NewFirst() ),
                                );

                              }
                              else{
                                print("Check Email and Password");
                              }
                            }on FirebaseAuthException catch(e){
                              print("Error $e");
                            }
                          }, child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
                        ),

                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>validlogin()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",style: GoogleFonts.poppins(color: Colors.grey),),
                              Text("Sign Up here",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold),),
                            ],
                          )
                      ),

                    ],
                  )
                ],
              ),))),
      )
    );
  }
}