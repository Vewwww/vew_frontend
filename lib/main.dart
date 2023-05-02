import 'package:flutter/material.dart';
import 'core/utils/sp_helper/cache_helper.dart';
import 'services/dio_helper.dart';
import 'src/app_root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await SharedPreferencesHelper.init();
  DioHelper.init();
  runApp(const AppRoot());
}
