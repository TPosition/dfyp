import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/auth_select/auth_select.dart';
import 'package:flutter_firebase_login/common/widgets/bottom_nav_bar.dart';
import 'package:flutter_firebase_login/info_update/view/view.dart';

List<Page> onGenerateAppViewPages(
  final UserStatus state,
  final List<Page<dynamic>> pages,
) {
  switch (state) {
    case UserStatus.appStatusUnauthenticated:
      return [AuthSelect.page()];
    case UserStatus.currentUserStatusIncompleted:
      return [InfoUpdatePage.page()];
    case UserStatus.currentUserStatusCompleted:
      return [BottomNavBar.page()];
  }
}
