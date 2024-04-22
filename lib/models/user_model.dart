// import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String email;
  final String name;
  final List<String> followers;
  final List<String> following;
  final String profilePicture;
  final String bannerPicture;
  final String uid;
  final String bio;
  final bool isTwitterBlue;

  const UserModel({
    required this.email,
    required this.name,
    required this.followers,
    required this.following,
    required this.profilePicture,
    required this.bannerPicture,
    required this.uid,
    required this.bio,
    required this.isTwitterBlue,
  });

  UserModel copyWith({
    String? email,
    String? name,
    List<String>? followers,
    List<String>? following,
    String? profilePicture,
    String? bannerPicture,
    String? uid,
    String? bio,
    bool? isTwitterBlue,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      profilePicture: profilePicture ?? this.profilePicture,
      bannerPicture: bannerPicture ?? this.bannerPicture,
      uid: uid ?? this.uid,
      bio: bio ?? this.bio,
      isTwitterBlue: isTwitterBlue ?? this.isTwitterBlue,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'followers': followers});
    result.addAll({'following': following});
    result.addAll({'profilePicture': profilePicture});
    result.addAll({'bannerPicture': bannerPicture});
    result.addAll({'bio': bio});
    result.addAll({'isTwitterBlue': isTwitterBlue});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
      profilePicture: map['profilePicture'] ?? '',
      bannerPicture: map['bannerPicture'] ?? '',
      uid: map['\$id'] ?? '',
      bio: map['bio'] ?? '',
      isTwitterBlue: map['isTwitterBlue'] ?? false,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, followers: $followers, following: $following, profilePicture: $profilePicture, bannerPicture: $bannerPicture, uid: $uid, bio: $bio, isTwitterBlue: $isTwitterBlue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UserModel &&
        other.email == email &&
        other.name == name &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following) &&
        other.profilePicture == profilePicture &&
        other.bannerPicture == bannerPicture &&
        other.uid == uid &&
        other.bio == bio &&
        other.isTwitterBlue == isTwitterBlue;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        profilePicture.hashCode ^
        bannerPicture.hashCode ^
        uid.hashCode ^
        bio.hashCode ^
        isTwitterBlue.hashCode;
  }
}
