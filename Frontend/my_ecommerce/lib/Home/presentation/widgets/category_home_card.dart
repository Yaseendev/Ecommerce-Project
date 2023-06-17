import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Primary/blocs/category_bloc/category_bloc.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import '../screens/category_screen.dart';

class CategoryHomeCard extends StatelessWidget {
  final Category category;
  const CategoryHomeCard(
    this.category, {
    super.key,
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
      child: SizedBox(
        width: 85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 30,
              foregroundImage: NetworkImage(category.imgUrl),
              //onForegroundImageError: ,
              backgroundImage: AssetImage(Images.PLACEHOLDER),
              //child: Icon(FontAwesomeIcons.shop),
            ),
            SizedBox(height: 8),
            Text(
              category.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
