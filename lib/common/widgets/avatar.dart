import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({final Key? key, final this.photo, final this.avatarSize = 32.0})
      : super(key: key);

  final String? photo;
  final double avatarSize;

  @override
  Widget build(final BuildContext context) {
    final photo = this.photo;
    return CircleAvatar(
      radius: avatarSize,
      backgroundImage: photo != null ? NetworkImage(photo) : null,
      child:
          photo == null ? Icon(Icons.person_outline, size: avatarSize) : null,
    );
  }
}
