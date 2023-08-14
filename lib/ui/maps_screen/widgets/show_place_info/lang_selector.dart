import 'package:dio_example/services/provider/map_provider.dart';
import 'package:dio_example/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LangSelector extends StatefulWidget {
  const LangSelector({Key? key}) : super(key: key);

  @override
  State<LangSelector> createState() => _LangSelectorState();
}

class _LangSelectorState extends State<LangSelector> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: const SizedBox(),
      value: context.watch<MapProvider>().newLAng,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      onChanged: (String? value) {
        context.read<MapProvider>().updateLangvalue(value);
        context.read<MapProvider>().updateLang();
      },
      items: langList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue,
            ),
            child: Text(
              value == "uz_UZ"
                  ? "Uzbek"
                  : value == "ru_RU"
                      ? "Russian"
                      : value == "en_US"
                          ? "English"
                          : value == "tr_TR"
                              ? "Turkish"
                              : value,
            ),
          ),
        );
      }).toList(),
    );
  }
}
