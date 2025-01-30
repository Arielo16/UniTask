class LoginResponse {
  final String message;

  LoginResponse({required this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
    );
  }
}
