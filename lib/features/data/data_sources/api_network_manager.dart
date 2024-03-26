import 'package:dio/dio.dart';

class ApiNetworkManager {
  static ApiNetworkManager? _instace;
  static ApiNetworkManager get instance {
    if (_instace != null) return _instace!;
    _instace = ApiNetworkManager._init();
    return _instace!;
  }

  final String _baseUrl = 'https://192.168.1.3:7207';
  late final Dio dio;

  ApiNetworkManager._init() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
      
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer your_access_token';
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.type == DioExceptionType.connectionTimeout ||
         error.type == DioExceptionType.receiveTimeout ||
         error.type == DioExceptionType.sendTimeout) {
       
          throw DioException(
            requestOptions: error.requestOptions,
            message: "Zaman aşımına uğradı daha sonra deneyin!",
            type: DioExceptionType.connectionTimeout,
          );
        }
         if(error.response!.statusCode == 403){
            // need to logout the user when this error occur
         }
        return handler.next(error);
     
      },
    ));
  }
}
