import 'package:budget_tracker/models/transaction_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  static const String transactionsBoxKey = "transactionsBox";
  static const String balanceBoxKey = "balanceBox";
  static const String budgetBoxKey = "budgetBoxKey";

  Future<void> initializeHive() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TransactionItemAdapter());
    }

    await Hive.openBox<double>(budgetBoxKey);
    await Hive.openBox<TransactionItem>(transactionsBoxKey);
    await Hive.openBox<double>(budgetBoxKey);
  }
}
