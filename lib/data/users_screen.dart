import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/cubit2/info_cubit.dart';
import 'package:flutter_application_1/data/info_widget.dart';
import 'package:flutter_application_1/login/widgets/failure.dart';
import 'package:flutter_application_1/login/widgets/initial.dart';
import 'package:flutter_application_1/login/widgets/succes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/users_cubit.dart';
import 'cubit/users_state.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Usuarios Registrados")),
      body: Stack(
        children: [
          // 🌄 Fondo gráfico tipo paisaje
          Positioned.fill(
            child: CustomPaint(
              painter: _LandscapePainter(),
            ),
          ),

          // 🖼️ Imagen decorativa sobre el fondo
          Positioned(
            top: 40, // posición vertical
            right: 0,
            left: 0,
            child: Center(
              child: Image.asset(
                "assets/icono.png", // 📍 tu imagen local
                width: 120, // tamaño ajustable
                height: 120,
              ),
            ),
          ),

          // 👤 Contenido principal (widgets existentes)
          Column(
            children: [
              const SizedBox(height: 160), // 🔹 espacio para la imagen

              Expanded(
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserInitial) {
                      return Initial();
                    } else if (state is UserLoaded) {
                      if (state.users.isEmpty) {
                        return Failure();
                      }
                      return Succes(users: state.users);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),

              const Divider(),

              // 📌 InfoWidget más pequeño
              BlocProvider(
                create: (_) => InfoCubit()..fetchInfo(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 150,
                    child: InfoWidget(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // 🌤️ Cielo azul
    paint.color = const Color(0xFFB3E5FC);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // ☁️ Nubes
    paint.color = Colors.white;
    final cloudPath = Path()
      ..moveTo(0, size.height * 0.25)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.15,
          size.width * 0.5, size.height * 0.25)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.35,
          size.width, size.height * 0.25)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(cloudPath, paint);

    // 🌳 Colinas verdes
    paint.color = const Color(0xFF81C784);
    final hillPath = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.25, size.height * 0.6, size.width * 0.5, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.8, size.width, size.height * 0.7)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(hillPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
