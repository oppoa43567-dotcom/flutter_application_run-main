class Run {
  //ตัวแปรล้อกับ column ในตาราง
  String? id;
  String? runWhere;
  String? runPerson;
  int? runDistance;
  String? runImageUrl;
  String? created_at;

  //constructor
  Run({
    this.id,
    this.runWhere,
    this.runPerson,
    this.runDistance,
    this.runImageUrl,
    this.created_at,
  });

  //แปลงข้อมูล จาก mobile เป็น json เพื่อส่งไป supabase
  Map<String, dynamic> toJson() => {
        "runWhere": runWhere as String,
        "runPerson": runPerson as String,
        "runDistance": runDistance as int,
        "runImageUrl": runImageUrl as String,
      };

  //แปลงข้อมูล จาก json  ใน supabase เป็น object ใน mobile
  factory Run.fromJson(Map<String, dynamic> json) => Run(
        id: json["id"] as String,
        runWhere: json["runWhere"] as String,
        runPerson: json["runPerson"] as String,
        runDistance: json["runDistance"] as int,
        runImageUrl: json["runImageUrl"] as String,
        created_at: json["created_at"] as String,
      );
}
