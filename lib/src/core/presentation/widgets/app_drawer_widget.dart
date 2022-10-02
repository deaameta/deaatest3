import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/core/util/helper.dart';

import '../../../../main.dart';
import '../../translations/l10n.dart';

class AppDrawerWidget extends StatefulWidget {
  const AppDrawerWidget({Key? key}) : super(key: key);

  @override
  State<AppDrawerWidget> createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  List<String> languages = [
    "en",
    "ar",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGray,
      width: SizeConfig.w(75),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.w(15),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),

            // Close icon
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.secondaryColor,
                  size: SizeConfig.w(5) * SizeConfig.h(5),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.h(10),
            ),

            if ((Helper.getUser().token ?? "").isNotEmpty) ...{
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${S.of(context).hi} ${(Helper.getUser().firstName ?? "")} ${(Helper.getUser().lastName ?? "")}",
                      style: AppStyle.regular(size: 16).copyWith(
                        fontWeight: FontWeight.normal,
                        color: AppColors.white,
                      )),

                ],
              ),
              SizedBox(
                height: SizeConfig.h(16),
              ),
            },

            // Content
            Column(
              children: [
                // Language
                Row(
                  children: [
                    Icon(
                      Icons.translate,
                      size: SizeConfig.h(25),
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: SizeConfig.w(10),
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          iconEnabledColor: AppColors.primaryColor,
                          dropdownColor: AppColors.primaryColor,
                          isExpanded: true,
                          items: languages.map((e) {
                            return  DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                Helper.getLangName(context, e),
                                style: AppStyle.regular(size: 15).copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            App.setLocale(context, value!);
                          },
                          value: Helper.getLang(),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: SizeConfig.h(15),
                ),
                // GolCoin
                InkWell(
                  onTap: () {
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.h(33),
                      ),
                      _buildTextDrawer(txt: S.of(context).gol_coin, selectRout: "/home"),
                      SizedBox(
                        height: SizeConfig.h(15),
                      ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {
                    // navigatorKey.currentState?.pushReplacementNamed("/term_and_conditions");
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.h(33),
                      ),
                      _buildTextDrawer(txt: S.of(context).term_and_conditions, selectRout: "/term_and_conditions"),
                      SizedBox(
                        height: SizeConfig.h(15),
                      ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {
                    navigatorKey.currentState?.pop();
                    navigatorKey.currentState?.pushNamed("/login");
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.h(33),
                      ),
                      Text(
                        (Helper.getUser().token ?? "").isEmpty ? S.of(context).login : S.of(context).logout,
                        style: AppStyle.regular(
                          size: 16,
                        ).copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.h(15),
                      ),
                      SizedBox(
                        height: SizeConfig.h(33),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextDrawer({required String txt, required String selectRout}) {
    //
    return Row(
      children: [
        if (ModalRoute.of(context)?.settings.name == selectRout) ...{
          Icon(
            Icons.arrow_forward_outlined,
            color: AppColors.secondaryColor,
            size: SizeConfig.w(5) * SizeConfig.h(5),
          ),
        },
        Spacer(),
        Text(txt,
            style: AppStyle.regular(size: 16).copyWith(
              fontWeight: FontWeight.normal,
              color: AppColors.white,
            )),
        Spacer(),
        if (ModalRoute.of(context)?.settings.name == selectRout) ...{
          Icon(
            Icons.arrow_back,
            color: AppColors.secondaryColor,
            size: SizeConfig.w(5) * SizeConfig.h(5),
          ),
        },
      ],
    );
  }
}
