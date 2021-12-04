class DiscoverUser {
  final int id;
  final String name;
  final String profile_pic;

  DiscoverUser(this.id, this.name, this.profile_pic);

  factory DiscoverUser.fromJson(dynamic json) {
    return DiscoverUser(
      json['id'] as int,
      json['name'] as String,
      json['profile_pic'] as String,
    );
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.profile_pic} }';
  }
}
