import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_event.dart';
import 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormState()) {
    on<SubmitForm>((event, emit) async {
      emit(
        state.copyWith(
          isSubmitting: true,
          isSuccess: false,
          errorMessage: null,
        ),
      );

      await Future.delayed(const Duration(seconds: 1)); // Simula petición API

      if (event.name.isNotEmpty && event.email.contains('@')) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: "Datos inválidos. Revisa el formulario.",
          ),
        );
      }
    });
  }
}
