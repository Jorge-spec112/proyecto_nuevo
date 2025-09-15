import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/users_cubit.dart';
import 'package:flutter_application_1/cubit/users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Usuarios Registrados")),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoaded && state.users.isNotEmpty) {
            final lastUser = state.users.last;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Nuevo usuario: ${lastUser.name}")),
            );
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              return const Center(child: Text("No hay usuarios registrados."));
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
    );
  }
}
