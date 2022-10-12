class Karyawan {
  Karyawan({
    this.idUser,
    this.namaUser,
    this.email,
    this.level,
    this.password,
    this.warehouse,
    this.statusKar,
  });
  String? idUser;
  String? namaUser;
  String? email;
  String? level;
  String? password;
  String? warehouse;
  String? statusKar;

  factory Karyawan.fromJson(Map<String, dynamic> json) => Karyawan(
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        email: json["email"],
        level: json["level"],
        password: json["password"],
        warehouse: json["warehouse"],
        statusKar: json["status_kar"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama_user": namaUser,
        "email": email,
        "level": level,
        "password": password,
        "warehouse": warehouse,
        "status_kar": statusKar,
      };
}
