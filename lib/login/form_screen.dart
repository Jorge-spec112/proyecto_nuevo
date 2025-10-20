import 'package:flutter/material.dart' hide FormState;
import 'package:flutter_application_1/login/bloc/form_bloc.dart' show FormBloc;
import 'package:flutter_application_1/login/bloc/form_event.dart';
import 'package:flutter_application_1/login/bloc/form_state.dart' show FormState;
import 'package:flutter_application_1/data/cubit/users_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario con BLoC")),
      body: BlocConsumer<FormBloc, FormState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.read<UserCubit>().addUser(
              _nameController.text,
              _emailController.text,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Usuario registrado con éxito!")),
            );

            Navigator.pushNamed(context, '/users');
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Nombre"),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Correo"),
                ),
                const SizedBox(height: 20),
                state.isSubmitting
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          context.read<FormBloc>().add(
                            SubmitForm(
                              _nameController.text,
                              _emailController.text,
                            ),
                          );
                        },
                        child: const Text("Registrar"),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
