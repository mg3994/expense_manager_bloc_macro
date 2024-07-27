import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:examples/models/category.dart';
import 'package:examples/repositories/expense_repository.dart';

import '../../models/expense.dart';
import '../../packages/equatable_macro/lib/equatable_macro.dart';

part 'expense_list_event.dart';
part 'expense_list_state.dart';

class ExpenseListBloc extends Bloc<ExpenseListEvent, ExpenseListState> {
  ExpenseListBloc({
    required ExpenseRepository repository,
  })  : _repository = repository,
        super(const ExpenseListState()) {
    on<ExpenseListSubscriptionRequested>(_onSubscriptionsRequested);
    on<ExpenseListExpenseDeleted>(_onExpenseDeleted);
    on<ExpenseListCategoryFilterChanged>(_onExpenseCategoryFilterChanged);
  }
  final ExpenseRepository _repository;

  FutureOr<void> _onSubscriptionsRequested(
      ExpenseListSubscriptionRequested event,
      Emitter<ExpenseListState> emit) async {
    emit(state.copyWith(
      status: () => ExpenseListStatus.loading,
    ));
    final stream = _repository.getAllExpenses();
    await emit.forEach<List<Expense?>>(
      stream,
      onData: (expenses) => state.copyWith(
        status: () => ExpenseListStatus.success,
        expenses: () => expenses,
        totalExpenses: () => expenses
            .map((currentExpense) => currentExpense?.amount)
            .fold(0.0, (a, b) => a + b!.toDouble()),
      ),
      onError: (error, stackTrace) => state.copyWith(
        status: () => ExpenseListStatus.failure,
      ),
    );
  }

  FutureOr<void> _onExpenseDeleted(
      ExpenseListExpenseDeleted event, Emitter<ExpenseListState> emit) async {
    await _repository.deleteExpense(event.expense.id);
  }

  FutureOr<void> _onExpenseCategoryFilterChanged(
      ExpenseListCategoryFilterChanged event,
      Emitter<ExpenseListState> emit) async {
    emit(state.copyWith(
      filter: () => event.filter,
    ));
  }
}
