class Run {
  //ตัวแปรล้อกับคอลัมน์ในตาราง
  String? id;
  String? created_at;
  String? runWhere;
  String? runPerson;
  int? runDistance;
  String? runImageUrl;

  //Constructor
  Run({
    this.id,
    this.created_at,
    this.runWhere,
    this.runPerson,
    this.runDistance,
    this.runImageUrl,
  });

  //การแปลงข้อมูลฝั่ง mobile เป็น JSON เพื่อส่งไปยัง  Supaabase : toJson
  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": created_at,
        "runWhere": runWhere,
        "runPerson": runPerson,
        "runDistance": runDistance,
        "runImageUrl": runImageUrl,
      };
  //การแปลงข้อมูลฝั่ง Supabase เป็น mobile : fromJson
  factory Run.fromJson(Map<String, dynamic> json) => Run(
        id: json['id'],
        created_at: json['created_at'],
        runWhere: json['runWhere'],
        runPerson: json['runPerson'],
        runDistance: json['runDistance'],
        runImageUrl: json['runImageUrl'],
      );
}
