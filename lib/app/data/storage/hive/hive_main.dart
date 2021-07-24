import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class HiveMain{

  initHive() async{
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }
}