import 'package:flutter/material.dart';
import 'package:my_ecommerce/Utils/constants.dart';

class AccountScreenItems extends StatelessWidget {
  const AccountScreenItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            leading: CircleAvatar(
              child: const Icon(
                Icons.settings_rounded,
                color: Colors.white,
              ),
              backgroundColor: AppColors.PRIMARY_COLOR,
            ),
            title: const Text('Settings'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            //onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingsScreen())),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.privacy_tip_rounded,
                color: Colors.white,
              ),
              backgroundColor: AppColors.PRIMARY_COLOR,
            ),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.info_rounded,
                color: Colors.white,
              ),
              backgroundColor: AppColors.PRIMARY_COLOR,
            ),
            title: const Text('About Us'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ]).toList(),
      ),
    );
  }
}
