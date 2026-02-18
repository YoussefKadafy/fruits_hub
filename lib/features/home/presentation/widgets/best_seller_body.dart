import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:fruits_hub/core/utils/products_grid_list.dart';

/// A widget that displays the best seller products grid.
///
/// This widget uses BLoC pattern to manage product loading states and
/// provides proper error handling and loading indicators.
class BestSellerBody extends StatelessWidget {
  const BestSellerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsCubit, GetProductsCubitState>(
      builder: (context, state) {
        // Extract products and loading state using pattern matching
        final (products, isLoading, errorMessage) = _extractStateData(state);

        // Handle error state with error widget
        if (errorMessage != null && products.isEmpty) {
          return _buildErrorWidget(context, errorMessage);
        }

        // Handle empty products state
        if (!isLoading && products.isEmpty) {
          return _buildEmptyWidget(context);
        }

        return ProductsGridList(products: products, isLoading: isLoading);
      },
    );
  }

  /// Extracts data from the cubit state in a clean, immutable way.
  /// This approach avoids mutable local variables and closure issues.
  (List<ProductEntity>, bool, String?) _extractStateData(
    GetProductsCubitState state,
  ) {
    if (state is GetProductsCubitSuccess) {
      return (state.products, false, null);
    } else if (state is GetProductsCubitFailure) {
      // Return empty list with error message for failure state
      return (const <ProductEntity>[], false, state.errorMessage);
    } else if (state is GetProductsCubitLoading) {
      return (const <ProductEntity>[], true, null);
    }
    // Initial state
    return (const <ProductEntity>[], true, null);
  }

  /// Builds an error widget with retry functionality.
  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            16.height,
            Text(
              'Failed to load products',
              style: AppStyles.wight600Size18.copyWith(
                color: Colors.red.shade700,
              ),
            ),
            8.height,
            Text(
              message,
              style: AppStyles.wight400Size14.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            24.height,
            ElevatedButton.icon(
              onPressed: () {
                // Retry loading products
                context.read<GetProductsCubit>().getProducts();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an empty state widget when no products are available.
  Widget _buildEmptyWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            16.height,
            Text(
              'No products available',
              style: AppStyles.wight600Size18.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            8.height,
            Text(
              'Check back later for new products',
              style: AppStyles.wight400Size14.copyWith(
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Extension to handle snackbar messages from parent widgets.
/// Call this method in the parent widget's listener if needed.
extension BestSellerBodyExtension on BuildContext {
  void showProductsError(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: () => read<GetProductsCubit>().getProducts(),
        ),
      ),
    );
  }
}
