import 'package:flutter/material.dart';
import 'package:smart_tutor/services/auth_service.dart';
import 'package:smart_tutor/screens/tutor/my_profile_screen.dart';

class TutorDashboardScreen extends StatelessWidget {
  const TutorDashboardScreen({super.key});

  void _handleCardTap(BuildContext context, String title) {
    if (title == 'My Profile') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MyProfileScreen()),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title coming soon')),
    );
  }

  Widget buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconBg,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _handleCardTap(context, title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: iconBg,
              child: Icon(icon, color: const Color(0xFF4F46E5)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await AuthService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8FC),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tutor Dashboard',
          style: TextStyle(
            color: Color(0xFF111827),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Color(0xFF111827)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4F46E5),
                    Color(0xFF7C3AED),
                    Color(0xFF2563EB),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x334F46E5),
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.school_rounded,
                      size: 28,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Welcome Tutor 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Manage your profile and future tutor features from here.',
                    style: TextStyle(
                      color: Color(0xFFE5E7EB),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Everything important in one place.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 16),
            buildActionCard(
              context: context,
              icon: Icons.person_outline_rounded,
              title: 'My Profile',
              subtitle: 'View and update your tutor details',
              iconBg: const Color(0xFFEDE9FE),
            ),
            buildActionCard(
              context: context,
              icon: Icons.verified_outlined,
              title: 'Verification Payment',
              subtitle: 'Submit verification payment',
              iconBg: const Color(0xFFDCFCE7),
            ),
            buildActionCard(
              context: context,
              icon: Icons.school_outlined,
              title: 'Tuition Feed',
              subtitle: 'Browse tuition opportunities',
              iconBg: const Color(0xFFDBEAFE),
            ),
            buildActionCard(
              context: context,
              icon: Icons.assignment_outlined,
              title: 'My Applications',
              subtitle: 'Track your applications',
              iconBg: const Color(0xFFFCE7F3),
            ),
            buildActionCard(
              context: context,
              icon: Icons.visibility_outlined,
              title: 'Public Profile',
              subtitle: 'Preview your public tutor profile',
              iconBg: const Color(0xFFFFF7ED),
            ),
          ],
        ),
      ),
    );
  }
}