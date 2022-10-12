class Handover {
  Handover({
    this.idHandover,
    this.listItem,
    this.driver,
    this.foto,
    this.tandatangan,
    this.status,
    this.warehouse,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? idHandover;
  String? listItem;
  String? driver;
  String? foto;
  String? tandatangan;
  String? status;
  String? warehouse;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory Handover.fromJson(Map<String, dynamic> json) => Handover(
        idHandover: json["id_handover"],
        listItem: json["listItem"],
        driver: json["driver"],
        foto: json["foto"],
        tandatangan: json["tandatangan"],
        status: json["status"],
        warehouse: json["warehouse"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_handover": idHandover,
        "listItem": listItem,
        "driver": driver,
        "foto": foto,
        "tandatangan": tandatangan,
        "status": status,
        "warehouse": warehouse,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}

class Todo {
  String? text;
  bool done;

  Todo({this.text, this.done = false});

  factory Todo.fromJson(Map<String, dynamic> json) =>
      Todo(text: json['text'], done: json['done']);

  Map<String, dynamic> toJson() => {'text': text, 'done': done};
}
