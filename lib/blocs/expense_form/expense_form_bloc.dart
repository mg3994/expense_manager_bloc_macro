import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:examples/models/expense.dart';

import 'package:examples/packages/equatable_macro/lib/src/equatable_macro_base.dart';

import 'package:examples/repositories/expense_repository.dart';

import '../../models/category.dart';

part 'expense_form_event.dart';
part 'expense_form_state.dart';

class ExpenseFormBloc extends Bloc<ExpenseFormEvent, ExpenseFormState> {
  ExpenseFormBloc({
    required ExpenseRepository repository,
    Expense? initialExpense,
  })  : _repository = repository,
        super(ExpenseFormState(
          initialExpense: initialExpense,
          title: initialExpense?.title,
          amount: initialExpense?.amount,
          date: initialExpense?.date ?? DateTime.now(),
          category: initialExpense?.category ?? Category.other,
        )) {
    on<ExpenseTitleChanged>(_onTitleChanged);
    on<ExpenseAmountChanged>(_onAmountChanged);
    on<ExpenseDateChanged>(_onDateChanged);
    on<ExpenseCategoryChanged>(_onCategoryChanged);
    on<ExpenseSubmitted>(_onSubmitted);
  }
  final ExpenseRepository _repository;

  FutureOr<void> _onTitleChanged(
      ExpenseTitleChanged event, Emitter<ExpenseFormState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _onAmountChanged(
      ExpenseAmountChanged event, Emitter<ExpenseFormState> emit) {
    emit(state.copyWith(amount: double.parse(event.amount)));
  }

  FutureOr<void> _onDateChanged(
      ExpenseDateChanged event, Emitter<ExpenseFormState> emit) {
    emit(state.copyWith(date: event.date));
  }

  FutureOr<void> _onCategoryChanged(
      ExpenseCategoryChanged event, Emitter<ExpenseFormState> emit) {
    emit(state.copyWith(category: event.category));
  }

  FutureOr<void> _onSubmitted(
      ExpenseSubmitted event, Emitter<ExpenseFormState> emit) async {
    final expense = (state.initialExpense)?.copyWith(
          title: state.title,
          amount: state.amount,
          date: state.date,
          category: state.category,
        ) ??
        Expense(
            id: Random()
                .nextInt(10000)
                .toString(), //get the last int stored in db the maxlast int id say biggest then +1
            title: state
                .title!, //validation already applied to check can't be null
            amount: state
                .amount!, //validation already applied to check can't be null
            date: state.date,
            category: state.category);

    emit(state.copyWith(status: ExpenseFormStatus.loading));
    try {
      await _repository.createExpense(expense);
      emit(state.copyWith(status: ExpenseFormStatus.success));
      emit(ExpenseFormState(date: DateTime.now()));
    } catch (e) {
      emit(state.copyWith(status: ExpenseFormStatus.failure));
    }
  }
}
