import 'package:appfi/Fragments/favorites_fragment_screen.dart';
import 'package:appfi/Fragments/home_fragment_Screen.dart';
import 'package:appfi/Fragments/order_fragment.dart';
import 'package:appfi/Fragments/profile_fragment_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DashboardOfFragment extends StatefulWidget {
  static const String screenRoute = 'dashboard_screen';

  const DashboardOfFragment({super.key});

  @override
  State<DashboardOfFragment> createState() => _DashboardOfFragmentState();
}

class _DashboardOfFragmentState extends State<DashboardOfFragment> {
  final List<Widget> _fragmentScreen = [
    HomeFragmentScreen(),
    FavoritesFragmentScreen(),
    OrderFragmentScreen(),
    const ProfileFragmentScreen(),
  ];

  final List _navigationButtonsProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.favorite,
      "non_active_icon": Icons.favorite_border,
      "label": "Favorites",
    },
    {
      "active_icon": FontAwesomeIcons.boxOpen,
      "non_active_icon": FontAwesomeIcons.box,
      "label": "Orders",
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outline,
      "label": "Profile",
    },
  ];

  final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _fragmentScreen[_indexNumber.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexNumber.value,
        onTap: (value) {
          setState(() {
            _indexNumber.value = value;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: List.generate(
          4,
          (index) {
            var navBtnProperty = _navigationButtonsProperties[index];
            return BottomNavigationBarItem(
              backgroundColor: Colors.blueGrey,
              icon: Icon(navBtnProperty["non_active_icon"]),
              activeIcon: Icon(navBtnProperty["active_icon"]),
              label: navBtnProperty["label"],
            );
          },
        ),
      ),
    );
  }
}
