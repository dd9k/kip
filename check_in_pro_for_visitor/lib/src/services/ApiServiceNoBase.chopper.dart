// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiServiceNoBase.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ApiServiceNoBase extends ApiServiceNoBase {
  _$ApiServiceNoBase([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ApiServiceNoBase;

  Future getImage(String path) {
    final $url = '${path}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send($request);
  }

  Future postApiTempOCR(
      String path, String authorization, MultipartFile image) {
    final $url = '${path}';
    final $headers = {
      'Authorization': authorization,
      'Content-Type': 'multipart/form-data'
    };
    final $parts = <PartValue>[PartValueFile<MultipartFile>('image', image)];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send($request);
  }
}
