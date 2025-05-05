import 'package:flutter/material.dart';

// App Colors
class AppColors {
  static const Color primary = Color(0xFF01d28e);
  static const Color primaryDark = Color(0xFF00b377);
  static const Color accent = Color(0xFF343a40);
  static const Color background = Color(0xFFF8F9FA);
  static const Color textDark = Color(0xFF343a40);
  static const Color textLight = Color(0xFF6c757d);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color error = Color(0xFFdc3545);
  static const Color success = Color(0xFF28a745);
  static const Color warning = Color(0xFFffc107);
  static const Color info = Color(0xFF17a2b8);
}

// App Text Styles
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    color: AppColors.textDark,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    color: AppColors.textDark,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: AppColors.textDark,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16.0,
    fontFamily: 'Poppins',
    color: AppColors.textDark,
  );

  static const TextStyle bodyLight = TextStyle(
    fontSize: 16.0,
    fontFamily: 'Poppins',
    color: AppColors.textLight,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: AppColors.white,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14.0,
    fontFamily: 'Poppins',
    color: AppColors.textLight,
  );
}

// App Dimensions
class AppDimensions {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 32.0;
  
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 16.0;
  static const double radiusExtraLarge = 24.0;
}

// App Assets
class AppAssets {
  // Images
  static const String logo = 'assets/images/logo.png';
  static const String homeBanner = 'assets/images/home.avif';
  static const String carsBanner = 'assets/images/ccarshome.jpg';
  static const String aboutBanner = 'assets/images/about.webp';
  static const String contactBanner = 'assets/images/contact.webp';
  static const String mainBanner = 'assets/images/mainimg.avif';
  
  // Car Images
  static const String carHyundaiCreta = 'assets/images/Hyundai-Creta-sunroof-500x270-c-1.png';
  static const String carHyundaiI10 = 'assets/images/grand-i10-500x270-c-1.webp';
  static const String carSwift = 'assets/images/MarutiSuzukiswift.png';
  static const String carThar = 'assets/images/thar--500x270-c-1.png';
  static const String carScorpio = 'assets/images/Mahindra-Scorpio-N-500x270-c-1.png';
  static const String carFortuner = 'assets/images/Toyota-Fortuner-500x270-c-1.png';
  static const String carVerna = 'assets/images/hyundai-verna-top-model-500x270-c-1.png';
  static const String carBrezza = 'assets/images/maruti-brezza-white-500x270-c-1.png';
  static const String carErtiga = 'assets/images/maruti-ertiga-vxi-500x270-c-1.png';
  static const String carBaleno = 'assets/images/Baleno2024new.png';
  static const String carDzire = 'assets/images/swiftdzire2024.png';
  static const String carGlanza = 'assets/images/toyotaglanza.png';
  static const String carI20 = 'assets/images/hyundai-i20-500x270-c-1.png';
  static const String carHondaAmaze = 'assets/images/Honda-Amaze-500x270-c-1.png';
}

// App Strings

class AppStrings {
  static const String appName = 'AlexaCars';
  static const String appTagline = 'Drive in Style, Own the Journey';
  static const String appDescription = 'Enjoy the best of Jaipur with our unbeatable prices and 24/7 support. Alexa Cars takes the hassle out of car rentals, so you can focus on the journey.';
  
  static const String phoneNumber = '+91 9660597171';
  static const String whatsappLink = 'https://wa.me/message/IEH42U5P2TSIM1';
  
  // Navigation
  static const String home = 'Home';
  static const String cars = 'Cars';
  static const String about = 'About';
  static const String contact = 'Contact';
  static const String login = 'Login';
  static const String register = 'Register';
  static const String profile = 'Profile';
  static const String bookings = 'Bookings';
  
  // Car Booking Form
  static const String makeYourTrip = 'Make your trip';
  static const String pickupLocation = 'Pick-up location';
  static const String dropoffLocation = 'Drop-off location';
  static const String pickupDate = 'Pick-up date';
  static const String dropoffDate = 'Drop-off date';
  static const String pickupTime = 'Pick-up time';
  static const String dropoffTime = 'Drop-off time';
  static const String rentCarNow = 'Rent A Car Now';
  
  // Car Categories
  static const String sedan = 'Sedan';
  static const String suv = 'SUV';
  static const String hatchback = 'Hatchback';
  
  // Buttons
  static const String bookNow = 'Book Now';
  static const String call = 'Call';
  static const String whatsapp = 'WhatsApp';
  static const String viewDetails = 'View Details';
  static const String reserve = 'Reserve Your Perfect Car';
}
