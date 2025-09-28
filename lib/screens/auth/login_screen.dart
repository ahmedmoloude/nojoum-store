import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        Navigator.of(context).pop(true); // Return success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Connexion réussie!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de connexion: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
        backgroundColor: AppConstants.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.paddingXL),
                
                // Logo or App Name
                Text(
                  AppConstants.appName,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: AppConstants.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppConstants.paddingL),
                
                Text(
                  'Connectez-vous pour publier vos applications',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppConstants.paddingXL),
                
                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre email';
                    }
                    if (!value.contains('@')) {
                      return 'Veuillez saisir un email valide';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppConstants.paddingM),
                
                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre mot de passe';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppConstants.paddingL),
                
                // Login Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Se connecter'),
                ),
                
                const SizedBox(height: AppConstants.paddingM),
                
                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Pas encore de compte? '),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text('Créer un compte'),
                    ),
                  ],
                ),
                
                const Spacer(),
                
                // Guest Mode Button
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Return to app without login
                  },
                  child: const Text('Continuer sans compte'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
