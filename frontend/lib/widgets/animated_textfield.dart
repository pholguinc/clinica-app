import 'package:flutter/material.dart';
import 'package:frontend/widgets/custom_animate_border.dart';

class AnimatedTextField extends StatefulWidget {
  final String label;
  final Widget? suffix;
  final bool obscureText;
  final TextEditingController textCtrl;
  final FormFieldValidator<String>? validator;

  const AnimatedTextField({
    Key? key,
    required this.label,
    required this.suffix,
    this.obscureText = false,
    required this.textCtrl, 
    required this.validator,
  }) : super(key: key);

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation<double> alpha;
  final focusNode = FocusNode();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    final Animation<double> curve =
        CurvedAnimation(parent: controller!, curve: Curves.easeInOut);
    alpha = Tween(begin: 0.0, end: 1.0).animate(curve);

    // controller?.forward();
    controller?.addListener(() {
      setState(() {});
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller?.forward();
      } else {
        controller?.reverse();
      }
    });
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.cyan,
              ),
        ),
        child: CustomPaint(
          painter: CustomAnimateBorder(alpha.value),
          child: Form(
            // Wrap the TextField with Form
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              focusNode: focusNode,
              obscureText: widget.obscureText,
              controller: widget.textCtrl,
              decoration: InputDecoration(
                labelText: widget.label,
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                suffixIcon: widget.suffix,
              ),
              validator: widget.validator, // Set the validator function
            ),
          ),
        ),
      ),
    );
  }
}