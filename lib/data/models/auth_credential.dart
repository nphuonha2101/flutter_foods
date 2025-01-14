class AuthCredential {
  final String token;
  final String username;
  final String userEmail;
  final String userPhone;
  final String userAddress;
  final String avatar;

  AuthCredential({
    required this.token,
    required this.username,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
    required this.avatar,
  });

  factory AuthCredential.fromJson(Map<String, dynamic> json) {
    return AuthCredential(
      token: json['token'],
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
      'username': username,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userAddress': userAddress,
      'avatar': avatar,
    };
  }
}
