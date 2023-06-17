import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Primary/blocs/category_bloc/category_bloc.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import '../screens/category_screen.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => BlocProvider<CategoryBloc>(
                create: (context) =>
                    CategoryBloc()..add(LoadCategory(categoryId: category.id)),
                child: CategoryScreen(category: category),
              ))),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: category.imgUrl,
                width: 130,
                height: 100,
                placeholder: (context, url) => Image.asset(
                  Images.PLACEHOLDER,
                  width: 130,
                  height: 100,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  Images.PLACEHOLDER,
                  width: 130,
                  height: 100,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(category.name),
                subtitle: Text(category.desc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
