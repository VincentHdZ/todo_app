class Todo {
  final int id;
  final String title;
  bool isChecked = false;

  Todo({
    this.id,
    this.title,
    this.isChecked,
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['isChecked'] = isChecked == true ? 1 : 0;

    return map;
  }
}
