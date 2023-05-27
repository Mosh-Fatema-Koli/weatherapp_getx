import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiRepo {
  final String? url;
  final Map<String, dynamic>? payload;
  Dio dio = Dio();
  ApiRepo({this.url, this.payload});


 Future<void>  getData({
    Function()? beforeSending,
    Function(dynamic data )? onSuccess,
    Function(dynamic error)? onError,
  }) async {
 await   dio.get(url!, queryParameters: payload ).then((value) {
     // print(value.data.toString());
      if(onSuccess !=null){
        onSuccess(value.data);
        debugPrint('success in apiRepo');

      }
    })
        .catchError((error) {
          if(onError != null){
            print(error);
            debugPrint('${error.toString()} rep');
            onError(error);

          }
    });
  }
}
