import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/signin/sign_in_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final formkey=GlobalKey<FormState>();
TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController confirmpassword = TextEditingController();
TextEditingController emailaddress = TextEditingController();
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth user =FirebaseAuth.instance;
RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
//A function that validate user entered password
bool validatePassword(String pass){
  String _password = pass.trim();
  if(pass_valid.hasMatch(_password)){
    return true;
  }else{
    return false;
  }
}
class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Account'),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            /// username
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter your username';
                }
              },
              controller: username,
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(color: Colors.red),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.name,
            ),

            /// password
            TextFormField( validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter your password';
              }else{
                //call function to check password
                bool result = validatePassword(value);
                if(result){
                  // create account event
                  return null;
                }else{
                  return " Password should contain Capital, small letter & Number & Special";
                }
              }
            },
              controller: password,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.red),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),

            /// confirm password
            TextFormField( validator: (value) {

              if(value!.isEmpty){
                return 'Please Enter password';
              }
              if (value!=password.text) {
                return 'Password does not match';
              }
            },
              controller: confirmpassword,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                hintStyle: TextStyle(color: Colors.red),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),

            /// email address
            TextFormField( validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter your email address';
              }
            },
              controller: emailaddress,
              decoration: InputDecoration(
                hintText: 'Email Address',
                hintStyle: TextStyle(color: Colors.red),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            ///gender /// bithdate bouns
            //// Button for save value
            MaterialButton(
              onPressed: () async{
                if(!formkey.currentState!.validate()){
                  return;
                }
                formkey.currentState!.save();
              await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailaddress.text, password: confirmpassword.text);
                firestore.collection('Users').doc(user.currentUser!.uid).set({
                  'UserName':username.text,
                  'UserEmail':emailaddress.text,
                  'UserPhone':123456,
                });
                //// after save the value go to main screen (the root)
                //// use Go_Router Function to go to this screen
                context.go('/');
               //// home work forogt password screen-try to
                ///solve password and confirm password
                /// gender and birthdate to create screen this one bounce


              },
              child: Text('Create New Account'),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
// how firebase work with flutter
