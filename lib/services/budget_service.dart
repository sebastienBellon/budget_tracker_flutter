import 'package:flutter/material.dart';

import '../models/transaction_item.dart';

class BudgetService with ChangeNotifier {
  double _budget = 2000.0;

  double get budget => _budget;

  double _balance = 0.0;

  double get balance => _balance;

  final List<TransactionItem> _items = [];

  List<TransactionItem> get items => _items;

  set budget(double value) {
    _budget = value;
    notifyListeners();
  }

  void addItem(TransactionItem item) {
    _items.add(item);
    _updateBalance(item);
    notifyListeners();
  }

  void _updateBalance(TransactionItem item) {
    if (item.isExpense) {
      _balance += item.amount;
    } else {
      _balance -= item.amount;
    }
  }
}
