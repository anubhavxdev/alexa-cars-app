import 'package:flutter/material.dart';
import 'package:alexa_cars_app/constants.dart';
import 'package:alexa_cars_app/providers/car_provider.dart';
import 'package:alexa_cars_app/models/car_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final carId = args?['carId'] as int?;
    
    if (carId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Car Details'),
        ),
        body: const Center(
          child: Text('Car not found'),
        ),
      );
    }
    
    return Consumer<CarProvider>(
      builder: (context, carProvider, child) {
        final car = carProvider.getCarById(carId);
        
        if (car == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Car Details'),
            ),
            body: const Center(
              child: Text('Car not found'),
            ),
          );
        }
        
        return Scaffold(
          appBar: AppBar(
            title: Text(car.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // Share functionality would go here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Share functionality coming soon!'),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Car Image
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  image: DecorationImage(
                    image: AssetImage(car.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Car Info
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.radiusLarge),
                      topRight: Radius.circular(AppDimensions.radiusLarge),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Car Title and Price
                      Padding(
                        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    car.name,
                                    style: AppTextStyles.heading2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                                        ),
                                        child: Text(
                                          car.category,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      RatingBarIndicator(
                                        rating: car.rating,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 16.0,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '(${car.reviewCount})',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹${car.pricePerDay.toInt()}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Text(
                                  '/day',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Tabs
                      TabBar(
                        controller: _tabController,
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.textLight,
                        indicatorColor: AppColors.primary,
                        tabs: const [
                          Tab(text: 'Overview'),
                          Tab(text: 'Specifications'),
                          Tab(text: 'Reviews'),
                        ],
                      ),
                      
                      // Tab Content
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Overview Tab
                            SingleChildScrollView(
                              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    style: AppTextStyles.heading3,
                                  ),
                                  const SizedBox(height: AppDimensions.paddingMedium),
                                  Text(
                                    car.description,
                                    style: AppTextStyles.body,
                                  ),
                                  const SizedBox(height: AppDimensions.paddingLarge),
                                  Text(
                                    'Features',
                                    style: AppTextStyles.heading3,
                                  ),
                                  const SizedBox(height: AppDimensions.paddingMedium),
                                  Wrap(
                                    spacing: AppDimensions.paddingMedium,
                                    runSpacing: AppDimensions.paddingMedium,
                                    children: [
                                      _buildFeatureChip('Air Conditioning'),
                                      _buildFeatureChip('Bluetooth'),
                                      _buildFeatureChip('Rear Camera'),
                                      _buildFeatureChip('Power Windows'),
                                      _buildFeatureChip('Central Locking'),
                                      if (car.specifications['Features'] != null)
                                        ...car.specifications['Features']
                                            .toString()
                                            .split(', ')
                                            .map((feature) => _buildFeatureChip(feature)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Specifications Tab
                            SingleChildScrollView(
                              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                              child: Column(
                                children: [
                                  ...car.specifications.entries.map((entry) {
                                    return _buildSpecificationItem(entry.key, entry.value.toString());
                                  }),
                                ],
                              ),
                            ),
                            
                            // Reviews Tab (placeholder)
                            const Center(
                              child: Text('Reviews coming soon'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _launchPhone(AppStrings.phoneNumber),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone),
                        const SizedBox(width: 8),
                        Text(AppStrings.call),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _launchWhatsApp(car),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.message),
                        const SizedBox(width: 8),
                        Text(AppStrings.bookNow),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureChip(String feature) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        feature,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  Widget _buildSpecificationItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.textLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.textDark,
                fontWeight: FontWeight.w600,
              ),
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

  Future<void> _launchWhatsApp(Car car) async {
    // Create booking message for WhatsApp
    final message = '''
*I'm interested in renting the ${car.name}*
Price: ₹${car.pricePerDay.toInt()} per day
Category: ${car.category}
Please provide more details.
    ''';
    
    // Launch WhatsApp with pre-filled message
    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUrl = '${AppStrings.whatsappLink}&text=$encodedMessage';
    
    final Uri uri = Uri.parse(whatsappUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Show error if WhatsApp can't be launched
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch WhatsApp. Please try again later.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
