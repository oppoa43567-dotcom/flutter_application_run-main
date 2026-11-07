// ignore_for_file: unused_import, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_run/views/add_run_ui.dart';

class ShowAllRunUI extends StatefulWidget {
  const ShowAllRunUI({super.key});

  @override
  State<ShowAllRunUI> createState() => _ShowAllRunUIState();
}

class _ShowAllRunUIState extends State<ShowAllRunUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBAr
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 11, 87),
        title: Text(
          'RUN TRACKER',
          style: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //เปิดหน้า add run ui แบบกลับได้
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRunUI(),
              //builder: (context) => const UpdateDeleteUI(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 16, 11, 87),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //body
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.cover,
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.025,
            // ),
            Text(
              'วิ่งกันเถอะ',
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: MediaQuery.of(context).size.height * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
