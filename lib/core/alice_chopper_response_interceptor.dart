// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter_alice/model/alice_http_call.dart';
// import 'package:flutter_alice/model/alice_http_request.dart';
// import 'package:flutter_alice/model/alice_http_response.dart';
// import 'package:http/http.dart' as http;
//
// import 'alice_core.dart';
// import 'package:chopper/chopper.dart';
//
//
// class AliceChopperInterceptor {
//   /// AliceCore instance
//   final AliceCore aliceCore;
//
//   /// Creates instance of chopper interceptor
//   AliceChopperInterceptor(this.aliceCore);
//
//   /// Creates hashcode based on request
//   int getRequestHashCode(http.BaseRequest baseRequest) {
//     int hashCodeSum = 0;
//     hashCodeSum += baseRequest.url.hashCode;
//     hashCodeSum += baseRequest.method.hashCode;
//     baseRequest.headers.forEach((key, value) {
//       hashCodeSum += key.hashCode;
//       hashCodeSum += value.hashCode;
//     });
//     if (baseRequest.contentLength != null) {
//       hashCodeSum += baseRequest.contentLength.hashCode;
//     }
//     return hashCodeSum.hashCode;
//   }
//
//   /// Handles chopper request and creates alice http call
//   FutureOr<Request> handleRequest(Request request) async {
//     var baseRequest = await request.toBaseRequest();
//     AliceHttpCall call = AliceHttpCall(getRequestHashCode(baseRequest));
//     String endpoint = request.url.path;
//     String server = request.baseUri.host;
//
//     call.method = request.method;
//     call.endpoint = endpoint;
//     call.server = server;
//     call.client = "Chopper";
//     call.secure = request.baseUri.scheme == "https";
//
//     AliceHttpRequest aliceHttpRequest = AliceHttpRequest();
//
//     if (request.body == null) {
//       aliceHttpRequest.size = 0;
//       aliceHttpRequest.body = "";
//     } else {
//       aliceHttpRequest.size = utf8.encode(request.body.toString()).length;
//       aliceHttpRequest.body = request.body.toString();
//     }
//     aliceHttpRequest.time = DateTime.now();
//     aliceHttpRequest.headers = request.headers;
//     aliceHttpRequest.contentType = request.headers["Content-Type"] ?? "unknown";
//     aliceHttpRequest.queryParameters = request.parameters;
//
//     call.request = aliceHttpRequest;
//     call.response = AliceHttpResponse();
//
//     aliceCore.addCall(call);
//     return request;
//   }
//
//   /// Handles chopper response and adds data to existing alice http call
//   FutureOr<Response> handleResponse(Response response) {
//     var httpResponse = AliceHttpResponse();
//     httpResponse.status = response.statusCode;
//     httpResponse.body = response.body ?? "";
//     httpResponse.size = utf8.encode(response.body.toString()).length;
//
//     httpResponse.time = DateTime.now();
//     Map<String, String> headers = {};
//     response.headers.forEach((header, values) {
//       headers[header] = values.toString();
//     });
//     httpResponse.headers = headers;
//
//     aliceCore.addResponse(
//         httpResponse, getRequestHashCode(response.base.request!));
//     return response;
//   }
//
//   /// Get the unified interceptor to use in Chopper
//   Interceptor get interceptor => (request) async {
//     final modifiedRequest = await handleRequest(request);
//     return (http.Response response) => handleResponse(response);
//   };
// }
