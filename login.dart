import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Login form controllers
  final _loginUsernameController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  
  // Register form controllers
  final _registerFullNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerUsernameController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  
  // Form keys
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _loginUsernameController.dispose();
    _loginPasswordController.dispose();
    _registerFullNameController.dispose();
    _registerEmailController.dispose();
    _registerUsernameController.dispose();
    _registerPasswordController.dispose();
    super.dispose();
  }
  
  // Email validation regex
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
  
  // Handle login
  void _handleLogin() {
    if (_loginFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged in as admin'),
          backgroundColor: Color(0xFF1E88E5),
        ),
      );
    }
  }
  
  // Handle register
  void _handleRegister() {
    if (_registerFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully'),
          backgroundColor: Color(0xFF1E88E5),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: 900),
        child: Row(
          children: [
            // Left column - Login/Register forms
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey[50],
                padding: const EdgeInsets.all(60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company name and tagline
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Galit Digital',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Job Order Management System',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Tab switcher
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Login'),
                          Tab(text: 'Register'),
                        ],
                        labelColor: Colors.grey[800],
                        unselectedLabelColor: Colors.grey[600],
                        indicatorColor: const Color(0xFF1E88E5),
                        indicatorWeight: 2,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Form content
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Login form
                          _buildLoginForm(),
                          // Register form
                          _buildRegisterForm(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Right column - Marketing panel
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E88E5),
                      Color(0xFF1565C0),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Marketing headline
                    Text(
                      'Galit Digital Printing Services',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Streamline your printing business with our comprehensive job order management system. Track orders, manage inventory, and process payments efficiently.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                    ),
                    
                    const SizedBox(height: 50),
                    
                    // Feature tiles
                    _buildFeatureTile(
                      icon: Icons.assignment_turned_in,
                      title: 'Efficient Order Management',
                      subtitle: 'Track and manage all your printing orders in one place',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureTile(
                      icon: Icons.inventory_2,
                      title: 'Smart Inventory Control',
                      subtitle: 'Keep track of your materials and get low stock alerts',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureTile(
                      icon: Icons.admin_panel_settings,
                      title: 'Role-Based Access',
                      subtitle: 'Secure access for admin and clerk with appropriate permissions',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Build login form
  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome heading
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to your account to continue',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Username field
            Text(
              'Username',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _loginUsernameController,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username is required';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Password field
            Text(
              'Password',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _loginPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 30),
            
            // Sign In button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Register link
            Center(
              child: GestureDetector(
                onTap: () {
                  _tabController.animateTo(1);
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF1E88E5),
                          fontWeight: FontWeight.w500,
                        ),
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
  
  // Build register form
  Widget _buildRegisterForm() {
    return SingleChildScrollView(
      child: Form(
        key: _registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Create account heading
            Text(
              'Create an account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Register to start using the system',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Full Name field
            Text(
              'Full Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _registerFullNameController,
              decoration: InputDecoration(
                hintText: 'John Doe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Full name is required';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Email field
            Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _registerEmailController,
              decoration: InputDecoration(
                hintText: 'john@example.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!_isValidEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Username field
            Text(
              'Username',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _registerUsernameController,
              decoration: InputDecoration(
                hintText: 'johnDoe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username is required';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Password field
            Text(
              'Password',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _registerPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '••••••••',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 30),
            
            // Create Account button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Build feature tile
  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}