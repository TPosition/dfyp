// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final double balance;
  final String displayName;
  final String email;
  final String mobile;
  final String photoURL;
  final String address;
  final String gender;
  final String fname;
  final String lname;
  final String nationality;
  final String passport;
  final String country;
  final String postCode;
  final String city;
  final String province;
  final String marital;

  const UserEntity({
    required this.uid,
    required this.balance,
    required this.displayName,
    required this.email,
    required this.mobile,
    required this.photoURL,
    required this.address,
    required this.gender,
    required this.fname,
    required this.lname,
    required this.nationality,
    required this.passport,
    required this.country,
    required this.postCode,
    required this.city,
    required this.province,
    required this.marital,
  });

  Map<String, Object?> toJson() => {
        'uid': uid,
        'balance': balance,
        'displayName': displayName,
        'email': email,
        'mobile': mobile,
        'photoURL': photoURL,
        "address": address,
        'gender': gender,
        'fname': fname,
        'lname': lname,
        'nationality': nationality,
        'passport': passport,
        'country': country,
        'postCode': postCode,
        'city': city,
        'province': province,
        'marital': marital,
      };

  @override
  List<Object?> get props => [
        uid,
        balance,
        displayName,
        email,
        mobile,
        photoURL,
        address,
        gender,
        fname,
        lname,
        nationality,
        passport,
        country,
        postCode,
        city,
        province,
        marital,
      ];

  @override
  String toString() =>
      'UserEntity {uid: $uid,balance: $balance,displayName: $displayName,email: $email,mobile: $mobile,photoURL: $photoURL}';

  static UserEntity fromJson(final Map<String, Object> json) => UserEntity(
        uid: json['uid'] as String,
        balance: json['balance'] as double,
        displayName: json['displayName'] as String,
        email: json['email'] as String,
        mobile: json['mobile'] as String,
        photoURL: json['photoURL'] as String,
        address: json['address'] as String,
        gender: json['gender'] as String,
        fname: json['fname'] as String,
        lname: json['lname'] as String,
        nationality: json['nationality'] as String,
        passport: json['passport'] as String,
        country: json['country'] as String,
        postCode: json['postCode'] as String,
        city: json['city'] as String,
        province: json['province'] as String,
        marital: json['marital'] as String,
      );

  static UserEntity fromSnapshot(final DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return UserEntity(
      uid: data['uid'],
      balance: data['balance'],
      displayName: data['displayName'],
      email: data['email'],
      mobile: data['mobile'],
      photoURL: data['photoURL'],
      address: data['address'],
      gender: data['gender'],
      fname: data['fname'],
      lname: data['lname'],
      nationality: data['nationality'],
      passport: data['passport'],
      country: data['country'],
      postCode: data['postCode'],
      city: data['city'],
      province: data['province'],
      marital: data['marital'],
    );
  }

  Map<String, Object?> toDocument() => {
        'uid': uid,
        'balance': balance,
        'displayName': displayName,
        'email': email,
        'mobile': mobile,
        'photoURL': photoURL,
        'address': address,
        'gender': gender,
        'fname': fname,
        'lname': lname,
        'nationality': nationality,
        'passport': passport,
        'country': country,
        'postCode': postCode,
        'city': city,
        'province': province,
        'marital': marital,
      };
}
