import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../local/local_manager.dart';
import '../model/post_model.dart';
import '../service/post_service.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.postService) : super(PostInitial()) {
    emit(PostWaiting());
  }

  LocalManager manager = LocalManager.instance;
  Post_Model? model;
  IPostService? postService;

  Future<void> getModel() async {
    if (model == null) {
      final temp_model = await postService?.getPostData();

      manager.setDynamicJson(PreferencesKey.model_body, temp_model);
      final local_model_String =
          manager.getStringValue(PreferencesKey.model_body);
      model = Post_Model.fromJson(jsonDecode(local_model_String));
      log("lokale indirildi");
      emit(PostFromLocale(model));
    }
  }
}

abstract class PostState {}

class PostInitial extends PostState {}

class PostWaiting extends PostState {}

class PostDone extends PostState {}

class PostFromLocale extends PostState {
  PostFromLocale(this.model_from_locale);
  final Post_Model? model_from_locale;
}
