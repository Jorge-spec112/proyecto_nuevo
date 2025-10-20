import 'dart:convert';
import 'package:flutter_application_1/modelo/modelo.dart';
import 'package:flutter_application_1/data/cubit/users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final List<User> _users = [];

  // 👉 Método para agregar usuarios manualmente
  Future<void> addUser(String name, String email) async {
    emit(UserLoading());

    await Future.delayed(const Duration(seconds: 1));

    _users.add(User(name, email));

    emit(UserLoaded(List<User>.from(_users)));
  }

  // 👉 Método para traer usuarios desde API
  Future<void> fetchUsers() async {
    emit(UserLoading());

    try {
      final url = Uri.parse(
        'https://mocki.io/v1/3eb07405-30da-49e9-bc8b-a3a12292e235',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final users = (data as List)
            .map((json) => User.fromJson(json))
            .toList();

        // 🚀 Combina usuarios de API + los locales
        _users.addAll(users as Iterable<User>);

        emit(UserLoaded(List<User>.from(_users)));
      } else {
        emit(UserError("Error HTTP: ${response.statusCode}"));
      }
    } catch (e) {
      emit(UserError("Excepción: $e"));
    }
  }
}
