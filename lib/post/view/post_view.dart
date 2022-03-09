import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruchan_adiguzel_shared_pref/core/service/service.dart';
import 'package:ruchan_adiguzel_shared_pref/local/local_manager.dart';
import 'package:ruchan_adiguzel_shared_pref/post/service/post_service.dart';
import '../view_model/post_view_model.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bloc SharedPref")),
      body: BlocProvider(
        create: (context) =>
            PostCubit(PostService(NetworkService.instance.networkManager)),
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is PostFromLocale) {
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
                      child: Text("Get data again"))
                ],
              ));
            } else if (state is PostWaiting) {
              return Center(
                  child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        context.read<PostCubit>().getModel();
                      },
                      child: Text("buton")),
                  CircularProgressIndicator(),
                ],
              ));
            }
            return Center(
              child: Text("wtf"),
            );
          },
        ),
      ),
    );
  }
}
