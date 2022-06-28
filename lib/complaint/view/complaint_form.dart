import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ispkp/common/views/success_page.dart';
import 'package:ispkp/complaint/cubit/complaint_cubit.dart';
import 'package:ispkp/current_user/bloc/current_user_bloc.dart';

class ComplaintForm extends StatelessWidget {
  const ComplaintForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);

    final sizeWidth = MediaQuery.of(context).size.width * 3 / 4;

    return Scaffold(
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
                          children: <Widget>[
                            IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            const Text(
                              'Complaint',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
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
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Text(
                                    'Title',
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
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            top: 2,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: sizeWidth,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: _TitleInput(),
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
                                    'Comment',
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
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            top: 2,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: sizeWidth,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: _CommentInput(),
                              ),
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
                            await context.read<ComplaintCubit>().formSubmit(
                                  user.uid,
                                );

                            await Navigator.of(context)
                                .push<void>(SuccessPage.route());
                          },
                          color: Colors.yellowAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Submit",
                            style: const TextStyle(
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
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<ComplaintCubit, ComplaintState>(
        buildWhen: (final previous, final current) =>
            previous.title != current.title,
        builder: (final context, final state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            TextField(
              key: const Key('complaintForm_titleInput_textField'),
              onChanged: (final title) =>
                  context.read<ComplaintCubit>().titleChanged(title),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                helperText: '',
                errorText: state.title.isEmpty ? 'invalid title' : null,
              ),
            ),
          ],
        ),
      );
}

class _CommentInput extends StatelessWidget {
  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<ComplaintCubit, ComplaintState>(
        buildWhen: (final previous, final current) =>
            previous.comment != current.comment,
        builder: (final context, final state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            TextField(
              key: const Key('complaintForm_commentInput_textField'),
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              onChanged: (final comment) =>
                  context.read<ComplaintCubit>().commentChanged(comment),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                helperText: '',
                errorText: state.comment.isEmpty ? 'invalid comment' : null,
              ),
            ),
          ],
        ),
      );
}
