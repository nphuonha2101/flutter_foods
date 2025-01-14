class AuthCredential {
  final String token;
  final int id;
  final String username;
  final String userEmail;
  final String userPhone;
  final String userAddress;
  final String avatar;

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
      id: json['user']['id'],
      username: json['user']['username'],
      userEmail: json['user']['email'],
      userPhone: json['user']['phone'],
      userAddress: json['user']['address'],
      avatar: json['user']['avatar'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': {
        'id': id,
        'username': username,
        'email': userEmail,
        'phone': userPhone,
        'address': userAddress,
        'avatar': avatar,
      },
    };
  }
}
