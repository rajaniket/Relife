import 'dart:developer';

import 'package:relife/config/api_config.dart';
import 'package:http/http.dart' as http;

class UpdateDpService {
  Future<http.StreamedResponse> updateDp(String filePath, String token) async {
    final url = Uri.https(ApiConfig.baseUrl, ApiConfig.updateDpEndpoint);

    final request = http.MultipartRequest(
      'POST',
      url,
    );
    request.files.add(await http.MultipartFile.fromPath('aaa', filePath));
    request.headers.addAll({
      'Content-type': "multipart/form-data",
      'Authorization': token,
    });

    var response = request.send();

    log("UpdateDpService ______ $response");

    return response;
  }
}
