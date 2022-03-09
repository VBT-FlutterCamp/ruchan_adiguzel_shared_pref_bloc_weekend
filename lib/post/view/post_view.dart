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
    return Scaffold(
      appBar: AppBar(title: const Text("Bloc SharedPref")),
      body: BlocProvider(
        create: (context) =>
            PostCubit(PostService(NetworkService.instance.networkManager)),
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PostFromLocale) {
              return DataFromLocaleWidget(state, context);
            } else if (state is PostWaiting) {
              return const StateNeutrolWidget();
            }
            return ExceptionText();
          },
        ),
      ),
    );
  }

  Center ExceptionText() {
    return const Center(
      child: Text("wtf"),
    );
  }

  Center DataFromLocaleWidget(PostFromLocale state, BuildContext context) {
    return Center(
        child: Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(state.model_from_locale?.body ?? "null"),
          ),
        ),
        ElevatedButton(
            onPressed: () => context.read<PostCubit>().getModel(),
            child: const Text("Get data again"))
      ],
    ));
  }
}

class StateNeutrolWidget extends StatelessWidget {
  const StateNeutrolWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        TextButton(
            onPressed: () {
              context.read<PostCubit>().getModel();
            },
            child: const Text("buton")),
        const CircularProgressIndicator(),
      ],
    ));
  }
}
