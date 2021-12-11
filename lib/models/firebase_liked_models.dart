class Liked {
  final int likedBy;
  final int likedTo;
  final DateTime date;

  Liked(this.likedBy, this.likedTo, this.date);

  Liked.fromJson(Map<dynamic, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        likedBy = json['likedBy'] as int, likedTo = json['likedTo'] as int;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'date': date.toString(),
        'likedBy': likedBy,
        'likedTo': likedTo,
      };
}
