import 'package:flutter/material.dart';

import '../../../../core/configs/time_config.dart' show TimeConfig;
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../utils/text_config.dart' show TextConfig;
import '../../../don/domain/entities/entity_don.dart' show EntityDon;

class DonationItemWidget extends StatelessWidget {
  final EntityDon don;
  const DonationItemWidget({super.key, required this.don});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: AppConstantsUtils.itemSpacing,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/avatar.jpg'),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TimeConfig.parseAnyDateFormatted(don.createdAt),
                style: TextConfig.getSimpleTextStyle(true, size: AppConstantsUtils.smallSize),
              ),
              Text.rich(
                TextSpan(
                  text: don.nomAffiche ?? "-",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: " a fait un don de ",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: "${don.montant} FCFA",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        /*
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Row(
                    children: [
                      Icon(TablerIcons.message,
                          size: AppConstantsUtils.iconSizeMiddle),
                      Expanded(
                        child: Text("Message personnalisé",
                            style:
                                TextConfig.getSimpleTextStyle(true, size: 15)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Important pour que la hauteur s’adapte au contenu
                    children: const [
                      SendDonationMessageWidget(),
                    ],
                  ),
                );
              },
            );
          },
          child: Icon(TablerIcons.send_2, color: Colors.redAccent),
        ),
        */
        const SizedBox(width: AppConstantsUtils.itemSpacing),
      ],
    );
  }
}
