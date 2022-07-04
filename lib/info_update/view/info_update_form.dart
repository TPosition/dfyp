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
                                      'First Name',
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
                                _fnameInput(),
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
                                      'Last Name',
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
                                _lnameInput(),
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
                                      'Gender',
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
                                _genderInput(),
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
                                      'Nationality',
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
                                _nationalityInput(),
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
                                      'Passport',
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
                                _passportInput(),
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
                                      'Country',
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
                                _countryInput(),
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
                                      'Post Code',
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
                                _postCodeInput(),
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
                                      'City',
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
                                _cityInput(),
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
                                      'State',
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
                                _provinceInput(),
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
                                      'Marital Status',
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
                                _maritalInput(),
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
            decoration: const InputDecoration(
              hintText: "Enter Your Phone Number",
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
            decoration: const InputDecoration(
              hintText: "Enter Your Name",
            ),
          ),
        ),
      );
}

class _genderInput extends StatefulWidget {
  const _genderInput({
    final Key? key,
  }) : super(key: key);

  @override
  State<_genderInput> createState() => _genderInputState();
}

class _genderInputState extends State<_genderInput> {
  @override
  Widget build(final BuildContext context) {
    String dropdownvalue = 'Male';
    var items = [
      'Male',
      'Female',
      'Other',
    ];
    return BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
        buildWhen: (final previous, current) =>
            previous.gender != current.gender,
        builder: (final context, final state) => Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    value: state.gender,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                      context.read<InfoUpdateCubit>().genderChanged(newValue!);
                    },
                  ),
                ),
              ],
            ));
  }
}

class _fnameInput extends StatelessWidget {
  const _fnameInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
          buildWhen: (final previous, current) =>
              previous.fname != current.fname,
          builder: (final context, final state) => Flexible(
                child: TextFormField(
                  key: const Key('infoUpdateForm_fnameInput_TextField'),
                  onChanged: (final fname) =>
                      context.read<InfoUpdateCubit>().fnameChanged(fname),
                  decoration: const InputDecoration(
                    hintText: 'Enter your first name',
                  ),
                ),
              ));
}

class _lnameInput extends StatelessWidget {
  const _lnameInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
          buildWhen: (final previous, current) =>
              previous.lname != current.lname,
          builder: (final context, final state) => Flexible(
                  child: TextFormField(
                key: const Key('infoUpdateForm_lnameInput_TextField'),
                onChanged: (final lname) =>
                    context.read<InfoUpdateCubit>().lnameChanged(lname),
                decoration: const InputDecoration(
                  hintText: 'Enter your last name',
                ),
              )));
}

class _nationalityInput extends StatefulWidget {
  const _nationalityInput({
    final Key? key,
  }) : super(key: key);

  @override
  State<_nationalityInput> createState() => _nationalityInputState();
}

class _nationalityInputState extends State<_nationalityInput> {
  @override
  Widget build(final BuildContext context) {
    String dropdownvalue = 'Malaysian';
    var items = [
      'Malaysian',
      'Non-Malaysian',
    ];
    return BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
        buildWhen: (final previous, current) =>
            previous.nationality != current.nationality,
        builder: (final context, final state) => Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    value: state.nationality,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                      context
                          .read<InfoUpdateCubit>()
                          .nationalityChanged(newValue!);
                    },
                  ),
                ),
              ],
            ));
  }
}

class _passportInput extends StatelessWidget {
  const _passportInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
          buildWhen: (final previous, current) =>
              previous.passport != current.passport,
          builder: (final context, final state) => Flexible(
                child: TextFormField(
                  key: const Key('infoUpdateForm_passportInput_TextField'),
                  onChanged: (final passport) =>
                      context.read<InfoUpdateCubit>().passportChanged(passport),
                  decoration: const InputDecoration(
                    hintText: 'Enter your passport',
                  ),
                ),
              ));
}

class _countryInput extends StatelessWidget {
  const _countryInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
          buildWhen: (final previous, current) =>
              previous.country != current.country,
          builder: (final context, final state) => Flexible(
                child: TextFormField(
                  key: const Key('infoUpdateForm_countryInput_TextField'),
                  onChanged: (final country) =>
                      context.read<InfoUpdateCubit>().countryChanged(country),
                  decoration: const InputDecoration(
                    hintText: 'Enter your country',
                  ),
                ),
              ));
}

class _postCodeInput extends StatelessWidget {
  const _postCodeInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
          buildWhen: (final previous, current) =>
              previous.postCode != current.postCode,
          builder: (final context, final state) => Flexible(
                child: TextFormField(
                  key: const Key('infoUpdateForm_postCodeInput_TextField'),
                  onChanged: (final postCode) =>
                      context.read<InfoUpdateCubit>().postCodeChanged(postCode),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter your postCode',
                  ),
                ),
              ));
}

class _cityInput extends StatelessWidget {
  const _cityInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
          buildWhen: (final previous, current) => previous.city != current.city,
          builder: (final context, final state) => Flexible(
                child: TextFormField(
                    key: const Key('infoUpdateForm_cityInput_TextField'),
                    onChanged: (final city) =>
                        context.read<InfoUpdateCubit>().cityChanged(city),
                    decoration: const InputDecoration(
                      hintText: 'Enter your city',
                    )),
              ));
}

class _provinceInput extends StatelessWidget {
  const _provinceInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
          buildWhen: (final previous, current) =>
              previous.province != current.province,
          builder: (final context, final state) => Flexible(
                child: TextFormField(
                  key: const Key('infoUpdateForm_provinceInput_TextField'),
                  onChanged: (final province) =>
                      context.read<InfoUpdateCubit>().provinceChanged(province),
                  decoration: const InputDecoration(
                    hintText: 'Enter your province',
                  ),
                ),
              ));
}

class _maritalInput extends StatefulWidget {
  const _maritalInput({
    final Key? key,
  }) : super(key: key);

  @override
  State<_maritalInput> createState() => _maritalInputState();
}

class _maritalInputState extends State<_maritalInput> {
  @override
  Widget build(final BuildContext context) {
    String dropdownvalue = 'Single';
    var items = [
      'Single',
      'Married',
      'Divorced',
      'Widowed',
    ];
    return BlocBuilder<InfoUpdateCubit, InfoUpdateState>(
        buildWhen: (final previous, current) =>
            previous.marital != current.marital,
        builder: (final context, final state) => Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    value: state.marital,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                      context.read<InfoUpdateCubit>().maritalChanged(newValue!);
                    },
                  ),
                ),
              ],
            ));
  }
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
            decoration: const InputDecoration(
              hintText: "Enter Your Address",
            ),
          ),
        ),
      );
}
