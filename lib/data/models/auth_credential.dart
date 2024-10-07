class AuthCredential {
  final String token;
  final String username;
  final String userFullName;
  final String userEmail;

  AuthCredential({
    required this.token,
    required this.username,
    required this.userFullName,
    required this.userEmail,
  });

  String toJson() {
    return {
      'token': token,
      'username': username,
      'userFullName': userFullName,
      'userEmail': userEmail,
    }.toString();
  }
}
