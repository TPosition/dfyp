import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ispkp/info_update/view/info_update_page.dart';
import 'package:ispkp/info_update_company/view/info_update_company_page.dart';
import '/common/widgets/avatar.dart';
import '/current_user/bloc/current_user_bloc.dart';
import '/users/bloc/users_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_repository/users_repository.dart';

class UserTypeSelectPage extends StatelessWidget {
  const UserTypeSelectPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const UserTypeSelectPage(),
      );

  static Page page() => const MaterialPage<void>(
        child: UserTypeSelectPage(),
      );

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Register for',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                ButtonTheme(
                                  height: 90,
                                  minWidth: 90,
                                  child: RaisedButton(
                                    elevation: 0,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(InfoUpdatePage.route());
                                    },
                                    color: Color.fromRGBO(250, 250, 252, 1),
                                    child: Image.asset(
                                        'assets/icon_individual.png'),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Individual",
                                    style: GoogleFonts.roboto(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff76797e),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ButtonTheme(
                                  height: 90,
                                  minWidth: 90,
                                  child: RaisedButton(
                                    elevation: 0,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(InfoUpdateCompanyPage.route());
                                    },
                                    color:
                                        const Color.fromRGBO(250, 250, 252, 1),
                                    child:
                                        Image.asset('assets/icon_company.png'),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Company",
                                    style: GoogleFonts.roboto(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
