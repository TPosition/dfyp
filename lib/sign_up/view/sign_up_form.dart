import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/common/widgets/fade_animation.dart';
import '/login/login.dart';
import '/sign_up/sign_up.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocListener<SignUpCubit, SignUpState>(
        listener: (final context, final state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.of(context).pop();
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Sign Up Failure')),
              );
          }
        },
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              FadeAnimation(
                                  1,
                                  const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                  1.2,
                                  Text(
                                    "Create an account, It's free",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[700]),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: <Widget>[
                                FadeAnimation(1.2, _EmailInput()),
                                FadeAnimation(1.4, _PasswordInput()),
                                FadeAnimation(1.6, _ConfirmPasswordInput()),
                                FadeAnimation(1.8, _SignUpButton()),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          FadeAnimation(
                              1.5,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text("Already have an account?"),
                                  RaisedButton(
                                    padding: EdgeInsets.zero,
                                    elevation: 0,
                                    hoverElevation: 0,
                                    focusElevation: 0,
                                    highlightElevation: 0,
                                    color: Colors.white,
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push<void>(LoginPage.route());
                                    },
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            )),
      );
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (final previous, final current) =>
            previous.email != current.email,
        builder: (final context, final state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              key: const Key('signUpForm_emailInput_textField'),
              onChanged: (final email) =>
                  context.read<SignUpCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                helperText: '',
                errorText: state.email.invalid ? 'invalid email' : null,
              ),
            ),
          ],
        ),
      );
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (final previous, final current) =>
            previous.password != current.password,
        builder: (final context, final state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Password",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              key: const Key('signUpForm_passwordInput_textField'),
              onChanged: (final password) =>
                  context.read<SignUpCubit>().passwordChanged(password),
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!)),
                helperText: '',
                errorText: state.password.invalid
                    ? 'password must contain an uppercase letter, lowercase letter, number and at least 8 characters'
                    : null,
                errorMaxLines: 5,
              ),
            ),
          ],
        ),
      );
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (final previous, final current) =>
            previous.password != current.password ||
            previous.confirmedPassword != current.confirmedPassword,
        builder: (final context, final state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Confirm Password",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              key: const Key('signUpForm_confirmedPasswordInput_textField'),
              onChanged: (final confirmPassword) => context
                  .read<SignUpCubit>()
                  .confirmedPasswordChanged(confirmPassword),
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!)),
                helperText: '',
                errorText: state.confirmedPassword.invalid
                    ? 'passwords do not match'
                    : null,
              ),
            ),
          ],
        ),
      );
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (final previous, final current) =>
            previous.status != current.status,
        builder: (final context, final state) => state
                .status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: const Border(
                      bottom: BorderSide(),
                      top: BorderSide(),
                      left: BorderSide(),
                      right: BorderSide(),
                    )),
                child: MaterialButton(
                  key: const Key('signUpForm_continue_raisedButton'),
                  minWidth: double.infinity,
                  height: 60,
                  disabledColor: Colors.greenAccent,
                  disabledTextColor: Colors.black,
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: state.status.isValidated
                      ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                      : null,
                  child: const Text('Sign up',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                ),
              ),
      );
}
