import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/common/widgets/fade_animation.dart';
import '/login/login.dart';
import '/sign_up/sign_up.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocListener<LoginCubit, LoginState>(
        listener: (final context, final state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          } else if (state.status.isSubmissionSuccess) {
            Navigator.of(context).pop();
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
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              FadeAnimation(
                                  1,
                                  const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                1,
                                Text(
                                  "Login to your account",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: <Widget>[
                                FadeAnimation(1.2, _EmailInput()),
                                FadeAnimation(1.4, _PasswordInput()),
                                FadeAnimation(1.6, _LoginButton()),
                              ],
                            ),
                          ),
                          FadeAnimation(2, const _SignupHint()),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            )),
      );
}

class _SignupHint extends StatelessWidget {
  const _SignupHint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Don't have an account?"),
        RaisedButton(
          padding: EdgeInsets.zero,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          color: Colors.white,
          child: const Text(
            'Sign up',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).push<void>(SignUpPage.route());
          },
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<LoginCubit, LoginState>(
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
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (final email) =>
                  context.read<LoginCubit>().emailChanged(email),
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
      BlocBuilder<LoginCubit, LoginState>(
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
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (final password) =>
                  context.read<LoginCubit>().passwordChanged(password),
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

class _LoginButton extends StatelessWidget {
  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<LoginCubit, LoginState>(
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
                  key: const Key('loginForm_continue_raisedButton'),
                  minWidth: double.infinity,
                  height: 60,
                  disabledColor: Colors.greenAccent,
                  disabledTextColor: Colors.black,
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: state.status.isValidated
                      ? () => context.read<LoginCubit>().logInWithCredentials()
                      : null,
                  child: const Text('Login',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                ),
              ),
      );
}
