class DiscoverUser {
  final int id;
  final String name;
  final String profile_pic;
  final int birthdate;

  DiscoverUser(this.id, this.name, this.profile_pic, this.birthdate);

  factory DiscoverUser.fromJson(dynamic json) {
    return DiscoverUser(
      json['id'] as int,
      json['name'] as String,
      json['profile_pic'] as String,
      json['birthdate'] as int,
    );
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.profile_pic}, ${this.birthdate} }';
  }
}
