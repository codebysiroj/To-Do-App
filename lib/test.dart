import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // List<User> users = [
  //   User("Botir", "Saidov", "a"),
  //   User("Botir", "Saidov", "b"),
  //   User("Botir", "Saidov", "c"),
  //   User("Botir", "Saidov", "d"),
  // ];
  //
  // int ohtarilganIndex = users.indexWhere((item) => item.id == "b");
  //
  // users[ohtarilganIndex] = users[ohtarilganIndex].copyWith(lastName: "Saidovv");
  //
  // print(users);



  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', 'JohnDoe');
    await prefs.setInt('age', 25);
    await prefs.setDouble('height', 5.9);
    await prefs.setBool('isDarkMode', true);
    await prefs.setStringList('hobbies', ['Reading', 'Gaming', 'Coding']);
  }


  Future<void> readData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('username');
    int? age = prefs.getInt('age');
    double? height = prefs.getDouble('height');
    bool? isDarkMode = prefs.getBool('isDarkMode');
    List<String>? hobbies = prefs.getStringList('hobbies');

    print('Username: $username');
    print('Age: $age');
    print('Height: $height');
    print('Dark Mode: $isDarkMode');
    print('Hobbies: $hobbies');
  }

  Future<void> removeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }


  Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }



  String json = """ 
  
  {
  "username": Muhammadrizo,
  "age": 25,
  "height": 5.9,
  }
  
  
  
  """;


 final String jsonFormat = jsonEncode(  {
    "username": "Muhammadrizo",
    "age": 25,
    "height": 5.9,
  });


 final Map formatted = jsonDecode(""" 
  
  {
  "username": Muhammadrizo,
  "age": 25,
  "height": 5.9,
  }
  
  
  
  """);









}





class User {
  final String id;
  final String firstName;
  final String lastName;

  User copyWith({String? firstName, String? lastName, String? id}) => User(
    firstName ?? this.firstName,
    lastName ?? this.lastName,
    id ?? this.id,
  );

  @override
  String toString() => "$firstName $lastName";

  const User(this.firstName, this.lastName, this.id);

}
