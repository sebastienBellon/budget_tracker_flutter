import 'package:budget_tracker/widgets/transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../models/transaction_item.dart';
import '../widgets/transaction_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TransactionItem> items = [
    TransactionItem(
      itemTitle: 'Apple Watch',
      amount: 105.99,
      isExpense: true,
    ),
    TransactionItem(
      itemTitle: 'Apple iPhone',
      amount: 800,
      isExpense: false,
    ),
  ];

  void addTransactionToItems(TransactionItem item) {}

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddTransactionDialog(
                  itemToAdd: (transactionItem) {
                    setState(() {
                      items.add(transactionItem);
                    });
                  },
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: CircularPercentIndicator(
                    radius: screenSize.width / 4,
                    lineWidth: 10.0,
                    percent: 0.5,
                    backgroundColor: Colors.white,
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          '\$0',
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Balance',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    progressColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  "Items",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // here we are using the spread operator to avoid returning a List<widget>
                // but a widget instead
                ...List.generate(
                  items.length,
                  (index) => TransactionCard(
                    item: items[index],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
