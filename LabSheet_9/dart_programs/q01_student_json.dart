import 'dart:convert';

class Student {
  String name;
  int age;

  Student(this.name, this.age);

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(json['name'], json['age']);
  }
}

void main() {
  String data =
      '[{"name":"Aman","age":20},{"name":"Riya","age":21}]';

  List<Student> students = (jsonDecode(data) as List)
      .map((e) => Student.fromJson(e))
      .toList();

  for (var s in students) {
    print("${s.name} ${s.age}");
  }
}
