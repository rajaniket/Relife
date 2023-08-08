import 'package:flutter/material.dart';

class RoundBackButton extends StatelessWidget {
  final Color backgroundColour;
  final VoidCallback onPressed;
  const RoundBackButton({
    Key? key,
    this.backgroundColour = Colors.white,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      child: const Icon(
        Icons.arrow_back_ios_new_outlined,
      ),
      fillColor: backgroundColour,
      shape: const CircleBorder(),
      highlightElevation: 0,
    );
  }
}

class RoundEditButton extends StatelessWidget {
  final Color backgroundColour;
  final VoidCallback onPressed;
  const RoundEditButton({
    Key? key,
    this.backgroundColour = Colors.white,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      child: const Icon(
        Icons.edit,
      ),
      fillColor: backgroundColour,
      shape: const CircleBorder(),
      highlightElevation: 0,
    );
  }
}

class RoundAddButton extends StatelessWidget {
  final Color backgroundColour;
  final VoidCallback onPressed;
  const RoundAddButton({
    Key? key,
    this.backgroundColour = Colors.white,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      child: const Icon(
        Icons.add,
        color: Colors.black,
        size: 30,
      ),
      fillColor: backgroundColour,
      shape: const CircleBorder(),
      highlightElevation: 0,
    );
  }
}
