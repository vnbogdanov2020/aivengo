import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

dynamic saveChatHistory(
  dynamic chatHistory,
  dynamic newChat,
) {
  // If chatHistory isn't a list, make it a list and then add newChat
  if (chatHistory is List) {
    chatHistory.add(newChat);
    return chatHistory;
  } else {
    return [newChat];
  }
}

dynamic convertToJSON(String prompt) {
  // take the prompt and return a JSON with form [{"role": "user", "content": prompt}]
  return json.decode('{"role": "user", "content": "$prompt"}');
}

String? getEpayPage(
  dynamic inAuth,
  String? inLink,
) {
  String myJSON = inAuth.toString();

  myJSON = myJSON.replaceAll('{', '{"');
  myJSON = myJSON.replaceAll(': ', '": "');
  myJSON = myJSON.replaceAll(', ', '", "');
  myJSON = myJSON.replaceAll('}', '"}');

  String result =
      '<html><head><title>Оплата через мобильное приложение</title><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />' +
          '<script src="https://test-epay.homebank.kz/payform/payment-api.js" type="text/javascript"></script></head>' +
          '<body><script type="text/javascript">var createPaymentObject = function(auth, invoiceId, amount) {var paymentObject = {' +
          'invoiceId: "000000001",' +
          'backLink: "aivengo://aivengo.com/startPage",' +
          'failureBackLink: "aivengo://aivengo.com/startPage",' +
          'postLink: "https://example.kz/",' +
          'language: "RU",' +
          'description: "Оплата в интернет магазине",' +
          'accountId: "test",' +
          'terminal: "67e34d63-102f-4bd1-898e-370781d0074d",' +
          'amount: 100,' +
          'currency: "KZT",' +
          'phone: "77777777777",' +
          'email: "example@example.com",' +
          'cardSave: true' +
          '}; paymentObject.auth = auth;  return paymentObject; };' +
          'halyk.pay(createPaymentObject($myJSON, "000000001", 100));</script>' +
          '</body></html>';

  return result;
}
