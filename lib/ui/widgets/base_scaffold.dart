import 'package:flutter/material.dart';

class BaseScaffold extends Scaffold {
  BaseScaffold({
    required Widget body,
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
                  'images/base_grid.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 100, left: 30, right: 30, bottom: 50),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    width: 750,
                    height: 1500,
                    color: Colors.white,
                    child: body,
                  ),
                ),
              ),
            ],
          ),
        ));
}