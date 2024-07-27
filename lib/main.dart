import 'package:examples/data/local_data_storage.dart';
import 'package:examples/repositories/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

// import 'features/connection_monitor/example/connection_monitor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //singleton
  final storage =
      LocalDataStorage(preferences: await SharedPreferences.getInstance());
  //dependent
  final expenseRepository = ExpenseRepository(storage: storage);
  runApp(App(expenseRepository:expenseRepository));
}


