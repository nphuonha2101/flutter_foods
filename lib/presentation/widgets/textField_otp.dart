import 'package:flutter/material.dart';

class OtpTextField extends StatelessWidget {
  final bool first;
  final bool last;

  const OtpTextField({
    Key? key,
    required this.first,
    required this.last,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: AspectRatio(
        aspectRatio: 0.6,
        child: TextField(
          autofocus: first,
          onChanged: (value) {
            if (value.length == 1 && !last) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty && !first) {
              FocusScope.of(context).previousFocus();
            } 
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
