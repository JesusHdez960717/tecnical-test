import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tecnical_test/config/config_exporter.dart';
import 'package:tecnical_test/domain/domain_exporter.dart';

class UserTile extends StatelessWidget {
  final VoidCallback? onTap;

  final bool showGender;
  final UserDomain item;

  const UserTile({
    required this.item,
    this.onTap,
    this.showGender = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.network(item.picture.thumbnail),
        ),
        title: Text(item.name.fullName),
        subtitle: Text(
          item.email,
          overflow: TextOverflow.ellipsis,
        ),
        contentPadding: const EdgeInsets.only(left: 16.0, right: 0.0),
        trailing: showGender ? _buildGender() : null,
      ),
    );
  }

  Widget _buildGender() {
    String url = item.gender.isMale ? AssetsConfig.male : AssetsConfig.female;
    return SvgPicture.asset(
      url,
      semanticsLabel: url,
      width: 50,
      height: 50,
      fit: BoxFit.scaleDown,
    );
  }
}
