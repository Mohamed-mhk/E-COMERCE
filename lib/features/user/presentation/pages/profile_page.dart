import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined, color: Theme.of(context).iconTheme.color),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Profile Header
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                   Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/motor_oil.png'), // Placeholder or user avatar
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Alex's Garage",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'alex@example.com',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Use Custom Container for menu items
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _ProfileMenuItem(
                    icon: Icons.list_alt_rounded,
                    title: 'My Orders',
                    onTap: () {},
                  ),
                  _Divider(),
                  _ProfileMenuItem(
                    icon: Icons.directions_car_filled_outlined,
                    title: 'My Vehicles',
                    subtitle: '2 cars added',
                    onTap: () {},
                  ),
                  _Divider(),
                  _ProfileMenuItem(
                    icon: Icons.favorite_border_rounded,
                    title: 'Wishlist',
                    onTap: () {},
                  ),
                  _Divider(),
                  _ProfileMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'Shipping Addresses',
                    onTap: () {},
                  ),
                  _Divider(),
                  _ProfileMenuItem(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                   _ProfileMenuItem(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    trailing: Switch(
                      value: true, 
                      onChanged: (val) {},
                    ),
                    onTap: () {},
                  ),
                  _Divider(),
                   _ProfileMenuItem(
                    icon: Icons.help_outline_rounded,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.red[400],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 8),
                  Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

             const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 56,
      endIndent: 20,
      color: Colors.grey.withValues(alpha: 0.1),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            )
          : null,
      trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.grey[400], size: 18),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
