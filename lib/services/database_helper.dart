import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/expense.dart';

class DatabaseHelper {
  final String apiUrl =
      'http://103.196.155.42/api/keuangan/pengeluaran'; // URL API Anda

  // Metode untuk mendapatkan semua pengeluaran
  Future<List<Expense>> getExpenses() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Expense.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  // Metode untuk menambahkan pengeluaran
  Future<void> insertExpense(Expense expense) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "data": {
          "expense": expense.expense,
          "cost": expense.cost,
          "category": expense.category,
        }
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to insert expense');
    }
  }

  // Metode untuk memperbarui pengeluaran
  Future<void> updateExpense(Expense expense) async {
    // Implementasikan jika diperlukan
  }

  // Metode untuk menghapus pengeluaran
  Future<void> deleteExpense(int id) async {
    // Implementasikan jika diperlukan
  }
}
