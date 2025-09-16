import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/form_bloc.dart';
import 'package:flutter_application_1/vistas/form_screen.dart';
import 'package:flutter_application_1/cubit/users_cubit.dart';
import 'package:flutter_application_1/vistas/users_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FormBloc()),
        BlocProvider(create: (_) => UserCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc & Cubit Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const FormScreen(),
        routes: {'/users': (_) => const UserScreen()},
      ),
    );
  }
}
