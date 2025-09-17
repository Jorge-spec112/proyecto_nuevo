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
      // 👉 Aquí usas tu backend o mockapi
      final response = await http.get(
        Uri.parse("https://mocki.io/v1/f61d06e0-d4ba-40ce-bf2f-41557c047a31"),
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
