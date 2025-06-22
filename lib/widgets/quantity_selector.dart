import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int maxQuantity;
  final int initialQuantity;
  final ValueChanged<int> onQuantityChanged;

  const QuantitySelector({
    super.key,
    required this.maxQuantity,
    required this.initialQuantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialQuantity.toString());

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed:
              initialQuantity > 0
                  ? () => onQuantityChanged(initialQuantity - 1)
                  : null,
        ),
        SizedBox(
          width: 50,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              final qty = int.tryParse(value) ?? 0;
              if (qty >= 0 && qty <= maxQuantity) {
                onQuantityChanged(qty);
              }
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed:
              initialQuantity < maxQuantity
                  ? () => onQuantityChanged(initialQuantity + 1)
                  : null,
        ),
      ],
    );
  }
}
