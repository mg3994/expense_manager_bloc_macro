import 'package:examples/packages/equatable_macro/lib/src/equatable_macro_base.dart';

import 'category.dart';

@Equatable()
class Expense {
  final String id, title;
  final double amount;
  final DateTime date;
  final Category category; //enum type

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  //todo make a macro for these too
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
        id: json['id'],
        title: json['title'],
        amount: double.tryParse(json['amount']) ?? 0.0,
        date: DateTime.fromMillisecondsSinceEpoch(json['date']),
        category: Category.fromJson(json['category']));
  }
  //toto design a macro

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount.toString(),
      'date': date.microsecondsSinceEpoch,
      'category': category.toJson(),
    };
  }

  Expense copyWith({
    String? title,
    double? amount,
    DateTime? date,
    Category? category,
  }) {
    return Expense(
        id: id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        category: category ?? this.category);
  }
}
