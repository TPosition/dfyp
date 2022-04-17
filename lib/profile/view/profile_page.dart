import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/common/widgets/avatar.dart';
import '/current_user/bloc/current_user_bloc.dart';
import '/users/bloc/users_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_repository/users_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              BlocBuilder<UsersBloc, UsersState>(
                builder: (final context, final state) {
                  if (state is UsersLoaded) {
                    return Column(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              const _AppBar(),
                              _ProfileAvatar(user: user)
                            ],
                          ),
                        ),
                        Container(
                          color: const Color(0xffFFFFFF),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                const _InfoName(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserName(user: user),
                                const SizedBox(
                                  height: 20,
                                ),
                                const _InfoEmail(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserEmail(user: user),
                                const SizedBox(
                                  height: 20,
                                ),
                                const _InfoMobile(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserMobile(user: user),
                                const SizedBox(
                                  height: 20,
                                ),
                                const _InfoAddress(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserAddress(user: user),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ));
  }
}

class _InfoUserMobile extends StatelessWidget {
  const _InfoUserMobile({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 2,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.mobile,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoMobile extends StatelessWidget {
  const _InfoMobile({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Mobile',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ));
}

class _InfoUserEmail extends StatelessWidget {
  const _InfoUserEmail({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.email,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoEmail extends StatelessWidget {
  const _InfoEmail({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Row(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Email',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );
}

class _InfoUserName extends StatelessWidget {
  const _InfoUserName({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.displayName,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoName extends StatelessWidget {
  const _InfoName({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Name',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ));
}

class _InfoUserAddress extends StatelessWidget {
  const _InfoUserAddress({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.address,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoAddress extends StatelessWidget {
  const _InfoAddress({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Address',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ));
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Image.network(
                user.photoURL,
                fit: BoxFit.fitWidth,
                loadingBuilder: (final BuildContext context, final Widget child,
                    final ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Personal Information',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
          )
        ],
      ));
}
