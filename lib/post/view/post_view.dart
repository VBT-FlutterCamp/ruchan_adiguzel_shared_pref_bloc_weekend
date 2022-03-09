import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruchan_adiguzel_shared_pref/core/service/service.dart';
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
            if (state is PostDone) {
              return Center(
                  child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(state.post_model?.body ?? "null"),
                ),
              ));
            } else if (state is PostInitial) {
              return CircularProgressIndicator();
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
