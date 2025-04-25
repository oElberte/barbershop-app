import 'package:barbershop/src/core/ui/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    this.hideUploadButton = false,
  });

  final bool hideUploadButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 102,
      height: 102,
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.avatar),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Offstage(
              offstage: hideUploadButton,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorsConstants.brown, width: 4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  BarbershopIcons.addEmployee,
                  color: ColorsConstants.brown,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
