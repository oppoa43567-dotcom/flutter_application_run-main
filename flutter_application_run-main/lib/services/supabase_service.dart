// file นี้ประกอบด้วน code คำสั่งที่ทำงานกับ  supabase
// เช่น upload file , add , delete ,search ข้อมูล, และอื่นๆ ที่เกี่ยวข้องกับการเชื่อมต่อกับ database ของ supabase
// ignore_for_file: unused_local_variable, duplicate_import, depend_on_referenced_packages, unused_import

import 'package:flutter_application_run/models/run.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  //***สิ่งสำคัญจะต้องสร้าง instance ที่จะทำงานกับ supabase
  final supabase = Supabase.instance.client;

  //--- ต่อจากนี้จะเป็น  method ที่จะทำงานกับ supabase
  // method upload file ที่อยู่ใน storage ของ supabase
  Future<String> uploadImageFile(XFile xfile) async {
    //ตั้งชื่อ file ให้ไม่ซ้ำกัน เวลาอยู่ บน bucket
    final newFileName =
        '${DateTime.now().millisecondsSinceEpoch}.${xfile.name}';

    //upload file
    await supabase.storage.from('run_bk').uploadBinary(
          newFileName,
          await xfile.readAsBytes(),
          fileOptions: FileOptions(contentType: xfile.mimeType),
        );

    //คืนค่าที่อยู่ของ file ใน bucket
    return supabase.storage.from('run_bk').getPublicUrl(newFileName);
  }

  // method เพิ่มข้อมูลลงใน table ของ supabase
  Future<void> insertRun(Run run) async {
    await supabase.from('run_td').insert(run.toJson());
  }
}
