import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:mobile_reporting/features/login/cubit/login_bloc.dart';
import 'package:mobile_reporting/features/login/cubit/login_state.dart';
import 'package:mobile_reporting/constant/bottom_bar/bottom_main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is LoginSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => const BottomMain()),
          );
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Selamat Datang, ${state.data.data?.user?.name}")),

          );
        }

        if (state is LoginError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: Image.asset(
                'assets/images/victor.png',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.62,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                  child: Column(
                    children: [
                      const Text(
                        "Selamat Datang!",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Silahkan Masuk untuk melanjutkan",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 35),
                      _buildInputLabel("Username"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: "Masukan Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInputLabel("Kata Sandi"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: _isPasswordHidden,
                        decoration: InputDecoration(
                          hintText: "Masukan Kata Sandi",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Lupa Kata Sandi?",
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E59D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            final email = _usernameController.text;
                            final pass = _passwordController.text;
                            
                            if(email.isNotEmpty && pass.isNotEmpty) {
                              context.read<LoginBloc>().login(email, pass);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Isi semua field!")),
                              );
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/logo-sasmita.png',
                            height: 40,
                          ),
                          const SizedBox(width: 20),
                          Image.asset(
                            'assets/icons/logo-unpam.png',
                            height: 40,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "Kebijakan Privasi",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}