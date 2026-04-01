import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signup extends StatefulWidget{
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController fullname = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  final FirebaseFirestore fi = FirebaseFirestore.instance;

  Future<bool> addUser() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await fi.collection("user").doc(userCredential.user!.uid).set({
        "fullname": fullname.text.trim(),
        "email": emailController.text.trim(),
        "uid": userCredential.user!.uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account Created Successfully",style: TextStyle(fontSize: 17),),backgroundColor: Colors.green,),
      );
      print("User Registered Successfully ✅");
      return true;

    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        print("Email already exists");
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Password is too weak"),
              backgroundColor: Colors.red,
            ),
        );
      } else {
        print("Auth Error: ${e.message}");
      }
      return false;

    } catch (e) {
      print("Error storing data: $e");
      return false;
    }
  } //Database

 /* Future<void> saveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("fullname", fullname.text);
    await prefs.setString("email", emailController.text);
    await prefs.setString("password", passwordController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Account Created Successfully")),
    );
  }*/ //Shared Preferences

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.only(right: 25,left: 25),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                    tag: "logo",
                    child: Image.asset("assets/image/logo.png",width: 250,)), //Logo
                Text(" Create your Account",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                Text("Start your journey to solution",style: TextStyle(fontSize: 17,color: Colors.tealAccent.shade700),),
                SizedBox(height: 40,),
                TextField(
                  controller: fullname,
                  cursorColor: Colors.teal[300],
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hint: Text("Fullname",style: TextStyle(color: Colors.grey,fontSize: 15)),
                      suffixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20))
                  ),
                ),//Fullname
                SizedBox(height: 20,),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.teal[300],
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hint: Text("Email",style: TextStyle(color: Colors.grey,fontSize: 15)),
                      suffixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20))
                  ),
                ),//Email
                SizedBox(height: 20,),
                TextField(
                  controller: passwordController,
                  obscureText: isObscure,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.teal[300],
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hint: Text("Password",style: TextStyle(color: Colors.grey,fontSize: 15)),
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      }, icon: isObscure? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20))
                  ),
                ), //Password
                SizedBox(height: 40,),
                Hero(
                  tag: "button",
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.amber[400]!,
                            Colors.amber[600]!,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(onPressed: ()async{
                      HapticFeedback.lightImpact();
                      if (fullname.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("All fields are required"),backgroundColor: Colors.red,),
                        );
                        return;
                      }
                        bool success = await addUser();
                        if (success) {
                          Navigator.pushNamed(context, "/l");
                      };
                    },
                      child: Text("Sign up",style: TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,shadowColor: Colors.transparent,elevation: 1,),
                    ),
                  ),
                ), //Signup Button
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    InkWell(onTap: (){
                      Navigator.pushNamed(context, "/l");
                    },
                        child: Text(" Login",style: TextStyle(fontSize: 15,color: Colors.teal[300],fontWeight: FontWeight.bold),))
                  ],
                ) //Login Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}