import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/database_helper.dart';

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<Expense>> futureExpenses;

  @override
  void initState() {
    super.initState();
    futureExpenses = dbHelper.getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengeluaran'),
        backgroundColor: const Color.fromARGB(255, 232, 173, 85),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToDetailScreen(),
          ),
        ],
      ),
      body: Container(
        color: Colors.yellow[50],
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Expense>>(
          future: futureExpenses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No expenses found.'));
            } else {
              return SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('Expense')),
                    DataColumn(label: Text('Cost')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: List<DataRow>.generate(snapshot.data!.length, (index) {
                    final expense = snapshot.data![index];
                    return DataRow(cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(expense.expense,
                          style: TextStyle(fontSize: 12))),
                      DataCell(Text('${expense.cost}',
                          style: TextStyle(fontSize: 12))),
                      DataCell(Text(expense.category,
                          style: TextStyle(fontSize: 12))),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, size: 16),
                              onPressed: () => _navigateToDetailScreen(expense),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, size: 16),
                              onPressed: () => _confirmDelete(expense.id!),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _navigateToDetailScreen([Expense? expense]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailScreen(
          expense: expense,
          onSave: (Expense newExpense) {
            if (expense == null) {
              dbHelper.insertExpense(newExpense);
            } else {
              dbHelper.updateExpense(newExpense);
            }
            setState(() {
              futureExpenses = dbHelper.getExpenses();
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus pengeluaran ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _deleteExpense(id);
                Navigator.of(context).pop(); // Tutup dialog setelah menghapus
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _deleteExpense(int id) {
    dbHelper.deleteExpense(id).then((_) {
      setState(() {
        futureExpenses = dbHelper.getExpenses();
      });
    });
  }
}

class ExpenseDetailScreen extends StatelessWidget {
  final Expense? expense;
  final Function(Expense) onSave;

  final TextEditingController expenseController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  ExpenseDetailScreen({this.expense, required this.onSave}) {
    if (expense != null) {
      expenseController.text = expense!.expense;
      costController.text = expense!.cost.toString();
      categoryController.text = expense!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expense == null ? 'Add Expense' : 'Edit Expense'),
        backgroundColor: const Color.fromARGB(255, 232, 173, 85),
      ),
      body: Container(
        color: Colors.yellow[50],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: expenseController,
              decoration: InputDecoration(labelText: 'Expense'),
            ),
            TextField(
              controller: costController,
              decoration: InputDecoration(labelText: 'Cost'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newExpense = Expense(
                  id: expense?.id,
                  expense: expenseController.text,
                  cost: int.parse(costController.text),
                  category: categoryController.text,
                );
                onSave(newExpense);
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 232, 173, 85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
