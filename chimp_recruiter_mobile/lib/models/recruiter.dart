class Recruiter {
  final String name;
  final int id;

  Recruiter({required this.name, required this.id});

  factory Recruiter.fromJson(Map<String, dynamic> json) {
    return Recruiter(
      name: json['name'],
      id: json['id'],
    );
  }
}
