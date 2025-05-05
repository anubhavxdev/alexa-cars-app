import 'package:flutter/material.dart';
import 'package:alexa_cars_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.8),
                image: const DecorationImage(
                  image: AssetImage('assets/images/about.webp'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Overlay
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About AlexaCars',
                          style: AppTextStyles.heading1.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // About Content
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Story',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  Text(
                    'AlexaCars is Jaipur\'s premier car rental service, offering a wide range of vehicles for all your travel needs. Founded with a vision to provide hassle-free car rentals, we have grown to become one of the most trusted names in the industry.',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  Text(
                    'Our mission is to make car rentals accessible, affordable, and enjoyable for everyone. We take pride in our well-maintained fleet of vehicles and our commitment to customer satisfaction.',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),
                  
                  Text(
                    'Why Choose Us',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  _buildFeatureItem(
                    icon: Icons.check_circle,
                    title: 'Wide Range of Cars',
                    description: 'From economy to luxury, we have a car for every need and budget.',
                  ),
                  _buildFeatureItem(
                    icon: Icons.check_circle,
                    title: 'Competitive Pricing',
                    description: 'Enjoy the best rates in Jaipur with no hidden charges.',
                  ),
                  _buildFeatureItem(
                    icon: Icons.check_circle,
                    title: 'Well-Maintained Fleet',
                    description: 'All our cars are regularly serviced and kept in excellent condition.',
                  ),
                  _buildFeatureItem(
                    icon: Icons.check_circle,
                    title: '24/7 Customer Support',
                    description: 'Our team is always available to assist you with any queries or issues.',
                  ),
                  _buildFeatureItem(
                    icon: Icons.check_circle,
                    title: 'Flexible Rental Options',
                    description: 'Choose from hourly, daily, weekly, or monthly rental plans.',
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),
                  
                  Text(
                    'Our Location',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: const Center(
                      child: Text('Map will be displayed here'),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  Text(
                    'AlexaCars Headquarters',
                    style: AppTextStyles.heading3.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '123 Car Street, Jaipur, Rajasthan, India - 302001',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),
                  
                  Text(
                    'Contact Us',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  _buildContactItem(
                    icon: Icons.phone,
                    title: 'Phone',
                    value: AppStrings.phoneNumber,
                    onTap: () => _launchPhone(AppStrings.phoneNumber),
                  ),
                  _buildContactItem(
                    icon: Icons.chat,
                    title: 'WhatsApp',
                    value: 'Chat with us',
                    onTap: () => _launchWhatsApp(),
                  ),
                  _buildContactItem(
                    icon: Icons.email,
                    title: 'Email',
                    value: 'info@alexacars.com',
                    onTap: () => _launchEmail('info@alexacars.com'),
                  ),
                  _buildContactItem(
                    icon: Icons.language,
                    title: 'Website',
                    value: 'www.alexacars.com',
                    onTap: () => _launchWebsite('https://www.alexacars.com'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodyLight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textLight,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textLight,
            ),
          ],
        ),
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

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Inquiry from AlexaCars App',
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchWebsite(String url) async {
    final Uri websiteUri = Uri.parse(url);
    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri, mode: LaunchMode.externalApplication);
    }
  }
}
