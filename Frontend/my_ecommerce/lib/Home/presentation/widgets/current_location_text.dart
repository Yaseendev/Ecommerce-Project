import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Address/blocs/location_bloc/location_bloc.dart';

class CurrentLocationText extends StatelessWidget {
  const CurrentLocationText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationLoaded)
          return SizedBox(
            width: MediaQuery.of(context).size.width * .45,
            child: Text(
              '${state.location.area}, ${state.location.city}',
              overflow: TextOverflow.ellipsis,
            ),
          );
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2,
            ),
          ),
        );
      },
    );
  }
}
