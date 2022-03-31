import 'dart:io';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/services/MobileDataInterceptor.dart';
import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' show MultipartFile;

part 'ApiServiceNoBase.chopper.dart';

//final $url = '${Constants.URL_LIST[Constants().indexURL]}${path}';
@ChopperApi(baseUrl: "")
abstract class ApiServiceNoBase extends ChopperService {
  @Get(path: '{path}')
  Future<dynamic> getImage(@Path('path') String path);

  @Post(path: '{path}', headers: {'Content-Type': 'multipart/form-data'})
  @multipart
  Future<dynamic> postApiTempOCR(
      @Path('path') String path,
      @Header('Authorization') String authorization,
      @PartFile() MultipartFile image,
      );

  static ApiServiceNoBase create() {
    HttpClient httpclient = new HttpClient()
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    httpclient.connectionTimeout = Constants.CONNECTION_TIME_OUT;
    var ioClient = new IOClient(httpclient);
    final client = ChopperClient(
      baseUrl: '',
      services: [
        _$ApiServiceNoBase(),
      ],
      client: ioClient,
      converter: JsonConverter(),
      interceptors: [
        MobileDataInterceptor()
      ,HttpLoggingInterceptor()
      ],
    );
    return _$ApiServiceNoBase(client);
  }
}
