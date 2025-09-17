import 'dart:convert';
import 'package:flutter_application_1/modelo/info_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(InfoInitial());

  Future<void> fetchInfo() async {
    emit(InfoLoading());

    try {
      // ⏳ Simula un delay de 3 segundos
      await Future.delayed(const Duration(seconds: 3));

      final response = await http.get(
        Uri.parse(
          "https://mocki.io/v1/1beec591-b450-43cf-98ec-5643e0229573",
        ), // tu URL de mocki aquí
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final info = Info.fromJson(data);
        emit(InfoLoaded(info));
      } else {
        emit(InfoError("Error al obtener la información"));
      }
    } catch (e) {
      emit(InfoError(e.toString()));
    }
  }
}
