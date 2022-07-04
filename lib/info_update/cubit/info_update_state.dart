part of 'info_update_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class InfoUpdateState extends Equatable {
  const InfoUpdateState({
    final this.displayName = '',
    final this.mobile = '',
    final this.status = FormzStatus.pure,
    final this.hasImage = false,
    final this.address = '',
    final this.gender = 'Male',
    final this.fname = '',
    final this.lname = '',
    final this.nationality = 'Malaysian',
    final this.passport = '',
    final this.country = '',
    final this.postCode = '',
    final this.city = '',
    final this.province = '',
    final this.marital = 'Single',
  });

  final String displayName;
  final String mobile;
  final FormzStatus status;
  final bool hasImage;
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

  @override
  List<Object> get props => [
        displayName,
        mobile,
        status,
        hasImage,
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

  InfoUpdateState copyWith({
    final String? displayName,
    final String? mobile,
    final FormzStatus? status,
    final bool? hasImage,
    final String? address,
    final String? gender,
    final String? fname,
    final String? lname,
    final String? nationality,
    final String? passport,
    final String? country,
    final String? postCode,
    final String? city,
    final String? province,
    final String? marital,
  }) =>
      InfoUpdateState(
        displayName: displayName ?? this.displayName,
        mobile: mobile ?? this.mobile,
        status: status ?? this.status,
        hasImage: hasImage ?? this.hasImage,
        address: address ?? this.address,
        gender: gender ?? this.gender,
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        nationality: nationality ?? this.nationality,
        passport: passport ?? this.passport,
        country: country ?? this.country,
        postCode: postCode ?? this.postCode,
        city: city ?? this.city,
        province: province ?? this.province,
        marital: marital ?? this.marital,
      );
}
