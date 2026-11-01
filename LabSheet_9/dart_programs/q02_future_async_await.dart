Future<String> getData() async {
  await Future.delayed(Duration(seconds: 2));
  return "Data Loaded";
}

void main() async {
  print("Loading...");
  String result = await getData();
  print(result);
}
