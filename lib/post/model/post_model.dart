import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'post_model.g.dart';

@JsonSerializable()
class Post_Model extends INetworkModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post_Model({this.userId, this.id, this.title, this.body});

  factory Post_Model.fromJson(Map<String, dynamic> json) {
    return _$Post_ModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$Post_ModelToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$Post_ModelFromJson(json);
  }
}
