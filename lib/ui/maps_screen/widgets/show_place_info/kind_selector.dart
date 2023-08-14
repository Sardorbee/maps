import 'package:dio_example/services/provider/map_provider.dart';
import 'package:dio_example/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KindSelector extends StatefulWidget {
  const KindSelector({Key? key}) : super(key: key);

  @override
  State<KindSelector> createState() => _KindSelectorState();
}

class _KindSelectorState extends State<KindSelector> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: const SizedBox(),
      value: context.watch<MapProvider>().dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      onChanged: (String? value) {
        context.read<MapProvider>().updateDropdownValue(value);
        context.read<MapProvider>().updateKind();
      },
      items: kindList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: Text(value)),
        );
      }).toList(),
    );
  }
}
