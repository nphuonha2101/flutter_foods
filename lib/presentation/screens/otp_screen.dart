import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/widgets/textField_otp.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:Theme.of(context).scaffoldBackgroundColor, 
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 18),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.lightGreenAccent.shade100, 
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/food_delivery.png'),
              ),
              SizedBox(height: 24),
              Text(
                'Xác minh',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Nhập mã OTP của bạn",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OtpTextField(first: true, last: false),
                        OtpTextField(first: false, last: false),
                        OtpTextField(first: false, last: false),
                        OtpTextField(first: false, last: false),
                        OtpTextField(first: false, last: false),
                        OtpTextField(first: false, last: true),
                      ],
                    ),
                    SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Xác nhận',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 18),
              Text(
                "Bạn chưa nhận được mã?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18),
              Text(
                "Gửi lại mã mới",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor, 
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
