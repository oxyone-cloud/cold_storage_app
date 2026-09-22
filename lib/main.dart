import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ColdStorageApp());
}

class ColdStorageApp extends StatelessWidget {
  const ColdStorageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stockage Cold - Version Premium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0277BD)),
        useMaterial3: true,
      ),
      home: const AdminLoginScreen(),
    );
  }
}

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  // Mot de passe admin par défaut (vous pourrez le modifier ici si besoin)
  final String _adminPassword = "admin";

  Future<void> _launchDemoVideo() async {
    final Uri youtubeUri = Uri.parse('https://www.youtube.com/watch?v=LH3mdwrCKKM');
    if (await canLaunchUrl(youtubeUri)) {
      await launchUrl(youtubeUri, mode: LaunchMode.externalApplication);
    }
  }

  void _handleLogin() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (_passwordController.text == _adminPassword) {
          // Navigation vers le tableau de bord principal
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ColdDashboardScreen()),
          );
        } else {
          setState(() {
            _errorMessage = 'Mot de passe incorrect (essayez "admin")';
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.ac_unit, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'OxyONE - Stockage Cold [PREMIUM]',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0277BD),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.admin_panel_settings, size: 70, color: Color(0xFF0277BD)),
                const SizedBox(height: 16),
                const Text(
                  'Espace Administrateur',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0277BD)),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'VERSION PREMIUM',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0277BD)),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  onSubmitted: (_) => _handleLogin(),
                  decoration: InputDecoration(
                    labelText: 'Mot de passe Administrateur',
                    hintText: 'Entrez le mot de passe (admin)',
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFF0277BD)),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0277BD),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('Se connecter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: _launchDemoVideo,
                  icon: const Icon(Icons.play_circle_fill, color: Colors.red),
                  label: const Text('Voir la Démo OxyONE'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    side: const BorderSide(color: Color(0xFF0277BD)),
                    foregroundColor: const Color(0xFF0277BD),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ColdDashboardScreen extends StatelessWidget {
  const ColdDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OxyONE - Tableau de Bord [PREMIUM]',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0277BD),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Déconnexion',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Connexion réussie !',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0277BD)),
              ),
              const SizedBox(height: 10),
              const Text(
                'Bienvenue dans l\'interface de gestion de la chaîne du froid OxyONE.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () async {
                  final Uri youtubeUri = Uri.parse('https://www.youtube.com/watch?v=LH3mdwrCKKM');
                  if (await canLaunchUrl(youtubeUri)) {
                    await launchUrl(youtubeUri, mode: LaunchMode.externalApplication);
                  }
                },
                icon: const Icon(Icons.play_circle_fill, color: Colors.red, size: 28),
                label: const Text('Voir la Démo OxyONE'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0277BD),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
