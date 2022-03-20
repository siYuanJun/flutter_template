import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_template/common/GlobalConfig.dart';

import 'GlobalConfig.dart';

class HttpGo {
  static const String _GET = "get";
  static const String _POST = "post";

  static const String _CODE = "errCode";

  static const String _baseURL = "https://api.github.com";

  late Dio _dio;

  static HttpGo getInstance() {
    return HttpGo();
  }

  HttpGo() {
    _dio = Dio(
      BaseOptions(
          baseUrl: _baseURL,
          connectTimeout: 5000,
          receiveTimeout: 100000,
//        headers: {"user-agent": "dio", "api": "1.0.0"},
          contentType: ContentType.json.toString(),
          responseType: ResponseType.plain),
    );

    _addHttpInterceptor(); //添加请求之前的拦截器
  }

  //get请求
  get(String url, Map<String, dynamic> ?params) {
    return _requestHttp(url, _GET, params);
  }

  //post请求
  post(String url, Map<String, dynamic> params) {
    return _requestHttp(url, _POST, params);
  }

  _requestHttp(String url, [method, params]) async {
    String errorMsg = '';
    int? code;

    try {
      dynamic response = {};

      if (method == _GET) {
        if (params != null) {
          response = await _dio.get(url, queryParameters: params);
        } else {
          response = await _dio.get(url);
        }
      } else if (method == _POST) {
        if (params != null) {
          response = await _dio.post(url, data: params);
        } else {
          response = await _dio.post(url);
        }
      }

      code = response.statusCode;
      if (code != 200) {
        errorMsg = '错误码：' + code.toString() + '，' + response.data.toString();
        _error(errorMsg, url);

        return response;
      }

      Map<String, dynamic> dataMap = json.decode(response.data);
      // if (dataMap[_CODE] != 0) {
      //   errorMsg =
      //       '错误码：' + dataMap[_CODE].toString() + '，' + response.data.toString();
      //   _error(errorMsg, url);
      //
      //   return response;
      // }

      return dataMap;
    } catch (exception) {
      _error(exception.toString(), url);
    }
  }

  _error(String error, String url) {
    if (GlobalConfig.isDebug) {
      print('请求异常信息: ' + error.toString());
      print('请求异常 url: ' + url);
      print('请求头: ' + _dio.options.headers.toString());
      print('method: ' + _dio.options.method);
    }
  }

  _addHttpInterceptor() {
    _dio.interceptors
        .add(InterceptorsWrapper(
          onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
            // 在请求被发送之前做一些事情
            // print("拦截一下：" + options.toString());
            // print("拦截一下：" + handler.toString());

            handler.next(options);

            // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
            // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
            //
            // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
            // 这样请求将被中止并触发异常，上层catchError会被调用。
          },
          onResponse: (Response response, ResponseInterceptorHandler handler) async {
            // 在返回响应数据之前做一些预处理
            // print("返回之前拦截处理一下：" + response.toString());

            handler.resolve(response);
          },
          onError: (DioError e, ErrorInterceptorHandler handler) async {
            // 当请求失败时做一些预处理
            handler.reject(e);
          }
        )
    );

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (!GlobalConfig.isRelease) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // 设置代理抓包，调试用
        // client.findProxy = (uri) {
        //   return 'PROXY 192.168.50.154:8888';
        // };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;

        return null;
      };
    }
  }
}
