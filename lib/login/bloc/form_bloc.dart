import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
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

      try {
        // 👇 URL de tu JSON (puede ser GitHub o Mocky)
        final url = Uri.parse(
          'https://mocki.io/v1/3eb07405-30da-49e9-bc8b-a3a12292e235',
        );

        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          // 🔹 Aquí validamos el form con el JSON descargado
          if (event.name.isNotEmpty && event.email.contains('@')) {
            print("✅ Petición exitosa: $data");
            emit(state.copyWith(isSubmitting: false, isSuccess: true));
          } else {
            emit(
              state.copyWith(
                isSubmitting: false,
                errorMessage: "Datos inválidos. Revisa el formulario.",
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              isSubmitting: false,
              errorMessage: "Error en la petición: ${response.statusCode}",
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: "⚠️ Excepción: $e"),
        );
      }
    });
  }
}
