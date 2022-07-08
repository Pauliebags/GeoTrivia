import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
FirebaseAuth user =FirebaseAuth.instance;
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
        title: Text('Profile Screen'),
      ),
      body: StreamBuilder<dynamic>(
        //the root inside firestore
        stream: FirebaseFirestore.instance.collection('Users').doc(user.currentUser!.uid).snapshots(),
        /// you get the dat by the builder => snap
        builder:(context,dynamic snap){
          var data =snap.data!.data();
          print(data);
          return Column(
            children: [
          Text(data['UserName']),
              Text(data['UserPhone'].toString()),
              Text(data['UserEmail']),
            ],
          );
        },
      ),
    );
  }
}
