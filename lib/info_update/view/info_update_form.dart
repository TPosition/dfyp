import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app/app.dart';
import '/common/widgets/avatar.dart';
import '/info_update/cubit/info_update_cubit.dart';
import 'package:formz/formz.dart';

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
                  height: 150,
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Avatar(
                            photo: 'https://picsum.photos/seed/${auth.id}/120/',
                          ),
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
                              left: 25, right: 25, top: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Text(
                                    'Parsonal Information',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, top: 25),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Display Name',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
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
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, top: 25),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Mobile',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 2),
                          child: Row(
                            children: const <Widget>[
                              _MobileInput(),
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
      )),
    );
  }
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
              errorText:
                  state.displayName.invalid ? 'Invalid phone number.' : null,
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
              hintText: "Enter Your Display Name",
              errorText:
                  state.displayName.invalid ? 'Invalid display name.' : null,
            ),
          ),
        ),
      );
}
