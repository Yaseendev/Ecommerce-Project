import 'package:flutter/material.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Product/presentation/widgets/grid_products_view.dart';
import 'package:my_ecommerce/Product/presentation/widgets/list_products_view.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/enums.dart';

class HomeProductsScreen extends StatefulWidget {
  final String title;
  final List<Product> products;
  const HomeProductsScreen({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  State<HomeProductsScreen> createState() => _HomeProductsScreenState();
}

class _HomeProductsScreenState extends State<HomeProductsScreen> {
  ViewType viewType = ViewType.grid;
  final List<bool> selectedViews = [true, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
        leading: BackButton(
          color: AppColors.PRIMARY_COLOR,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(14),
              children: [
                const Icon(Icons.grid_view_rounded),
                const Icon(Icons.view_list_rounded),
              ],
              isSelected: selectedViews,
              onPressed: (index) {
                if (!selectedViews[index]) {
                  selectedViews.fillRange(0, selectedViews.length, false);
                  setState(() {
                    selectedViews[index] = !selectedViews[index];
                  });
                }
              },
            ),
          ),
          Expanded(
            child: widget.products.isEmpty
                ? Center(
                    child: Text(
                      'There is no ${widget.title} products yet',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                : selectedViews.first
                    ? GridProductsView(
                        products: widget.products,
                      )
                    : ListProductsView(
                        products: widget.products,
                      ),
          ),
        ],
      ),
    );
  }
}
