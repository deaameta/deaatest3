import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/core/presentation/widgets/app_bar.dart';
import 'package:nft_deaa/src/core/presentation/widgets/app_gradient.dart';

import '../widgets/app_drawer_widget.dart';

class BackgroundPage extends StatefulWidget {
  final Widget child;
  final bool isImage;
  final bool hasDrawer ;

  const BackgroundPage({required this.child, this.isImage = true, this.hasDrawer=true, Key? key})
      : super(key: key);

  @override
  State<BackgroundPage> createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            AppColors.backgroundColor,
            AppColors.backgroundColor2
            // Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: AppGradient(
              dx: 1,
              dy: -0.5,
              colors: [
                const Color(0xFFBB8C5F).withOpacity(0.1),
                const Color(0xFFBB8C5F).withOpacity(0.1),
                const Color(0xFFBB8C5F).withOpacity(0.1),
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
              ],
              stops: const [
                0.7,
                0.7,
                0.7,
                1,
                1,
                1,
              ],
            ),
          ),
          Positioned(
            right: -SizeConfig.w(30),
            top: SizeConfig.h(169),
            child: Container(
              width: SizeConfig.h(60),
              height: SizeConfig.h(60),
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            left: -SizeConfig.w(30),
            top: SizeConfig.h(350),
            child: Container(
              width: SizeConfig.h(60),
              height: SizeConfig.h(60),
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: SizeConfig.w(55),
            top: SizeConfig.h(480),
            child: Container(
              width: SizeConfig.h(30),
              height: SizeConfig.h(30),
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor, shape: BoxShape.circle),
            ),
          ),
          Scaffold(
            key: _key,
            backgroundColor: Colors.transparent,
            drawer: widget.hasDrawer?const Drawer(
                    child: AppDrawerWidget(),
                  ):null,

            appBar: widget.hasDrawer?
            BuildAppBar(scaffoldKey: _key):null,
            body: SafeArea(
              child: widget.child,
            ),
          )
        ],
      ),
    );
  }
}
