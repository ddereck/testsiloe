import 'package:flutter/material.dart';

import '../../../../commons/ui/widgets/text_field_edit_widget.dart';
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../../utils/field_formatter.dart';
import '../../adapters/donation_ui_controller.dart' show DonationUIController;

class SendDonationMessageWidget extends StatelessWidget {
  const SendDonationMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        DiHelper.findOrCreate(creator: () => DonationUIController());
    return Form(
      key: controller.donationMessageFormState,
      child: Column(
        spacing: AppConstantsUtils.itemSpacing,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFieldEditWidget(
            controller: controller.messageController,
            withEraser: false,
            withRadius: true,
            inputColor: Theme.of(context).highlightColor,
            hint: "@Marie Ange",
            titleBold: true,
            bold: true,
            minLines: 5,
            maxLines: 10,
            withTitleWhenTexting: false,
            blocColor: Theme.of(context).highlightColor,
            validator: (value) => FieldFormatter.validatorEmpty(value),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // couleur du texte
              backgroundColor: Colors.white, // couleur de fond
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: const BorderSide(color: Colors.grey),
            ),
            onPressed: () async {
              // Action de soumission
              await controller.onSubmit();
            },
            child: const Text(
              'Envoyer',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
