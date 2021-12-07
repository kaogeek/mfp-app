import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/utils/router.dart';

Future checkInternetConnectivity() async {
  bool isConnected;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isConnected = true;
    }
  } on SocketException catch (_) {
    isConnected = false;
  
  }
  return isConnected;
}
