import 'package:flutter/material.dart';
import 'package:alexa_cars_app/constants.dart';
import 'package:alexa_cars_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (!authProvider.isAuthenticated) {
            return _buildNotLoggedIn(context);
          }
          
          final user = authProvider.user!;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              children: [
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      // Profile Image
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: Text(
                          user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      
                      // User Name
                      Text(
                        user.name,
                        style: AppTextStyles.heading2,
                      ),
                      const SizedBox(height: 4),
                      
                      // User Email
                      Text(
                        user.email,
                        style: AppTextStyles.bodyLight,
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      
                      // Edit Profile Button
                      OutlinedButton.icon(
                        onPressed: () {
                          // Edit profile functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Edit profile functionality coming soon!'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingMedium,
                            vertical: 8,
                          ),
                          minimumSize: Size.zero,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppDimensions.paddingLarge),
                const Divider(),
                const SizedBox(height: AppDimensions.paddingLarge),
                
                // Profile Menu
                _buildMenuItem(
                  icon: Icons.car_rental,
                  title: 'My Bookings',
                  subtitle: 'View your car rental bookings',
                  onTap: () {
                    Navigator.pushNamed(context, '/booking');
                  },
                ),
                _buildMenuItem(
                  icon: Icons.favorite,
                  title: 'Favorite Cars',
                  subtitle: 'View your favorite cars',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Favorites functionality coming soon!'),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: 'Manage your notifications',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notifications functionality coming soon!'),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.payment,
                  title: 'Payment Methods',
                  subtitle: 'Manage your payment methods',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment methods functionality coming soon!'),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: AppDimensions.paddingMedium),
                const Divider(),
                const SizedBox(height: AppDimensions.paddingMedium),
                
                // Support and Help
                _buildMenuItem(
                  icon: Icons.help,
                  title: 'Help & Support',
                  subtitle: 'Get help and contact support',
                  onTap: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                ),
                _buildMenuItem(
                  icon: Icons.info,
                  title: 'About Us',
                  subtitle: 'Learn more about AlexaCars',
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                _buildMenuItem(
                  icon: Icons.phone,
                  title: 'Call Us',
                  subtitle: AppStrings.phoneNumber,
                  onTap: () => _launchPhone(AppStrings.phoneNumber),
                ),
                _buildMenuItem(
                  icon: Icons.message,
                  title: 'WhatsApp',
                  subtitle: 'Chat with us on WhatsApp',
                  onTap: () => _launchWhatsApp(),
                ),
                
                const SizedBox(height: AppDimensions.paddingMedium),
                const Divider(),
                const SizedBox(height: AppDimensions.paddingMedium),
                
                // Logout
                _buildMenuItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  subtitle: 'Sign out from your account',
                  iconColor: AppColors.error,
                  onTap: () => _showLogoutDialog(context, authProvider),
                ),
                
                const SizedBox(height: AppDimensions.paddingLarge),
                
                // App Version
                Text(
                  'App Version: 1.0.0',
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotLoggedIn(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 80,
              color: AppColors.primary.withOpacity(0.5),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            Text(
              'Login to Your Account',
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Text(
              'Please login to access your profile and manage your bookings',
              style: AppTextStyles.bodyLight,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.primary).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor ?? AppColors.primary,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.caption,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await authProvider.logout();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse(AppStrings.whatsappLink);
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }
}
