import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruchan_adiguzel_shared_pref/local/local_manager.dart';

import '../model/post_model.dart';
import '../service/post_service.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.postService) : super(PostInitial()) {
    getModel();
  }

  LocalManager manager = LocalManager.instance;
  Post_Model? model;
  IPostService? postService;

  Future<void> getModel() async {
    Post_Model? local_model;
    if (local_model == null) {
      final model = await postService?.getPostData();
      if (model == null) {
        return;
      } else {
        manager.setDynamicJson(PreferencesKey.model_body, model);
        final local_model_String =
            manager.getStringValue(PreferencesKey.model_body);
        local_model = Post_Model.fromJson(jsonDecode(local_model_String));
        emit(PostDone(local_model));
        log("lokale indirildi");
      }
    } else {
      log("lokalden çekildi");
      emit(PostDone(local_model));
    }
  }
}

abstract class PostState {}

class PostInitial extends PostState {}

class PostDone extends PostState {
  PostDone(this.post_model);

  final Post_Model? post_model;
}

class PostFromLocale extends PostState {}
