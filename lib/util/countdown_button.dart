import 'package:flutter/material.dart';
import 'dart:async';

import '../generated/l10n.dart';

class CountdownButton extends StatefulWidget {
  final VoidCallback onPressed;

  const CountdownButton({super.key, required this.onPressed});

  @override
  CountdownButtonState createState() => CountdownButtonState();
}

class CountdownButtonState extends State<CountdownButton> {
  late Timer _timer;
  int _countdown = 5;
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown--;
        } else {
          _countdown = 0;
          _isEnabled = true;
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isEnabled ? widget.onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isEnabled ? Colors.red[400] : Colors.grey,
      ),
      child: Text(
        _isEnabled ? S.of(context).confirm : _countdown.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
