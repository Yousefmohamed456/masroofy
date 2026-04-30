import 'dart:async';
import 'package:flutter/material.dart';

class PinScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final void Function(String pin)? onPinEntered;

  const PinScreen({
    super.key,
    this.title = 'Enter a 4-digit PIN',
    this.subtitle = 'Used to unlock the app later',
    this.onPinEntered,
  });

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String _pin = '';
  bool _isLoading = false;
  String _dots = '';
  Timer? _timer;

  void _startLoading() {
    setState(() => _isLoading = true);
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dots = _dots.length >= 3 ? '' : '$_dots.';
      });
    });
  }

  void _stopLoading() {
    _timer?.cancel();
    setState(() {
      _isLoading = false;
      _dots = '';
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onKeyPressed(String value) {
    if (_isLoading) return;
    if (_pin.length < 4) {
      setState(() => _pin += value);
    }
  }

  void _onDelete() {
    if (_isLoading) return;
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                _isLoading ? "جاري التحقق$_dots" : widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 6),
              if (!_isLoading)
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, color: Colors.black38),
                ),
              const SizedBox(height: 32),
              _PinDisplay(pin: _pin),
              const SizedBox(height: 36),
              _Keypad(
                onKeyPressed: _onKeyPressed,
                onDelete: _onDelete,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: (_pin.length == 4 && !_isLoading)
                      ? () {
                    _startLoading();
                    widget.onPinEntered?.call(_pin);
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    disabledBackgroundColor: const Color(0xFFB0BEC5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                      : const Text(
                    'UNLOCK',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PinDisplay extends StatelessWidget {
  final String pin;
  const _PinDisplay({required this.pin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(color: const Color(0xFFD0D0D0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final filled = index < pin.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              filled ? pin[index] : '–',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: filled ? Colors.black87 : Colors.black26,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  final void Function(String) onKeyPressed;
  final VoidCallback onDelete;

  const _Keypad({required this.onKeyPressed, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', 'del'],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: row.map((key) {
              if (key.isEmpty) return const Expanded(child: SizedBox());
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _KeyButton(
                    label: key,
                    onTap: () => key == 'del' ? onDelete() : onKeyPressed(key),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class _KeyButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _KeyButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDelete = label == 'del';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: isDelete
            ? const Icon(Icons.backspace_outlined, size: 22, color: Color(0xFF555555))
            : Text(
          label,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFF222222)),
        ),
      ),
    );
  }
}