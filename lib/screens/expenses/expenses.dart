import 'package:chick_chack_beta/screens/expenses/new_expense.dart';
import 'package:chick_chack_beta/styles/styled_text.dart';
import 'package:chick_chack_beta/widgets/expenses_list.dart';
import 'package:chick_chack_beta/models/expense.dart';
import 'package:flutter/material.dart';

import 'package:chick_chack_beta/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  // עמוד הוצאות הכולל רשימת הוצאות והוספת הוצאה
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}



class _ExpensesState extends State<Expenses> {
  final List<Expense> _registefExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 499.00,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 43.00,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Hamburger',
      amount: 87.90,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        //פותח את חלונית הוספת המשימה
        //useSafeArea: true,F
        isScrollControlled: true, //גורם לחלונית להיות על מסך מלא
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      //מקבלת "הוצאה" ומוסיפה אותו לרשימת ההוצאות
      _registefExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registefExpenses.indexOf(expense); //potion
    setState(() {
      //מקבלת "הוצאה" ומוסיפה אותו לרשימת ההוצאות
      _registefExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const StyledText(
            outText: 'Expense deleted!',
            size: 25,
            color: Color.fromARGB(255, 237, 32, 17)),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registefExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);  בדיקה של רוחב וגובה המכשיר (בשכיבה/עמידה)
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(
      child: StyledText(
          outText:
              'No expenses found. To add press on + button in the right top',
          size: 50,
          color: Colors.black),
    );

    if (_registefExpenses.isNotEmpty) {
      //כשאר רשימת ההוצאות אינה ריקה
      mainContent = ExpensesList(
        expenses: _registefExpenses,
        // onRemoveExpense: _removeExpense,
      );
    }
    
    

    return Scaffold(
      appBar: AppBar(
        title: const StyledText(
            outText: 'ExpenseTracker Chick-Chack',
            size: 25,
            color: Colors.grey),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
            iconSize: 35,
            color: Colors.grey,
          ),
        ],
      ),
      body: width < height
          ? Column(
              children: [
                const StyledText.title(
                  'the chart',
                ),
                Chart(expenses: _registefExpenses),
                Expanded(
                  //סידור מסויים
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registefExpenses),
                ),
                Expanded(
                  //סידור מסויים
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
