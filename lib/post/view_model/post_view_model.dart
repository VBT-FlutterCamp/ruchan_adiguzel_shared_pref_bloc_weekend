import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/post_model.dart';
import '../service/post_service.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.postService) : super(PostInitial()) {
    getModel();
  }
  IPostService? postService;
  Post_Model? model;

  Future<void> getModel() async {
    emit(PostInitial());
    final model = await postService?.getPostData();
    emit(PostDone(model));
  }
}

abstract class PostState {}

class PostInitial extends PostState {}

class PostDone extends PostState {
  final Post_Model? post_model;

  PostDone(this.post_model);
}
