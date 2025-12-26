import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newspaper/Auth/Signup_screen.dart';
import 'package:newspaper/view/theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'favourite_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    String username = "Guest User";
    if (user != null && user.email != null) {
      username = user.email!.split('@')[0];
    }

    return Drawer(
      backgroundColor:
      themeProvider.isDark ? Colors.black87 : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: themeProvider.isDark ? Colors.black : Colors.grey,
            ),
            currentAccountPicture: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: themeProvider.isDark ? Colors.black : Colors.grey[800],
                size: 40,
              ),
            ),
            accountName: Text(
              username,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              user?.email ?? "Guest User",
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
            ),
          ),

          // Menu Items
          ListTile(
            leading: Icon(Icons.home,
                color: themeProvider.isDark ? Colors.white : Colors.black),
            title: Text("Home", style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.category,
                color: themeProvider.isDark ? Colors.white : Colors.black),
            title: Text("Favourites", style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavouritePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.newspaper,
                color: themeProvider.isDark ? Colors.white : Colors.black),
            title: Text("Login/Signup", style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => validlogin()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings,
                color: themeProvider.isDark ? Colors.white : Colors.black),
            title: Text("Settings", style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavouritePage()));
            },
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout,
                color: themeProvider.isDark ? Colors.white : Colors.black),
            title: Text("Logout",
                style: GoogleFonts.poppins(
                    color: themeProvider.isDark
                        ? Colors.white
                        : Colors.black)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged out successfully"),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
