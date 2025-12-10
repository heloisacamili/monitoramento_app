class AlertModel {
  final int? id;
  final String type;
  final String time;

  AlertModel({this.id, required this.type, required this.time});

  Map<String, dynamic> toMap() {
    return {'id': id, 'type': type, 'time': time};
  }

  factory AlertModel.fromMap(Map<String, dynamic> map) {
    return AlertModel(
      id: map['id'],
      type: map['type'],
      time: map['time'],
    );
  }
}