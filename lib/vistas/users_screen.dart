import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit2/info_cubit.dart';
import 'package:flutter_application_1/vistas/info_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/users_cubit.dart';
import '../cubit/users_state.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Usuarios Registrados")),
      body: Column(
        children: [
          // 👤 Lista de usuarios
          Expanded(
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserInitial) {
                  return const Center(
                    child: Text("No hay usuarios registrados."),
                  );
                } else if (state is UserLoaded) {
                  if (state.users.isEmpty) {
                    return const Center(child: Text("Lista vacía."));
                  }
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),

          const Divider(),

          // 📌 Widget independiente con info del backend
          BlocProvider(
            create: (_) => InfoCubit()..fetchInfo(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: InfoWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
