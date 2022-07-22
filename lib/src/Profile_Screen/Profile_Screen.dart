import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game_template/src/Questions/ui/shared/color.dart';
import 'package:go_router/go_router.dart';

FirebaseAuth user = FirebaseAuth.instance;
String? userName;
String? userPhone;
String? userEmail;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.pripmaryColor,
        centerTitle: true,
        title: Text('Profile Screen'),
      ),
      backgroundColor: AppColor.pripmaryColor,
      body: StreamBuilder<dynamic>(
        //the root inside firestore
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(user.currentUser!.uid)
            .snapshots(),

        /// you get the dat by the builder => snap
        builder: (context, dynamic snap) {
          var data = snap.data!.data();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
              //  Text(data['CountryCode'],style: TextStyle(color: Colors.white),),
                SizedBox(height: 5),
                // Flag.fromString(
                //   data['CountryCode'],
                //   height: 150,
                //   fit: BoxFit.fill,
                // ),
                Text(
                  'Full Name',
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
                            return 'Please Enter your email address';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            userName = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: data['UserName'],
                          hintStyle: TextStyle(color: Colors.black),
                          filled: true,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ),

                Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
                            return 'Please Enter your email address';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            userEmail = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: data['UserEmail'],
                          hintStyle: TextStyle(color: Colors.black),
                          filled: true,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    context.go('/signin');
                  },
                  child: Text('Sign Out'),
                  color: Colors.red,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
