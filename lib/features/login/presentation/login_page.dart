import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/constant/widgets/custom_text_field.dart';
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
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
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
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is LoginSuccess) {
          Navigator.pop(context);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomMain()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Selamat Datang, ${state.data.data?.user?.name}"),
            ),
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
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: Image.asset('assets/images/victor.png', fit: BoxFit.cover),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 35,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Selamat Datang!",
                        style: TextConfig.loginTitle,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Silakan Masuk untuk Melanjutkan",
                        style: TextConfig.loginSubTitle,
                      ),
                      const SizedBox(height: 35),
                      _buildInputLabel("Username"),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: usernameController,
                        hintText: "Masukan Username",
                      ),

                      const SizedBox(height: 20),
                      _buildInputLabel("Kata Sandi"),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: passwordController,
                        obscureText: _isPasswordHidden,
                        hintText: "Masukan Kata Sandi",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordHidden = !_isPasswordHidden;
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Lupa Kata Sandi?",
                            style: TextConfig.labelBoldSmall,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            final email = usernameController.text;
                            final pass = passwordController.text;

                            if (email.isNotEmpty && pass.isNotEmpty) {
                              context.read<LoginBloc>().login(email, pass);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Isi semua field!"),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextConfig.textButton,
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
                        style: TextConfig.loginFooter,
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
      child: Text(text, style: TextConfig.labelForm),
    );
  }
}
