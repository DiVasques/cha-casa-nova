import 'package:cha_casa_nova/services/models/result.dart';
import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TextButtonWithCheckbox extends StatefulWidget {
  final String? text;
  final Future<Result> Function()? onPressed;
  final bool dense;
  final bool selected;
  const TextButtonWithCheckbox(
      {super.key,
      this.text,
      this.onPressed,
      this.dense = false,
      this.selected = false});

  @override
  State<TextButtonWithCheckbox> createState() => _TextButtonWithCheckboxState();
}

class _TextButtonWithCheckboxState extends State<TextButtonWithCheckbox> {
  bool loading = false;

  late bool selected;
  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        loading = true;
        setState(() {});
        widget.onPressed?.call().then((Result result) {
          if (result.status) {
            selected = !selected;
          }
          loading = false;
          setState(() {});
        });
      },
      child: Container(
        width: widget.dense ? null : 250,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.appDarkGreen,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: widget.dense ? MainAxisSize.min : MainAxisSize.max,
          children: <Widget>[
            Text(
              widget.text ?? '',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            loading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : selected
                    ? const Icon(Icons.check_box_outlined, color: Colors.white)
                    : const Icon(Icons.check_box_outline_blank,
                        color: Colors.white),
          ],
        ),
      ),
    );
  }
}
