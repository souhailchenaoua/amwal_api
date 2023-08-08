import 'package:flutter_test/flutter_test.dart';
import 'package:amwal_api/amwal_api.dart';
import 'package:amwal_api/amwal_api_platform_interface.dart';
import 'package:amwal_api/amwal_api_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAmwalApiPlatform
    with MockPlatformInterfaceMixin
    implements AmwalApiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AmwalApiPlatform initialPlatform = AmwalApiPlatform.instance;

  test('$MethodChannelAmwalApi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAmwalApi>());
  });

  test('getPlatformVersion', () async {
    AmwalApi amwalApiPlugin = AmwalApi();
    MockAmwalApiPlatform fakePlatform = MockAmwalApiPlatform();
    AmwalApiPlatform.instance = fakePlatform;

    expect(await amwalApiPlugin.getPlatformVersion(), '42');
  });
}
