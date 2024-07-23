class User {
  final String name;
  final String email;
  bool confirmed;
  bool? receivedConfirmationEmail;
  bool? admin;

  User({
    required this.name,
    required this.email,
    required this.confirmed,
    required this.admin,
    required this.receivedConfirmationEmail,
  });
}
