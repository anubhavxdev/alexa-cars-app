import 'package:flutter/material.dart';
import 'package:alexa_cars_app/constants.dart';
import 'package:alexa_cars_app/providers/car_provider.dart';
import 'package:alexa_cars_app/widgets/car_card.dart';
import 'package:provider/provider.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', AppStrings.sedan, AppStrings.suv, AppStrings.hatchback];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars'),
      ),
      body: Column(
        children: [
          // Category Filter
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: AppDimensions.paddingMedium),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingMedium,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? AppColors.white : AppColors.textDark,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Car Grid
          Expanded(
            child: Consumer<CarProvider>(
              builder: (context, carProvider, child) {
                if (carProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                if (carProvider.error != null) {
                  return Center(
                    child: Text(carProvider.error!),
                  );
                }
                
                final cars = _selectedCategory == 'All'
                    ? carProvider.cars
                    : carProvider.getCarsByCategory(_selectedCategory);
                
                if (cars.isEmpty) {
                  return const Center(
                    child: Text('No cars found'),
                  );
                }
                
                return GridView.builder(
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: AppDimensions.paddingMedium,
                    mainAxisSpacing: AppDimensions.paddingMedium,
                  ),
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return CarCard(
                      id: car.id,
                      name: car.name,
                      category: car.category,
                      pricePerDay: car.pricePerDay,
                      imageUrl: car.imageUrl,
                      description: car.description,
                      isAvailable: car.isAvailable,
                      rating: car.rating,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/car-detail',
                          arguments: {'carId': car.id},
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
