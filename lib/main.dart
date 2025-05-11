import 'package:adhdo_it_mob/app/app.dart';
import 'package:adhdo_it_mob/data/storage/local_storage.dart';
import 'package:adhdo_it_mob/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  print(LocalStorage().token?.access);
  initLoggerListener();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(child: App()));
}
