import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plus_it_park_machine_test/models/api_model.dart';
import 'package:plus_it_park_machine_test/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final getDatasProvider = FutureProvider<List<ApiModel>?>((ref) async {
  return ref.read(apiServiceProvider).getDatas();
});
