import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onChanged;

  PinField({required this.length, required this.onChanged});

  @override
  _PinFieldState createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  final TextEditingController _controller = TextEditingController();
  late List<String> _pin;

  @override
  void initState() {
    super.initState();
    _pin = List<String>.filled(widget.length, '');
    _controller.addListener(() {
      setState(() {
        final text = _controller.text;
        for (int i = 0; i < widget.length; i++) {
          if (i < text.length) {
            _pin[i] = text[i];
          } else {
            _pin[i] = '';
          }
        }
        widget.onChanged(text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            SystemChannels.textInput.invokeMethod('TextInput.show');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(widget.length, (index) {
              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  _pin[index].isEmpty ? '' : '•',
                  style: TextStyle(fontSize: 24),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 1),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(widget.length),
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: "",
          ),
          style: TextStyle(color: Colors.transparent),
          cursorColor: Colors.black,
          enableInteractiveSelection: false,
        ),
      ],
    );
  }
}
