import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends Scaffold {
  BaseScaffold({
    required Widget body,
    String baseTitle = 'Chá de Casa Nova\nDiogo e Bebel',
    super.key,
    super.appBar,
    super.extendBodyBehindAppBar = true,
  }) : super(
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/base_grid_invert.png',
                    repeat: ImageRepeat.repeat,
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 30,
                    right: 30,
                    bottom: 50,
                  ),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.fromBorderSide(
                              BorderSide(
                                color: AppColors.appLightGreen,
                                width: 3,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20,
                          ),
                          child: Text(
                            baseTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.appDarkGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          constraints: const BoxConstraints(minHeight: 300),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          width: 750,
                          child: body,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
