import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit2/info_cubit.dart';
import 'package:flutter_application_1/cubit2/info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfoCubit, InfoState>(
      listener: (context, state) {
        if (state is InfoLoaded) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("✅ Datos actualizados")));
        }
      },
      builder: (context, state) {
        if (state is InfoLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is InfoLoaded) {
          return Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.network(
                    state.info.imageUrl,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.info.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.info.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "📅 ${state.info.date}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<InfoCubit>().fetchInfo();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refrescar"),
                  ),
                ],
              ),
            ),
          );
        } else if (state is InfoError) {
          return Column(
            children: [
              Text("❌ ${state.message}"),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<InfoCubit>().fetchInfo();
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Reintentar"),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
