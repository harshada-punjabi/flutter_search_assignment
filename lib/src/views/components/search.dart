import 'package:flutter/material.dart';

class MySearch extends StatefulWidget {
  final void Function(String)? onChanged;
  final String? hintText;
  int? value;
  void Function(int?)? selectedAgeGroup;
  MySearch(
      {Key? key,
      this.onChanged,
      this.hintText,
      required this.selectedAgeGroup,
      this.value})
      : super(key: key);

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        autofocus: false,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search),
            hintText: widget.hintText,
            suffixIcon: DropdownButton<int>(
              value: widget.value,
              onChanged: widget.selectedAgeGroup,
              items: [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('All Ages'),
                ),
                for (int lowerBound = 20; lowerBound <= 60; lowerBound += 10)
                  DropdownMenuItem<int>(
                    value: lowerBound,
                    child: Text('$lowerBound - ${lowerBound + 9} years'),
                  ),
              ],
            )),
      ),
    );
  }
}
