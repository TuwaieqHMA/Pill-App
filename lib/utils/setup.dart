import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future setupDatabase() async{
  
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(url: dotenv.env["supabaseUrl"]!, anonKey: dotenv.env["supabaseAnonKey"]!);
}

Future setup() async {
  await GetStorage.init();

  GetIt.I.registerSingleton<HomeData>(HomeData());
}