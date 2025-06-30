import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../providers/cart_providers.dart';
import '../exceptions/api_exception.dart';
import '../viewmodels/checkout_viewmodel.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';
import '../utils/app_themes.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(titleWidget: Text("Checkout")),
      bottomNavigationBar: const CustomFooter(),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                label: "Name",
                onSaved: (val) => name = val ?? '',
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              _buildTextField(
                label: "Email",
                onSaved: (val) => email = val ?? '',
                validator:
                    (val) =>
                        val != null && val.contains("@")
                            ? null
                            : "Invalid email",
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting ? null : () => _submitOrder(cart),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.appBarTheme.foregroundColor,
                  foregroundColor: theme.appBarTheme.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                child:
                    _isSubmitting
                        ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.onPrimary,
                            ),
                            strokeWidth: 2,
                          ),
                        )
                        : const Text("Confirm Purchase"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onSaved: onSaved,
      validator: validator,
    );
  }

  void _submitOrder(List<CartItem> cart) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isSubmitting = true);

      try {
        await ref
            .read(checkoutViewModelProvider)
            .submitOrder(name: name, email: email, cart: cart);

        if (!mounted) return;
        Navigator.of(context).pushNamed("/confirmation");
      } catch (e) {
        String userFriendlyMessage =
            "An unexpected error occurred. Please try again.";

        if (e is ApiException) {
          if (e.code == "not_enough_tickets") {
            userFriendlyMessage =
                "Sorry! We don't have enough tickets available for your order.";
          } else {
            userFriendlyMessage = e.message;
          }
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(userFriendlyMessage)));
      } finally {
        if (mounted) setState(() => _isSubmitting = false);
      }
    }
  }
}
