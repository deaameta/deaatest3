import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/core/data/entities/user.dart';

class BuildAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool? isNavigator;

  const BuildAppBar({Key? key, required this.scaffoldKey, this.isNavigator = false}) : super(key: key);

  @override
  _BuildAppBarState createState() => _BuildAppBarState();

  @override
  Size get preferredSize {
    return Size(SizeConfig.screenWidth, SizeConfig.h(60));
  }
}

class _BuildAppBarState extends State<BuildAppBar> {
  @override
  initState() {
    getUserData();
    super.initState();
  }

  User? user;

  getUserData() async {
    // user = sl<AuthSharedPrefs>().getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      actions: <Widget>[Container()],
      elevation: 0.0,
      title: Row(
        children: [
          // Drawer
          if (widget.isNavigator!) ...{
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_back_outlined),
            ),
          } else ...{
            InkWell(
              onTap: () {
                widget.scaffoldKey.currentState!.openDrawer();
              },
              child: SvgPicture.asset(
                "assets/svg_images/menu.svg",
                height: SizeConfig.w(30),
                width: SizeConfig.w(30),
                fit: BoxFit.cover,
                color: AppColors.white,
              ),
            ),
          },

          const Spacer(),

          // Profile
          // SvgPicture.asset(
          //   "assets/svg_images/user_circle.svg",
          //   height: SizeConfig.w(30),
          //   width: SizeConfig.w(30),
          //   fit: BoxFit.cover,
          //   color: AppColors.secondaryColor,
          // ),
        ],
      ),
    );
  }
}
