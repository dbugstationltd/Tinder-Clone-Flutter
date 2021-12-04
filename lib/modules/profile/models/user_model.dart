class Profile {
  final String name;
  final String profileImageUrl;
  final String age;
  final String college;
  final List media;

  const Profile({
    required this.name,
    required this.profileImageUrl,
    required this.age,
    required this.college,
    required this.media,
  });
}

class User {
  final String name;
  final String profileImageUrl;
  final String age;
  final String college;

  const User({
    required this.name,
    required this.profileImageUrl,
    required this.age,
    required this.college,
  });
}

class ProfileUser {
  int id;
  String name;
  String aboutMe;
  String jobTitle;
  String company;
  String email;
  String contactNo;
  String latitude;
  String longitude;
  String facebookId;
  String instagramId;
  String school;
  String city;
  String gender;
  String profilePic;
  String preferedGenderSearch;
  int isVerified;
  int isBoosted;
  String boostedEndDate;
  int isBlocked;
  int visibleOnApp;
  String country;
  String lastActive;
  String createdAt;
  String updatedAt;
  List<UserPhotoLastThree> userPhotoLastThree;
  List<Interests> interests;

  ProfileUser({
    required this.id,
    required this.name,
    required this.aboutMe,
    required this.jobTitle,
    required this.company,
    required this.email,
    required this.contactNo,
    required this.latitude,
    required this.longitude,
    required this.facebookId,
    required this.instagramId,
    required this.school,
    required this.city,
    required this.gender,
    required this.profilePic,
    required this.preferedGenderSearch,
    required this.isVerified,
    required this.isBoosted,
    required this.boostedEndDate,
    required this.isBlocked,
    required this.visibleOnApp,
    required this.country,
    required this.lastActive,
    required this.createdAt,
    required this.updatedAt,
    required this.userPhotoLastThree,
    required this.interests,
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    var userPhoto = json['user_photo_last_three'] as List;
    var userInterest = json['interests'] as List;

    List<UserPhotoLastThree> photoList = userPhoto
        .map((tagJson) => UserPhotoLastThree.fromJson(tagJson))
        .toList();
    List<Interests> interestList =
        userInterest.map((tagJson) => Interests.fromJson(tagJson)).toList();
    return ProfileUser(
      id: json['id'],
      name: json['name'],
      aboutMe: json['aboutMe'],
      jobTitle: json['jobTitle'],
      company: json['company'],
      email: json['email'],
      contactNo: json['contactNo'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      facebookId: json['facebookId'],
      instagramId: json['instagramId'],
      school: json['school'],
      city: json['city'],
      gender: json['gender'],
      profilePic: json['profile_pic'],
      preferedGenderSearch: json['preferedGenderSearch'],
      isVerified: json['isVerified'],
      isBoosted: json['isBoosted'],
      boostedEndDate: json['boostedEndDate'],
      isBlocked: json['isBlocked'],
      visibleOnApp: json['visibleOnApp'],
      country: json['country'],
      lastActive: json['last_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userPhotoLastThree: photoList,
      interests: interestList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'aboutMe': aboutMe,
      'jobTitle': jobTitle,
      'company': company,
      'email': email,
      'contactNo': contactNo,
      'latitude': latitude,
      'longitude': longitude,
      'facebookId': facebookId,
      'instagramId': instagramId,
      'school': school,
      'city': city,
      'gender': gender,
      'profile_pic': profilePic,
      'preferedGenderSearch': preferedGenderSearch,
      'isVerified': isVerified,
      'isBoosted': isBoosted,
      'boostedEndDate': boostedEndDate,
      'isBlocked': isBlocked,
      'visibleOnApp': visibleOnApp,
      'country': country,
      'last_active': lastActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_photo_last_three': userPhotoLastThree,
      'interests': interests,
    };
  }
}

class UserPhotoLastThree {
  int id;
  int userId;
  String imageUrl;
  String createdAt;
  String updatedAt;

  UserPhotoLastThree({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserPhotoLastThree.fromJson(Map<String, dynamic> json) {
    return UserPhotoLastThree(
      id: json['id'],
      userId: json['userId'],
      imageUrl: json['imageUrl'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['imageUrl'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Interests {
  int id;
  String interestName;
  String createdAt;
  String updatedAt;
  // Pivot pivot;

  Interests({
    required this.id,
    required this.interestName,
    required this.createdAt,
    required this.updatedAt,
    // required this.pivot,
  });

  factory Interests.fromJson(Map<String, dynamic> json) {
    return Interests(
      id: json['id'],
      interestName: json['interestName'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      // pivot: json['pivot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "interestName": interestName,
      "created_at": createdAt,
      "updated_at": updatedAt,
      // "pivot": pivot.toJson(),
    };
  }
}

class Pivot {
  final int userId;
  final int interestId;

  Pivot({
    required this.userId,
    required this.interestId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json['user_id'],
      interestId: json['interestId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "interestId": interestId,
    };
  }
}
