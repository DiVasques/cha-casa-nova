import 'dart:convert';

import 'package:cha_casa_nova/services/models/confirm_presence_recipient.dart';
import 'package:cha_casa_nova/services/models/result.dart';
import 'package:http/http.dart' as http;

class EmailService {
  static final Uri emailJSUrl = Uri.http('api.emailjs.com', 'api/v1.0/email/send');
  static const String serviceId = '';
  static const String userId = '';
  static const String accessToken = '';

  static Future<Result> sendConfirmPresenceEmail({required ConfirmPresenceRecipient recipient}) async {
    const String templateId = 'template_ge76num';
    Result result = Result(status: true);
    try {
      http.Response response = await http.post(
        emailJSUrl,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(
          <String, Object>{
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'accessToken': accessToken,
            'template_params': <String, String>{
              'to_name': recipient.name,
              'to_email': recipient.email,
            }
          },
        ),
      );
      if (response.statusCode != 200) {
        result.status = false;
        result.errorMessage = response.body;
        result.errorCode = response.statusCode.toString();
      }
    } catch (error) {
      result.status = false;
      result.errorMessage = error.toString();
      result.errorCode = '502';
    }
    return result;
  }
}
