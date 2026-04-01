import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_patch/home.dart';

class login extends StatefulWidget{
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool isObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore fi = FirebaseFirestore.instance;

  Future<String?> loginUser() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful",style: TextStyle(fontSize: 17),),backgroundColor: Colors.green,),
      );

      // Fetch fullname from Firestore
      DocumentSnapshot doc = await fi
          .collection("user")
          .doc(userCredential.user!.uid)
          .get();

      String name = doc["fullname"];

      return name; // ✅ return name if success

    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid Email or Password"),
          backgroundColor: Colors.red,
        ),
      );

      return null; //Login failed
    }
  } //Login Validation

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
                SizedBox(height: 30,),
                Hero(
                  tag: "logo",
                  child: Image.asset("assets/image/logo.png",width: 250,)), //Logo
                Text("Welcome Back!",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                Text("Your daily dose of solutions",style: TextStyle(fontSize: 17,color: Colors.tealAccent.shade700),),
                SizedBox(height: 40,),
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
                  ),//Password
                SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10,),
                    Text("Forgot Password?",style: TextStyle(fontSize: 15),),
                  ],
                ),//Forget Password
                SizedBox(height: 20,),
                Hero(
                  tag: "button",
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(onPressed: () async {
                      HapticFeedback.lightImpact();
                      String? name = await loginUser();
                      if (name != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => home(username: name),
                          ),
                        );
                      }
                    },
                      child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[300],elevation: 1,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      ),
                  ),
                ),//Login Button
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account? "),
                    InkWell(onTap: (){
                      Navigator.pushNamed(context, "/s");
                    },
                    child: Text(" Sign up",style: TextStyle(fontSize: 15,color: Colors.teal[300],fontWeight: FontWeight.bold),))
                  ],
                )//Sign Up
              ],
            ),
          ),
        ),
      ),
    );
  }
}