void main() {
  List<User> users = [
    User("Botir", "Saidov", "a"),
    User("Botir", "Saidov", "b"),
    User("Botir", "Saidov", "c"),
    User("Botir", "Saidov", "d"),
  ];

  int ohtarilganIndex = users.indexWhere((item) => item.id == "b");

  users[ohtarilganIndex] = users[ohtarilganIndex].copyWith(lastName: "Saidovv");

  print(users);
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
