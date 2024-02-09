import 'package:flutter/material.dart';

class Couner extends StatefulWidget {
  final double item;
  const Couner({
    super.key,
    required this.item,
  });

  @override
  State<Couner> createState() => _CounerState();
}

class _CounerState extends State<Couner> {
  dynamic value = 0.5;
  var hintText = 0.5;

  void _userCount(valueStr) {
    setState(() {
      var wrap = double.parse('$valueStr');
      value = wrap;
    });
  }

  void add() {
    setState(() {
      value = value + 0.1;
    });
  }

  void remove() {
    setState(() {
      value = value - 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: add,
                child: const Icon(Icons.add),
              ),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: '${value.toStringAsFixed(1)}'),
                  onChanged: (value) {},
                  onSubmitted: (value) {
                    _userCount(value);
                    value = '';
                  },
                ),
              ),
              ElevatedButton(
                onPressed: remove,
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text('${value.toStringAsFixed(1)}'),
        ),
      ],
    );
  }
}

class AppBars extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBars({
    super.key,
    required this.title,
  }) : _title = title;

  final String _title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
