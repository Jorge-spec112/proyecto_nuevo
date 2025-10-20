import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/cubit2/info_cubit.dart';
import 'package:flutter_application_1/data/cubit2/info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfoCubit, InfoState>(
      listener: (context, state) {
        if (state is InfoLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Datos actualizados")),
          );
        }
      },
      builder: (context, state) {
        if (state is InfoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is InfoLoaded) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.info.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.info.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "📅 ${state.info.date}",
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => context.read<InfoCubit>().fetchInfo(),
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text("Refrescar", style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is InfoError) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("❌ ${state.message}", style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 6),
              ElevatedButton.icon(
                onPressed: () => context.read<InfoCubit>().fetchInfo(),
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text("Reintentar", style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
