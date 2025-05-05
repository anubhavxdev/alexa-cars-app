import 'package:flutter/material.dart';
import 'package:alexa_cars_app/models/car_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Booking {
  final int id;
  final int carId;
  final String carName;
  final String carImageUrl;
  final double pricePerDay;
  final String pickupLocation;
  final String dropoffLocation;
  final DateTime pickupDate;
  final DateTime dropoffDate;
  final String pickupTime;
  final String dropoffTime;
  final String status;
  final DateTime bookingDate;

  Booking({
    required this.id,
    required this.carId,
    required this.carName,
    required this.carImageUrl,
    required this.pricePerDay,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupDate,
    required this.dropoffDate,
    required this.pickupTime,
    required this.dropoffTime,
    required this.status,
    required this.bookingDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      carId: json['car_id'],
      carName: json['car_name'],
      carImageUrl: json['car_image_url'],
      pricePerDay: json['price_per_day'].toDouble(),
      pickupLocation: json['pickup_location'],
      dropoffLocation: json['dropoff_location'],
      pickupDate: DateTime.parse(json['pickup_date']),
      dropoffDate: DateTime.parse(json['dropoff_date']),
      pickupTime: json['pickup_time'],
      dropoffTime: json['dropoff_time'],
      status: json['status'],
      bookingDate: DateTime.parse(json['booking_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car_id': carId,
      'car_name': carName,
      'car_image_url': carImageUrl,
      'price_per_day': pricePerDay,
      'pickup_location': pickupLocation,
      'dropoff_location': dropoffLocation,
      'pickup_date': pickupDate.toIso8601String(),
      'dropoff_date': dropoffDate.toIso8601String(),
      'pickup_time': pickupTime,
      'dropoff_time': dropoffTime,
      'status': status,
      'booking_date': bookingDate.toIso8601String(),
    };
  }
}

class BookingProvider extends ChangeNotifier {
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  BookingProvider() {
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final bookingsJson = prefs.getString('bookings');
      
      if (bookingsJson != null) {
        final List<dynamic> bookingsList = json.decode(bookingsJson);
        _bookings = bookingsList.map((item) => Booking.fromJson(item)).toList();
      } else {
        // Add mock bookings for demo purposes
        _addMockBookings();
      }
    } catch (e) {
      _error = 'Failed to load bookings';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _addMockBookings() {
    // Mock bookings for demonstration
    _bookings = [
      Booking(
        id: 1,
        carId: 1,
        carName: 'Hyundai Creta',
        carImageUrl: 'assets/images/hyundai_creta.png',
        pricePerDay: 4200,
        pickupLocation: 'Jaipur Airport',
        dropoffLocation: 'Jaipur City Center',
        pickupDate: DateTime.now().add(const Duration(days: 2)),
        dropoffDate: DateTime.now().add(const Duration(days: 5)),
        pickupTime: '10:00 AM',
        dropoffTime: '6:00 PM',
        status: 'Confirmed',
        bookingDate: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Booking(
        id: 2,
        carId: 3,
        carName: 'Maruti Suzuki Swift',
        carImageUrl: 'assets/images/swift.jpg',
        pricePerDay: 2500,
        pickupLocation: 'Jaipur Railway Station',
        dropoffLocation: 'Jaipur Railway Station',
        pickupDate: DateTime.now().add(const Duration(days: 10)),
        dropoffDate: DateTime.now().add(const Duration(days: 12)),
        pickupTime: '9:00 AM',
        dropoffTime: '8:00 PM',
        status: 'Pending',
        bookingDate: DateTime.now(),
      ),
    ];
    
    _saveBookings();
  }

  Future<void> _saveBookings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookingsJson = json.encode(_bookings.map((booking) => booking.toJson()).toList());
      await prefs.setString('bookings', bookingsJson);
    } catch (e) {
      _error = 'Failed to save bookings';
    }
  }

  Future<bool> addBooking({
    required Car car,
    required String pickupLocation,
    required String dropoffLocation,
    required DateTime pickupDate,
    required DateTime dropoffDate,
    required String pickupTime,
    required String dropoffTime,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Generate a new booking ID
      final newId = _bookings.isEmpty ? 1 : _bookings.map((b) => b.id).reduce((a, b) => a > b ? a : b) + 1;
      
      // Create new booking
      final newBooking = Booking(
        id: newId,
        carId: car.id,
        carName: car.name,
        carImageUrl: car.imageUrl,
        pricePerDay: car.pricePerDay,
        pickupLocation: pickupLocation,
        dropoffLocation: dropoffLocation,
        pickupDate: pickupDate,
        dropoffDate: dropoffDate,
        pickupTime: pickupTime,
        dropoffTime: dropoffTime,
        status: 'Pending',
        bookingDate: DateTime.now(),
      );
      
      // Add to bookings list
      _bookings.add(newBooking);
      
      // Save to SharedPreferences
      await _saveBookings();
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to create booking. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelBooking(int bookingId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Find the booking
      final index = _bookings.indexWhere((booking) => booking.id == bookingId);
      
      if (index != -1) {
        // Create a new booking with updated status
        final updatedBooking = Booking(
          id: _bookings[index].id,
          carId: _bookings[index].carId,
          carName: _bookings[index].carName,
          carImageUrl: _bookings[index].carImageUrl,
          pricePerDay: _bookings[index].pricePerDay,
          pickupLocation: _bookings[index].pickupLocation,
          dropoffLocation: _bookings[index].dropoffLocation,
          pickupDate: _bookings[index].pickupDate,
          dropoffDate: _bookings[index].dropoffDate,
          pickupTime: _bookings[index].pickupTime,
          dropoffTime: _bookings[index].dropoffTime,
          status: 'Cancelled',
          bookingDate: _bookings[index].bookingDate,
        );
        
        // Update the booking
        _bookings[index] = updatedBooking;
        
        // Save to SharedPreferences
        await _saveBookings();
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Booking not found';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Failed to cancel booking. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  List<Booking> getUpcomingBookings() {
    final now = DateTime.now();
    return _bookings.where((booking) => 
      booking.pickupDate.isAfter(now) && 
      booking.status != 'Cancelled'
    ).toList();
  }

  List<Booking> getPastBookings() {
    final now = DateTime.now();
    return _bookings.where((booking) => 
      booking.dropoffDate.isBefore(now) || 
      booking.status == 'Cancelled'
    ).toList();
  }

  Booking? getBookingById(int id) {
    try {
      return _bookings.firstWhere((booking) => booking.id == id);
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
