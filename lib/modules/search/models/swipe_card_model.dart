import 'package:loveria/models/models.dart';

class SwipeUser {
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

  SwipeUser({
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

  factory SwipeUser.fromJson(Map<String, dynamic> json) {
    var userPhoto = json['user_photo_last_three'] as List;
    var userInterest = json['interests'] as List;

    List<UserPhotoLastThree> photoList = userPhoto
        .map((tagJson) => UserPhotoLastThree.fromJson(tagJson))
        .toList();
    List<Interests> interestList =
        userInterest.map((tagJson) => Interests.fromJson(tagJson)).toList();
    return SwipeUser(
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
