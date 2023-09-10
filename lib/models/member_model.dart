class Member {
  late String id;
  final String fullName;
  final String email;
  final String avatarUrl;

  Member({
    this.id = '0',
    required this.fullName,
    required this.email,
    required this.avatarUrl,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
