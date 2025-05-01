import 'dart:convert';

class Token {
  final String access;
  final String refresh;

  const Token({
    required this.access,
    required this.refresh,
  });

  Map<String, dynamic> toMap() {
    return {
      'access': access,
      'refresh': refresh,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      access: map['access'] ?? '',
      refresh: map['refresh'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) => Token.fromMap(json.decode(source));
}