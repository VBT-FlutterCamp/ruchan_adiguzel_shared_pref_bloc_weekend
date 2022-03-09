import 'package:vexana/vexana.dart';

import '../model/post_model.dart';

abstract class IPostService {
  final INetworkManager networkManager;

  IPostService(this.networkManager);

  Future<Post_Model?> getPostData();
}

class PostService extends IPostService {
  PostService(INetworkManager networkManager) : super(networkManager);

  @override
  Future<Post_Model?> getPostData() async {
    final response = await networkManager.send<Post_Model, Post_Model>(
        NetworkPath.base_url.rawValue,
        parseModel: Post_Model(),
        method: RequestType.GET);
    return response.data;
  }
}

enum NetworkPath { base_url }

extension NetworkPathExtension on NetworkPath {
  String get rawValue {
    switch (this) {
      case NetworkPath.base_url:
        return "/posts/1";
    }
  }
}
