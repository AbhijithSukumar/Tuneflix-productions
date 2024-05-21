// ignore_for_file: use_build_context_synchronously
import 'package:http/http.dart' as http;
import 'package:production_ui/models/login_model.dart';
import 'package:production_ui/ngrok.dart';

Future<Map<String, dynamic>> productionLogin(LoginModel production) async {
  var response = await http.post(
      Uri.parse("${Ngrok.url}/api/production/auth/login"),
      body: production.toMap());
  //print(response.statusCode);
  if (response.statusCode == 200) {
    return {"user": response.body, "status": true};
  }
  return {"status": false};
}
