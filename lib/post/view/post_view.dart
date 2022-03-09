// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/service/service.dart';
import '../service/post_service.dart';
import '../view_model/post_view_model.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String null_string = "Null value";
    return Scaffold(
      appBar: AppBar(title: const Text("Bloc SharedPref")),
      body: BlocProvider(
        create: (context) =>
            PostCubit(PostService(NetworkService.instance.networkManager)),
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PostFromLocale) {
              return DataFromLocaleWidget(state, context, null_string);
            } else if (state is PostWaiting) {
              return GetTextBtn(context);
            }
            return ExceptionText();
          },
        ),
      ),
    );
  }

  Center GetTextBtn(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              if (context.read<PostCubit>().model == null) {
                context.read<PostCubit>().getModel();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Data already fetched"),
                  action: SnackBarAction(label: "ok", onPressed: () {}),
                ));
              }
            },
            child: const Text("Get data")),
        const CircularProgressIndicator(),
      ],
    ));
  }

  Center ExceptionText() {
    return const Center(
      child: Text("wtf"),
    );
  }

  Center DataFromLocaleWidget(
      PostFromLocale state, BuildContext context, null_string) {
    return Center(
        child: Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  state.model_from_locale?.title ?? null_string,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Divider(),
                Text(state.model_from_locale?.body ?? null_string),
              ],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (state.model_from_locale == null) {
                context.read<PostCubit>().getModel();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Data already fetched"),
                  action: SnackBarAction(label: "ok", onPressed: () {}),
                  duration: Duration(seconds: 3),
                  shape: StadiumBorder(),
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            child: const Text("Get data again"))
      ],
    ));
  }
}
