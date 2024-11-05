import 'package:flutter/material.dart';
import 'package:flutter_foods/providers/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  AnimationController? _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );

    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Food Delivery',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.alexBrush().fontFamily,
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 1.2),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.17,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height *
                            (1 - _animation.value)),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.83,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Đăng ký',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      GoogleFonts.ibmPlexSerif().fontFamily,
                                  color: Theme.of(context).colorScheme.primary,
                                  letterSpacing: 1.2),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                  labelText: 'Họ tên',
                                  filled: true,
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                labelText: 'Mật khẩu',
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                labelText: 'Tên người dùng',
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: addressController,
                              decoration: const InputDecoration(
                                labelText: 'Địa chỉ',
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Số điện thoại',
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                                  authProvider.login(
                                    usernameController.text,
                                    passwordController.text,
                                  );
                                },
                                child: const Text('Đăng ký'),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: const Text('Đăng nhập'),
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
