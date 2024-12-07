import 'package:flutter/material.dart';

class OtpTextField extends StatelessWidget {
  final bool first;
  final bool last;
  final TextEditingController controller; // Thêm controller vào

  const OtpTextField({
    Key? key,
    required this.first,
    required this.last,
    required this.controller, // Nhận controller trong constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: AspectRatio(
        aspectRatio: 0.6,
        child: TextField(
          controller: controller, // Gắn controller vào TextField
          autofocus: first, // Autofocus cho trường đầu tiên
          keyboardType: TextInputType.number,
          maxLength: 1,
          onChanged: (value) {
            // Chuyển sang trường tiếp theo nếu có
            if (value.length == 1 && !last) {
              FocusScope.of(context).nextFocus();
            } 
            // Quay lại trường trước nếu trường hiện tại bị xóa
            else if (value.isEmpty && !first) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
