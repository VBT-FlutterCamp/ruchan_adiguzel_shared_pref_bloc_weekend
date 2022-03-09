import 'package:vexana/vexana.dart';

class NetworkService {
  static NetworkService? _instance;
  static NetworkService get instance {
    if (_instance != null) return _instance!;
    _instance = NetworkService._init();
    return _instance!;
  }

  late final INetworkManager networkManager;
  final String _baseUrl = "https://jsonplaceholder.typicode.com/";

  NetworkService._init() {
    networkManager = NetworkManager(options: BaseOptions(baseUrl: _baseUrl));
  }
}
