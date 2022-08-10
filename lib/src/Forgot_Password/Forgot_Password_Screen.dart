import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../Questions/ui/shared/color.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>context.go('/signin'), icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text('Forgot Password'),
      ),
      backgroundColor: AppColor.pripmaryColor,
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/geotrivia.jpg',
                  width: 250.0, height: 250.0),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter YOur Email Address';
                        }
                      },
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  elevation: 5.0,
                  minWidth: 150.0,
                  height: 35,
                  color: Color(0xFF801E48),
                  onPressed: () async {
                    if (!formkey.currentState!.validate()) {
                      return;
                    }
                    formkey.currentState!.save();
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text)
                          .then((value) => context.go('/signin'));
                    } on FirebaseException catch (e) {
                      if (e.code == 'user-not-found') {
                      } else if (e.code == 'wrong-password') {
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: "An unknown error occured",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  },
                  child: Text('Forgot Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
