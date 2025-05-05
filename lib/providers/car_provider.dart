import 'package:flutter/material.dart';
import 'package:alexa_cars_app/models/car_model.dart';
import 'package:alexa_cars_app/constants.dart';

class CarProvider extends ChangeNotifier {
  List<Car> _cars = [];
  bool _isLoading = false;
  String? _error;

  List<Car> get cars => _cars;
  bool get isLoading => _isLoading;
  String? get error => _error;

  CarProvider() {
    fetchCars();
  }

  Future<void> fetchCars() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock car data - in a real app, this would come from an API
      _cars = [
        Car(
          id: 1,
          name: 'Hyundai Creta',
          category: AppStrings.suv,
          pricePerDay: 4200,
          imageUrl: AppAssets.carHyundaiCreta,
          description: '2024 Model with sunroof',
          specifications: {
            'Year': '2024',
            'Fuel Type': 'Petrol',
            'Transmission': 'Automatic',
            'Seats': '5',
            'Mileage': '18 km/l',
            'Engine': '1.5L',
            'Features': 'Sunroof, Touchscreen, Rear Camera',
          },
          isAvailable: true,
          rating: 4.8,
          reviewCount: 24,
        ),
        Car(
          id: 2,
          name: 'Hyundai i10 Nios CNG',
          category: AppStrings.sedan,
          pricePerDay: 2200,
          imageUrl: AppAssets.carHyundaiI10,
          description: 'Hyundai',
          specifications: {
            'Year': '2023',
            'Fuel Type': 'CNG/Petrol',
            'Transmission': 'Manual',
            'Seats': '5',
            'Mileage': '26 km/kg (CNG)',
            'Engine': '1.2L',
            'Features': 'Touchscreen, Bluetooth, AC',
          },
          isAvailable: true,
          rating: 4.5,
          reviewCount: 18,
        ),
        Car(
          id: 3,
          name: 'Maruti Suzuki Swift',
          category: AppStrings.hatchback,
          pricePerDay: 2500,
          imageUrl: AppAssets.carSwift,
          description: 'Hatchback',
          specifications: {
            'Year': '2023',
            'Fuel Type': 'Petrol',
            'Transmission': 'Manual',
            'Seats': '5',
            'Mileage': '22 km/l',
            'Engine': '1.2L',
            'Features': 'Touchscreen, Rear Camera, Alloy Wheels',
          },
          isAvailable: true,
          rating: 4.7,
          reviewCount: 32,
        ),
        Car(
          id: 4,
          name: 'Maruti Suzuki Breeza VXI',
          category: AppStrings.hatchback,
          pricePerDay: 2600,
          imageUrl: AppAssets.carBrezza,
          description: 'Hatchback',
          specifications: {
            'Year': '2023',
            'Fuel Type': 'Petrol',
            'Transmission': 'Manual',
            'Seats': '5',
            'Mileage': '20 km/l',
            'Engine': '1.5L',
            'Features': 'Touchscreen, Rear Camera, Push Button Start',
          },
          isAvailable: true,
          rating: 4.6,
          reviewCount: 21,
        ),
        Car(
          id: 5,
          name: 'Baleno 2024 (New)',
          category: AppStrings.hatchback,
          pricePerDay: 2800,
          imageUrl: AppAssets.carBaleno,
          description: 'Premium Hatchback',
          specifications: {
            'Year': '2024',
            'Fuel Type': 'Petrol',
            'Transmission': 'Automatic',
            'Seats': '5',
            'Mileage': '22 km/l',
            'Engine': '1.2L',
            'Features': 'Touchscreen, 360° Camera, Cruise Control',
          },
          isAvailable: true,
          rating: 4.5,
          reviewCount: 15,
        ),
        Car(
          id: 6,
          name: 'Hyundai – i20 (NEW)',
          category: AppStrings.hatchback,
          pricePerDay: 2800,
          imageUrl: AppAssets.carI20,
          description: 'Premium Hatchback',
          specifications: {
            'Year': '2024',
            'Fuel Type': 'Petrol',
            'Transmission': 'Automatic',
            'Seats': '5',
            'Mileage': '20 km/l',
            'Engine': '1.2L',
            'Features': 'Sunroof, Touchscreen, Wireless Charging',
          },
          isAvailable: true,
          rating: 4.4,
          reviewCount: 12,
        ),
        Car(
          id: 7,
          name: 'Honda Amaze',
          category: AppStrings.sedan,
          pricePerDay: 2600,
          imageUrl: AppAssets.carHondaAmaze,
          description: 'Compact Sedan',
          specifications: {
            'Year': '2023',
            'Fuel Type': 'Petrol',
            'Transmission': 'CVT',
            'Seats': '5',
            'Mileage': '18 km/l',
            'Engine': '1.2L',
            'Features': 'Touchscreen, Rear Camera, Cruise Control',
          },
          isAvailable: true,
          rating: 4.3,
          reviewCount: 19,
        ),
        Car(
          id: 8,
          name: 'Toyota Glanza',
          category: AppStrings.sedan,
          pricePerDay: 2500,
          imageUrl: AppAssets.carGlanza,
          description: 'Premium Hatchback',
          specifications: {
            'Year': '2023',
            'Fuel Type': 'Petrol',
            'Transmission': 'Automatic',
            'Seats': '5',
            'Mileage': '22 km/l',
            'Engine': '1.2L',
            'Features': 'Touchscreen, Rear Camera, Push Button Start',
          },
          isAvailable: true,
          rating: 4.5,
          reviewCount: 16,
        ),
      ];
    } catch (e) {
      _error = 'Failed to load cars. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Car? getCarById(int id) {
    try {
      return _cars.firstWhere((car) => car.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Car> getCarsByCategory(String category) {
    return _cars.where((car) => car.category.toLowerCase() == category.toLowerCase()).toList();
  }

  List<Car> searchCars(String query) {
    return _cars.where((car) => 
      car.name.toLowerCase().contains(query.toLowerCase()) ||
      car.category.toLowerCase().contains(query.toLowerCase()) ||
      car.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
