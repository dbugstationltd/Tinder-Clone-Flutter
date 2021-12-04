class Interest {
  final int id;
  final String interestName;

  Interest(this.id, this.interestName);

  factory Interest.fromJson(dynamic json) {
    return Interest(
      json['id'] as int,
      json['interestName'] as String,
    );
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.interestName} }';
  }
}
