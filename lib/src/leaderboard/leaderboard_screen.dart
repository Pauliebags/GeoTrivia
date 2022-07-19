import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Questions/ui/shared/color.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.pripmaryColor,
        centerTitle: true,
        title: Text('LeaderBoard'),
      ),
      body: StreamBuilder<Object>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, dynamic snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          var data = snap.data.docs.toList();
          return DataTable(columnSpacing: 170, dataRowHeight: 100, columns: [
            DataColumn(
                label: Text(
              'Name',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )),
            DataColumn(
                label: Text(
              'Score',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )),
          ], rows: [
            for (int i = 0; i < data.length; i++)
              DataRow(cells: [
                DataCell(
                  Text(data[i]['UserName']),
                ),
                DataCell(Text(data[i]['Point'].toString())),
              ])
          ]);
        },
      ),
    );
  }
}
