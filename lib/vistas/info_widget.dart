import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/cubit2/info_cubit.dart';
import 'package:flutter_application_1/cubit/cubit2/info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoCubit, InfoState>(
      builder: (context, state) {
        if (state is InfoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is InfoLoaded) {
          return Column(
            children: [
              Image.network(state.info.imageUrl, height: 150),
              const SizedBox(height: 8),
              Text(
                state.info.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else if (state is InfoError) {
          return Text("❌ ${state.message}");
        }
        return const SizedBox();
      },
    );
  }
}
