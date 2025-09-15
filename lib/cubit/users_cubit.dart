import 'package:flutter_application_1/cubit/modelo.dart';
import 'package:flutter_application_1/cubit/users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final List<User> _users = [];

  Future<void> addUser(String name, String email) async {
    // 🔥 Estado de carga
    emit(UserLoading());

    // ⏳ Simula llamada a la API
    await Future.delayed(const Duration(seconds: 1));

    // ✅ Agrega usuario
    _users.add(User(name, email));

    // 🔄 Devuelve lista actualizada
    emit(UserLoaded(List<User>.from(_users)));
  }
}
