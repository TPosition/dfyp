import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app/app.dart';
import '/common/widgets/avatar.dart';
import '/info_update/cubit/info_update_cubit.dart';
import 'package:formz/formz.dart';
import 'package:storage_repository/storage_repository.dart';

class InfoUpdateForm extends StatelessWidget {
  const InfoUpdateForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final auth = context.select(
      (final AppBloc bloc) => bloc.state.user,
    );

    return BlocListener<InfoUpdateCubit, InfoUpdateState>(
      listener: (final context, final state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Information Update Failure')),
            );
        }
      },
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Please Complete Profile',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Upload image (white background)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: _avatarInput(
                            uid: auth.id,
                          ),
                        ),
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
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Personal Information',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 2,
                            ),
                            child: Row(
                              children: const <Widget>[
                                _DisplayNameInput(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Phone Number',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 2,
                            ),
                            child: Row(
                              children: const <Widget>[
                                _MobileInput(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 2,
                            ),
                            child: Row(
                              children: const <Widget>[
                                _AddressInput(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              await context
                                  .read<InfoUpdateCubit>()
                                  .infoUpdateFormSubmitted(
                                    auth.id,
                                    auth.email ?? 'auth email error',
                                  );
                            },
                            color: Colors.yellowAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
                              "Confirm",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _avatarInput extends StatelessWidget {
  _avatarInput({
    required final this.uid,
    final Key? key,
  }) : super(key: key);

  final _storage = FirebaseStorageRepository();
  final String uid;

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
        buildWhen: (final previous, final current) =>
            previous.hasImage != current.hasImage,
        builder: (final context, final state) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Align(
                  child: SizedBox(
                    width: 200,
                    child: state.hasImage
                        ? FutureBuilder<String>(
                            future: _storage.getImageURL('$uid/avatar.png'),
                            builder: (
                              final BuildContext context,
                              final AsyncSnapshot<String> snapshot,
                            ) =>
                                snapshot.hasData
                                    ? Image.network(
                                        snapshot.data ??
                                            'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png',
                                        fit: BoxFit.fitWidth,
                                        loadingBuilder:
                                            (final BuildContext context,
                                                final Widget child,
                                                final ImageChunkEvent?
                                                    loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      )
                                    : const Text('Loading'),
                          )
                        : Image.network(
                            "https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png",
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.camera_alt,
                size: 30,
              ),
              onPressed: () async {
                context.read<InfoUpdateCubit>().imageChanged(false);
                await _storage.addImage('$uid/avatar.png');
                context.read<InfoUpdateCubit>().imageChanged(true);
              },
            ),
          ],
        ),
      );
}

class _MobileInput extends StatelessWidget {
  const _MobileInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
        buildWhen: (final previous, final current) =>
            previous.mobile != current.mobile,
        builder: (final context, final state) => Flexible(
          child: TextFormField(
            key: const Key('infoUpdateForm_MobileInput_textField'),
            onChanged: (final mobile) =>
                context.read<InfoUpdateCubit>().mobileChanged(mobile),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter Your Phone Number",
              errorText: state.mobile.invalid ? 'Invalid phone number.' : null,
            ),
          ),
        ),
      );
}

class _DisplayNameInput extends StatelessWidget {
  const _DisplayNameInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
        buildWhen: (final previous, final current) =>
            previous.displayName != current.displayName,
        builder: (final context, final state) => Flexible(
          child: TextFormField(
            key: const Key('infoUpdateForm_displayNameInput_textField'),
            onChanged: (final displayName) =>
                context.read<InfoUpdateCubit>().displayNameChanged(displayName),
            decoration: InputDecoration(
              hintText: "Enter Your Name",
              errorText: state.displayName.invalid ? 'Invalid name.' : null,
            ),
          ),
        ),
      );
}

class _AddressInput extends StatelessWidget {
  const _AddressInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
        buildWhen: (final previous, final current) =>
            previous.address != current.address,
        builder: (final context, final state) => Flexible(
          child: TextFormField(
            key: const Key('infoUpdateForm_addressInput_textField'),
            onChanged: (final address) =>
                context.read<InfoUpdateCubit>().addressChanged(address),
            decoration: InputDecoration(
              hintText: "Enter Your Address",
              errorText: state.displayName.invalid ? 'Invalid address.' : null,
            ),
          ),
        ),
      );
}
