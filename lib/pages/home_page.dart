import 'package:budget_tracker/widgets/transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../view_models/budget_view_model.dart';
import '../widgets/transaction_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                    final budgetService =
                        Provider.of<BudgetViewModel>(context, listen: false);
                    budgetService.addItem(transactionItem);
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
                  child: Consumer<BudgetViewModel>(
                    builder: ((context, value, child) {
                      final balance = value.getBalance();
                      final budget = value.getBudget();
                      double percentage = balance / budget;
                      // Making sure percentage isnt negative and isnt bigger than 1
                      if (percentage < 0) {
                        percentage = 0;
                      }
                      if (percentage > 1) {
                        percentage = 1;
                      }

                      return CircularPercentIndicator(
                        radius: screenSize.width / 4,
                        lineWidth: 10.0,
                        percent: balance / budget,
                        backgroundColor: Colors.white,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "\$${balance.toString().split(".")[0]}",
                              style: const TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Balance',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Budget: \$ $budget',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        progressColor: Theme.of(context).colorScheme.primary,
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  "Items",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Consumer<BudgetViewModel>(
                  builder: ((context, value, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.items.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TransactionCard(
                            item: value.items[index],
                          );
                        });
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
