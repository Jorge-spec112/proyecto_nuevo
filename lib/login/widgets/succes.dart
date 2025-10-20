import 'package:flutter/material.dart';

class Succes extends StatelessWidget {
  final List users; // 👈 Recibe la lista de usuarios

  const Succes({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: const Icon(Icons.person),
          title: Text(user.name),
          subtitle: Text(user.email),
        );
      },
    );
  }
}
