import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/core/presentation/pages/background_page.dart';
import 'package:nft_deaa/src/core/presentation/widgets/app_loader.dart';
import 'package:nft_deaa/src/core/presentation/widgets/main_button.dart';
import 'package:nft_deaa/src/core/services/uni_links/init_uni_links.dart';
import 'package:nft_deaa/src/core/translations/l10n.dart';
import 'package:nft_deaa/src/core/util/helper.dart';
import 'package:nft_deaa/src/features/auth/data/data_sources/auth_shared_prefs.dart';
import 'package:nft_deaa/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nft_deaa/src/features/home/domain/entities/transaction_statis_enum.dart';
import 'package:nft_deaa/src/features/home/presentation/bloc/home_bloc.dart';

import '../../../../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeBloc();


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
        child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(20)),
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/svg_images/logo.svg",
                color: AppColors.secondaryColor,
                height: SizeConfig.h(55),
                width: SizeConfig.h(55),
              ),
            ),
            SizedBox(
              height: SizeConfig.h(10),
            ),
            SizedBox(
              height: SizeConfig.h(40),
            ),
            Text(
              S.of(context).golCoin_staking_is_a_simple,
              textAlign: TextAlign.center,
              style: AppStyle.regular(size: 20).copyWith(color: AppColors.white, height: SizeConfig.h(1.5)),
            ),
            SizedBox(
              height: SizeConfig.h(55),
            ),
            BlocConsumer(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is HomeLoadingGetTransactionState) {
                    return const AppLoader();
                  }
                  return Column(
                    children: [
                      MainButton(
                        width: SizeConfig.w(200),
                        backgroundColor: AppColors.white.withOpacity(0.3),
                        hasBorder: true,
                        // borderRadius: BorderRadius.circular(7),
                        onPressed: () {
                          navigatorKey.currentState?.pushNamed("/login");

                        },
                        label: S.of(context).collect_your_rewards,
                        textStyle: AppStyle.regular(size: 14).copyWith(color: AppColors.white),
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  );
                },
                listener: (context, state) {
                  if (state is HomeFailureGetTransactionState) {
                    Helper.showSnackBar(context, state.message);
                  } else if (state is HomeSuccessGetTransactionState) {

                  }
                }),
          ],
        ),
      ),
    ));
  }
}
