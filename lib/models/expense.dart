class Expense {
  final int? id;
  final String expense;
  final int cost;
  final String category;

  Expense(
      {this.id,
      required this.expense,
      required this.cost,
      required this.category});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expense': expense,
      'cost': cost,
      'category': category,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      expense: json['expense'],
      cost: json['cost'],
      category: json['category'],
    );
  }
}
