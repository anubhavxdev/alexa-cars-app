import 'package:flutter/material.dart';
import 'package:alexa_cars_app/constants.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pickupLocationController = TextEditingController();
  final TextEditingController _dropoffLocationController = TextEditingController();
  final TextEditingController _pickupDateController = TextEditingController();
  final TextEditingController _dropoffDateController = TextEditingController();
  final TextEditingController _pickupTimeController = TextEditingController();
  final TextEditingController _dropoffTimeController = TextEditingController();

  DateTime? _pickupDate;
  DateTime? _dropoffDate;
  TimeOfDay? _pickupTime;
  TimeOfDay? _dropoffTime;

  @override
  void dispose() {
    _pickupLocationController.dispose();
    _dropoffLocationController.dispose();
    _pickupDateController.dispose();
    _dropoffDateController.dispose();
    _pickupTimeController.dispose();
    _dropoffTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.2),
                  AppColors.primary.withOpacity(0.05),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: Row(
              children: [
                Icon(Icons.directions_car, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  AppStrings.makeYourTrip,
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          
          // Pickup Location
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _pickupLocationController,
              decoration: InputDecoration(
                labelText: AppStrings.pickupLocation,
                prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
                hintText: 'City, Airport, Station, etc',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter pickup location';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          
          // Dropoff Location
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _dropoffLocationController,
              decoration: InputDecoration(
                labelText: AppStrings.dropoffLocation,
                prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
                hintText: 'City, Airport, Station, etc',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter dropoff location';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          
          // Date Row
          Row(
            children: [
              // Pickup Date
              Expanded(
                child: TextFormField(
                  controller: _pickupDateController,
                  readOnly: true,
                  onTap: () => _selectPickupDate(context),
                  decoration: InputDecoration(
                    labelText: AppStrings.pickupDate,
                    prefixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
                    hintText: 'Date',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              
              // Dropoff Date
              Expanded(
                child: TextFormField(
                  controller: _dropoffDateController,
                  readOnly: true,
                  onTap: () => _selectDropoffDate(context),
                  decoration: InputDecoration(
                    labelText: AppStrings.dropoffDate,
                    prefixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
                    hintText: 'Date',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          
          // Time Row
          Row(
            children: [
              // Pickup Time
              Expanded(
                child: TextFormField(
                  controller: _pickupTimeController,
                  readOnly: true,
                  onTap: () => _selectPickupTime(context),
                  decoration: InputDecoration(
                    labelText: AppStrings.pickupTime,
                    prefixIcon: Icon(Icons.access_time, color: AppColors.primary),
                    hintText: 'Time',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              
              // Dropoff Time
              Expanded(
                child: TextFormField(
                  controller: _dropoffTimeController,
                  readOnly: true,
                  onTap: () => _selectDropoffTime(context),
                  decoration: InputDecoration(
                    labelText: AppStrings.dropoffTime,
                    prefixIcon: Icon(Icons.access_time, color: AppColors.primary),
                    hintText: 'Time',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          
          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                elevation: 3,
                shadowColor: AppColors.primary.withOpacity(0.5),
              ),
              child: Text(
                AppStrings.rentCarNow,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectPickupDate(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime.now().add(const Duration(days: 365)),
      onConfirm: (date) {
        setState(() {
          _pickupDate = date;
          _pickupDateController.text = DateFormat('dd MMM yyyy').format(date);
        });
      },
      currentTime: _pickupDate ?? DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void _selectDropoffDate(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: _pickupDate ?? DateTime.now(),
      maxTime: DateTime.now().add(const Duration(days: 365)),
      onConfirm: (date) {
        setState(() {
          _dropoffDate = date;
          _dropoffDateController.text = DateFormat('dd MMM yyyy').format(date);
        });
      },
      currentTime: _dropoffDate ?? (_pickupDate?.add(const Duration(days: 1)) ?? DateTime.now().add(const Duration(days: 1))),
      locale: LocaleType.en,
    );
  }

  void _selectPickupTime(BuildContext context) {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (time) {
        setState(() {
          _pickupTime = TimeOfDay.fromDateTime(time);
          _pickupTimeController.text = DateFormat('hh:mm a').format(time);
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void _selectDropoffTime(BuildContext context) {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (time) {
        setState(() {
          _dropoffTime = TimeOfDay.fromDateTime(time);
          _dropoffTimeController.text = DateFormat('hh:mm a').format(time);
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create booking message for WhatsApp
      final message = '''
*New Car Booking Request*
Pickup Location: ${_pickupLocationController.text}
Dropoff Location: ${_dropoffLocationController.text}
Pickup Date: ${_pickupDateController.text}
Dropoff Date: ${_dropoffDateController.text}
Pickup Time: ${_pickupTimeController.text}
Dropoff Time: ${_dropoffTimeController.text}
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
            SnackBar(
              content: Text('Could not launch WhatsApp. Please try again later.'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }
}
