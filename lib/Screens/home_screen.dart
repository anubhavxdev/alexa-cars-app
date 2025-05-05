import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alexa_cars_app/constants.dart';
import 'package:alexa_cars_app/widgets/car_card.dart';
import 'package:alexa_cars_app/widgets/booking_form.dart';
import 'package:alexa_cars_app/widgets/feature_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Using a single banner image instead of carousel
  final String _bannerImage = AppAssets.homeBanner;

  // Sample featured cars data
  final List<Map<String, dynamic>> _featuredCars = [
    {
      'id': 1,
      'name': 'Hyundai Creta',
      'category': 'SUV',
      'price_per_day': 4200,
      'image_url': AppAssets.carHyundaiCreta,
      'description': '2024 Model with sunroof',
      'is_available': true,
      'rating': 4.8,
    },
    {
      'id': 2,
      'name': 'Hyundai i10 Nios CNG',
      'category': 'Sedan',
      'price_per_day': 2200,
      'image_url': AppAssets.carHyundaiI10,
      'description': 'Hyundai',
      'is_available': true,
      'rating': 4.5,
    },
    {
      'id': 3,
      'name': 'Maruti Suzuki Swift',
      'category': 'Hatchback',
      'price_per_day': 2500,
      'image_url': AppAssets.carSwift,
      'description': 'Hatchback',
      'is_available': true,
      'rating': 4.7,
    },
    {
      'id': 4,
      'name': 'Maruti Suzuki Breeza VXI',
      'category': 'Hatchback',
      'price_per_day': 2600,
      'image_url': AppAssets.carBrezza,
      'description': 'Hatchback',
      'is_available': true,
      'rating': 4.6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Alexa',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  fontFamily: 'Poppins',
                ),
              ),
              TextSpan(
                text: 'Cars',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: AppColors.primary),
            onPressed: () => _launchPhone(AppStrings.phoneNumber),
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.whatsapp, color: AppColors.primary),
            onPressed: () => _launchWhatsApp(),
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: AppColors.textDark),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Carousel
            _buildBannerCarousel(),
            
            // Booking Form
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingMedium),
                  child: BookingForm(),
                ),
              ),
            ),
            
            // Featured Cars Section
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.1),
                          Colors.transparent,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text(
                              'Featured Cars',
                              style: AppTextStyles.heading2,
                            ),
                          ],
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/cars');
                          },
                          icon: Icon(Icons.arrow_forward, color: AppColors.primary, size: 18),
                          label: Text(
                            'View All',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _featuredCars.length,
                      itemBuilder: (context, index) {
                        final car = _featuredCars[index];
                        return CarCard(
                          id: car['id'],
                          name: car['name'],
                          category: car['category'],
                          pricePerDay: car['price_per_day'].toDouble(),
                          imageUrl: car['image_url'],
                          description: car['description'],
                          isAvailable: car['is_available'],
                          rating: car['rating'].toDouble(),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/car-detail',
                              arguments: {'carId': car['id']},
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Features Section
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Better Way to Rent Your Perfect Cars',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FeatureCard(
                          icon: Icons.location_on,
                          title: 'Choose Your Pickup Location',
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          iconColor: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingMedium),
                      Expanded(
                        child: FeatureCard(
                          icon: Icons.handshake,
                          title: 'Select the Best Deal',
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          iconColor: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingMedium),
                      Expanded(
                        child: FeatureCard(
                          icon: Icons.car_rental,
                          title: 'Reserve Your Rental Car',
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          iconColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _launchWhatsApp();
                      },
                      child: Text(AppStrings.reserve),
                    ),
                  ),
                ],
              ),
            ),
            
            // About Section
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About AlexaCars',
                        style: AppTextStyles.heading2,
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      Text(
                        AppStrings.appDescription,
                        style: AppTextStyles.body,
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/about');
                          },
                          child: const Text('Learn More'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: AppDimensions.paddingLarge),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on home
              break;
            case 1:
              Navigator.pushNamed(context, '/cars');
              break;
            case 2:
              Navigator.pushNamed(context, '/booking');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: AppStrings.cars,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: AppStrings.bookings,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        image: const DecorationImage(
          image: AssetImage(AppAssets.mainBanner),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Overlay for better text readability
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.appTagline,
                  style: AppTextStyles.heading1.copyWith(
                    color: AppColors.white,
                    fontSize: 24,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                Text(
                  AppStrings.appDescription,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
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
