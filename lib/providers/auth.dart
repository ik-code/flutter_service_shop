import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  final String serverUrl = 'https://lav.playground.wdscode.guru';

  Future<dynamic> signup(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    String passwordConfirm,
  ) async {
    final url = Uri.parse(serverUrl + '/api/registration');
    final response = await http.post(
      url,
      body: json.encode(
        {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "phone_number": phoneNumber,
          "password": password,
          "password_confirmation": passwordConfirm
        },
      ),
    );

    var statusCodeServer = response.statusCode;
    var resBody = jsonDecode(response.body);
    var message = resBody['message'];

    if (response.statusCode == 200 &&
        (jsonDecode(response.body)['message'] != null) &&
        resBody['status'] == 1) {
      print(response.statusCode);
      String resBody = response.body;
      var message = jsonDecode(resBody)['message'];
      print(message);

    } else if (statusCodeServer >= 400) {
      print('Error!');
      print('statusCodeServer: $statusCodeServer');
    } else if (resBody['status'] == 0) {
      print('Warning ApiLara!');
      print('MessageApiLara: $message');
    }

    return resBody;
  }

  Future<String> login(
    String phoneNumber,
    String password,
  ) async {
   
    final url = Uri.parse(serverUrl + '/api/login');
    final response = await http.post(
      url,
      body: json.encode(
        {
          "phone_number": phoneNumber,
          "password": password,
        },
      ),
    );
    print(json.decode(response.body));
    String res = response.body;
    print(res);

    var statusCodeServer = response.statusCode;
    var resBody = jsonDecode(response.body);
    var message = resBody['message'];
    if (statusCodeServer == 200 &&
        (resBody['message'] != null) &&
        resBody['status'] == 1) {
      print('statusCodeServer: $statusCodeServer');
      print('MessageApiLara: $message');
 
    } else if (statusCodeServer >= 400) {
      print('Error!');
      print('statusCodeServer: $statusCodeServer');
    } else if (resBody['status'] == 0) {
      print('Warning ApiLara!');
      print('MessageApiLara: $message');
    }

    return res;
  }

  Future<void> resetPassword(
    String phoneNumber,
    String password,
    String passwordConfirmation,
    String apiToken,
  ) async {
    final url = Uri.parse(serverUrl + '/api/forgot-password-set-password');
    final response = await http.post(
      url,
      body: json.encode(
        {
          "phone_number": phoneNumber,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      ),
      headers: {
        "Authorization": apiToken,
      },
    );
    if (response.statusCode == 200) {
      print('Server status: 200 :${response.body}');
    }
    if (response.statusCode >= 400) {
      print('Server status Error!!! :${response.body}');
    }
  }
}//end class Auth
