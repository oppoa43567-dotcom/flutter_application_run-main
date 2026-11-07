// ignore_for_file: unused_local_variable, use_build_context_synchronously, sort_child_properties_last, empty_statements

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_run/models/run.dart';
import 'package:flutter_application_run/services/supabase_service.dart';
import 'package:image_picker/image_picker.dart';

class AddRunUI extends StatefulWidget {
  const AddRunUI({super.key});

  @override
  State<AddRunUI> createState() => _AddRunUIState();
}

class _AddRunUIState extends State<AddRunUI> {
  //----ส่วนของ code ที่เกียวกับ กล้อง , แกลลอรี่ และ
  Uint8List? imageBytes; //เอาไว้เก็บรูป เพื่อแสดงที่หน้าจอ
  XFile? imageFile; //เอาไว้เก็บรูป เพื่อ upload to bucket

  //เปิดกล้อง
  Future<void> selectImageFromCamera() async {
    imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);

    //ตรวจสอบว่าได้เลือกมั้ย
    if (imageFile != null) {
      final byte = await imageFile!.readAsBytes();
      setState(() {
        imageBytes = byte;
      });
    }
  }

  //เปิดแกลลอรี่
  Future<void> selectImageFromGallery() async {
    imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    //ตรวจสอบว่าได้เลือกมั้ย
    if (imageFile != null) {
      final byte = await imageFile!.readAsBytes();
      setState(() {
        imageBytes = byte;
      });
    }
  }

  //----ส่วนของ code upload and save

  //ตัวแปรเก็บ file ที่ upload
  String imageURL = "";
  //สร้างตัวควบคุม textfield
  TextEditingController runWhereCtrl = TextEditingController();
  TextEditingController runPersonCtrl = TextEditingController();
  TextEditingController runDistanceCtrl = TextEditingController();

  Future<void> uploadAndSaveData() async {
    //ตรวจสอบว่าได้เลือกfileมั้ย
    if (imageFile != null) {
      imageURL = await SupabaseService().uploadImageFile(imageFile!);
    }
    //save data to table (run_td)
    //validate ว่า user ป้อนยัง
    if (runWhereCtrl.text.isEmpty ||
        runPersonCtrl.text.isEmpty ||
        runDistanceCtrl.text.isEmpty) {
      //อันไหนว่าง เตือน
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚠ กรุณากรอกข้อมูลให้ครบถ้วน'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // ผ่าน validate มา ก็ pack data เพื่อส่งไป table
    Run runData = Run(
      runWhere: runWhereCtrl.text,
      runPerson: runPersonCtrl.text,
      runDistance: int.parse(runDistanceCtrl.text),
      runImageUrl: imageURL,
    );
    //ส่ง data to table
    await SupabaseService().insertRun(runData);
    //แจ้งเตือน
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ บันทึกข้อมูลเรียบร้อย'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
    //กลับไปหน้า ShowAllRun
    Navigator.pop(context);
  }
  //-------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 11, 87),
        title: Text(
          'RUN TRACKER (เพิ่ม)',
          style: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            top: 50,
            bottom: 50,
            left: 45,
            right: 45,
          ),
          child: Center(
            child: Column(
              children: [
                imageBytes == null
                    ? InkWell(
                        onTap: () {
                          selectImageFromGallery();
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          size: MediaQuery.of(context).size.width * 0.35,
                          color: Colors.grey,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          selectImageFromGallery();
                        },
                        child: Image.memory(
                          imageBytes!,
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'วิ่งที่ไหน',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: runWhereCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'เช่น สวนหลวง...',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'วิ่งกับใคร',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: runPersonCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'เช่น เพื่อน...',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ระยะทาง (กิโลเมตร)',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: runDistanceCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'เช่น 5 , 10 , 15 ...',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () {
                    //upload รูป ไปยัง bucket และบันทึก ลง table
                    //แต่ code มันยาว ขอทำ method ฃื่อ uploadAndSaveData ไว้ด้านบน
                    uploadAndSaveData();
                  },
                  child: Text(
                    'บันทึกข้อมูล',
                    style: TextStyle(
                      color: Colors.white,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 24, 179, 10),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      55.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(
                      color: Colors.white,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 231, 40, 15),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      55.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
