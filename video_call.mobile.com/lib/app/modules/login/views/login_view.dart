import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _LoginBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      _Header(),
                      const SizedBox(height: 32),
                      _LoginCard(controller: controller),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginBackground extends StatelessWidget {
  const _LoginBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F2027),
            Color(0xFF203A43),
            Color(0xFF2C5364),
          ],
        ),
      ),
      child: Stack(
        children: const [
          Positioned(
            top: -60,
            left: -40,
            child: _GlowBlob(
              size: 180,
              color: Color(0x3328C76F),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -30,
            child: _GlowBlob(
              size: 200,
              color: Color(0x332B9ED4),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowBlob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 40,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Icons.video_call,
            size: 48,
            color: Color(0xFF39D98A),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Welcome back',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to start your secure call session.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class _LoginCard extends StatelessWidget {
  final LoginController controller;

  const _LoginCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 30,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Account details',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF203A43),
            ),
          ),
          const SizedBox(height: 16),
          _UserIdField(controller: controller),
          const SizedBox(height: 16),
          _PasswordField(controller: controller),
          const SizedBox(height: 24),
          _SignInButton(controller: controller),
        ],
      ),
    );
  }
}

class _UserIdField extends StatelessWidget {
  final LoginController controller;

  const _UserIdField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.userIdController,
      onChanged: controller.onUserIdChanged,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'User ID',
        prefixIcon: const Icon(Icons.badge_outlined),
        filled: true,
        fillColor: const Color(0xFFF3F5F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final LoginController controller;

  const _PasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        obscureText: !controller.passwordVisible.value,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            onPressed: controller.togglePasswordVisibility,
            icon: Icon(
              controller.passwordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
          filled: true,
          fillColor: const Color(0xFFF3F5F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  final LoginController controller;

  const _SignInButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: controller.userId.value.isEmpty
            ? null
            : () => controller.signIn(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color(0xFF39D98A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: controller.isBusy.value
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Sign In',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
