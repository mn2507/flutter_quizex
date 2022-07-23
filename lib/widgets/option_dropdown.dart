import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../providers/category.dart';

class OptionDropdown extends StatefulWidget {
  final String title;
  final String defValue;
  final List<Map<String, String>> items;
  final List<Category> category;

  OptionDropdown({
    @required this.title,
    this.defValue,
    this.items,
    this.category,
  });

  @override
  State<OptionDropdown> createState() => _OptionDropdownState();
}

class _OptionDropdownState extends State<OptionDropdown> {
  String _defaultDropdownValue;

  @override
  void didChangeDependencies() {
    _defaultDropdownValue = widget.defValue;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 8.0),
          child: DropdownButton(
            hint: widget.category != null ? const Text('Any') : null,
            value: _defaultDropdownValue,
            items: widget.category == null
                ? widget.items.map((items) {
                    return DropdownMenuItem(
                      value: items['value'],
                      child: Text(items['label']),
                    );
                  }).toList()
                : widget.category.map((category) {
                    return DropdownMenuItem(
                      value: category.id,
                      child: Text(category.name),
                    );
                  }).toList(),
            onChanged: (String newValue) {
              setState(() {
                _defaultDropdownValue = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
