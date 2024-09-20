import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static get key => dotenv.get("key");

  static get base_url => dotenv.get("base_url");
}
