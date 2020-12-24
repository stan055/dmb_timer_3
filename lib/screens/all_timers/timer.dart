class Timer {
  int id;
  String name;
  int start;
  int end;

  Timer(this.id, this.name, this.start, this.end);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'start': start,
      'end': end
    };

    return map;
  }

  Timer.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    start = map['start'];
    end = map['end'];
  }
}
