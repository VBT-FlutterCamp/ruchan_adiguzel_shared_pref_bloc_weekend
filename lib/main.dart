import 'package:flutter/material.dart';
import 'local/local_manager.dart';

import 'post/view/post_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalManager.preferenceInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: PostView(),
    );
  }
}
