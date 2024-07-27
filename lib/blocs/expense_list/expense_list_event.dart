part of 'expense_list_bloc.dart';

@Equatable()
class ExpenseListEvent {
  const ExpenseListEvent();
}

@Equatable()
final class ExpenseListSubscriptionRequested extends ExpenseListEvent {
  const ExpenseListSubscriptionRequested();
}

@Equatable()
final class ExpenseListExpenseDeleted extends ExpenseListEvent {
  const ExpenseListExpenseDeleted({required this.expense});
  final Expense expense;
}

@Equatable()
final class ExpenseListCategoryFilterChanged extends ExpenseListEvent {
  const ExpenseListCategoryFilterChanged(this.filter);
  final Category filter;
}
