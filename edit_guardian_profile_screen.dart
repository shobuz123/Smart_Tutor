import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_tutor/services/auth_service.dart';
import 'package:smart_tutor/widgets/app_input_field.dart';

class EditGuardianProfileScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String student;

  const EditGuardianProfileScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.student,
  });

  @override
  State<EditGuardianProfileScreen> createState() =>
      _EditGuardianProfileScreenState();
}

class _EditGuardianProfileScreenState extends State<EditGuardianProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _studentController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(text: widget.phone);
    _studentController = TextEditingController(text: widget.student);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _studentController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    final user = AuthService.currentUser;
    if (user == null) return;

    if (_nameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _studentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('সব field পূরণ করো')),
      );
      return;
    }

    setState(() => _isLoading = true);

    await FirebaseFirestore.instance
        .collection('guardian_profiles')
        .doc(user.uid)
        .update({
      'name': _nameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'student': _studentController.text.trim(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text('Edit Guardian Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppInputField(
              label: 'Guardian Name',
              hint: 'Enter guardian name',
              icon: Icons.person_outline,
              controller: _nameController,
            ),
            AppInputField(
              label: 'Phone Number',
              hint: 'Enter phone number',
              icon: Icons.phone_outlined,
              controller: _phoneController,
            ),
            AppInputField(
              label: 'Student Name',
              hint: 'Enter student name',
              icon: Icons.school_outlined,
              controller: _studentController,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Update Profile',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}