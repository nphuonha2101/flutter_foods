class AuthCredential {
  final String token;
  final int id;
  late final String username;
  final String userEmail;
  late final String userPhone;
  final String userAddress;
  late final String avatar;

  AuthCredential({
    required this.token,
    required this.id,
    required this.username,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
    required this.avatar,
  });

  factory AuthCredential.fromJson(Map<String, dynamic> json) {
    return AuthCredential(
      token: json['token'],
      id: json['id'],
      username: json['username'],
      userEmail: json['email'],
      userPhone: json['phone'],
      userAddress: json['address'],
      avatar: json['avatar'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'username': username,
      'email': userEmail,
      'phone': userPhone,
      'address': userAddress,
      'avatar': avatar,
    };
  }
}
