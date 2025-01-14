import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/providers/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  AnimationController? _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );

    _animationController!.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(usernameFocusNode);
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    usernameFocusNode.dispose();
    super.dispose();
  }
Future<void> _login(BuildContext context, AuthProvider authProvider) async {
    try {
      await authProvider.login(
        usernameController.text,
        passwordController.text,                                                    
      );
       await authProvider.initialize();
      if (authProvider.isAuthenticated) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Thông tin đăng nhập sai, vui lòng kiểm tra lại tài khoản và mật khẩu.")),
        );
      }
    } catch (e) {
      print("Login failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    // Access AuthProvider via Provider.of
    final authProvider = Provider.of<AuthProvider>(context);

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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Đăng nhập',
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
                            controller: usernameController,
                            focusNode: usernameFocusNode,
                            decoration: const InputDecoration(
                                labelText: 'Tên người dùng',
                                filled: true,
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Mật khẩu',
                              filled: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                // Perform login logic
                                _login(context, authProvider);
                              },
                              child: const Text('Đăng nhập'),
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: const Text('Đăng ký'),
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/forgot-password');
                              },
                              child: const Text('Quên mật khẩu'),
                            ),
                          ),
                        ],
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
