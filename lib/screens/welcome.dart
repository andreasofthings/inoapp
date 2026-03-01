import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/auth_service.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundDark,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or App Name
                const Spacer(),
                const Icon(
                  Icons.auto_awesome_mosaic_rounded,
                  size: 80,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Welcome to Pod',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your innovation methodology toolkit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const Spacer(),
                
                // Login Buttons
                _LoginButton(
                  onPressed: () async {
                    final success = await authService.loginWithGoogle();
                    if (success && context.mounted) {
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                  icon: Icons.login,
                  label: 'Login with Google',
                  color: Colors.white,
                  textColor: AppColors.backgroundDark,
                ),
                const SizedBox(height: 16),
                _LoginButton(
                  onPressed: () async {
                    final success = await authService.loginWithPramari();
                    if (success && context.mounted) {
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                  icon: Icons.vignette_rounded,
                  label: 'Login with pramari.de',
                  color: AppColors.primary,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;

  const _LoginButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
