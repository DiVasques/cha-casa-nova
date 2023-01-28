import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final IconData icon;
  final String? text;
  final void Function()? onPressed;
  const SignInButton(
      {super.key, required this.icon, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 250,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.appDarkGreen,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text ?? '',
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
