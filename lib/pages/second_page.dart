import 'package:flutter/material.dart';
import 'package:guruh2/providers/container_provider.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<ContainerProvider>().colors.length.toString()),
      ),
      body: ListView.separated(
        itemCount: 3,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            width: 100,
            color: context.read<ContainerProvider>().colors[index],
          );
        },
      ),
    );
  }

  Color showColor(BuildContext context, int index) {
    if (index < context.read<ContainerProvider>().colors.length) {
      return context.read<ContainerProvider>().colors[index];
    } else {
      return Colors.cyan;
    }
  }
}
