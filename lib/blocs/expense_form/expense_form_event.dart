part of 'expense_form_bloc.dart';

@Equatable()
abstract class ExpenseFormEvent {
  const ExpenseFormEvent();
}

@Equatable()
final class ExpenseTitleChanged extends ExpenseFormEvent {
  const ExpenseTitleChanged(this.title);
  final String title;
}

@Equatable()
final class ExpenseAmountChanged extends ExpenseFormEvent {
  const ExpenseAmountChanged(this.amount);
  final String amount;
}

@Equatable()
final class ExpenseDateChanged extends ExpenseFormEvent {
  const ExpenseDateChanged(this.date);
  final DateTime date;
}

@Equatable()
final class ExpenseCategoryChanged extends ExpenseFormEvent {
  const ExpenseCategoryChanged(this.category);
  final Category category;
}

@Equatable()
final class ExpenseSubmitted extends ExpenseFormEvent {
  const ExpenseSubmitted();
}
