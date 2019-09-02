import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String msg;

  Loading(this.msg);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Opacity(
          child: ModalBarrier(dismissible: false, color: Colors.grey),
          opacity: 0.3,
        ),
        const Center(child: CircularProgressIndicator()),
        Center(child: Text(this.msg)),
      ],
    );
  }
}
