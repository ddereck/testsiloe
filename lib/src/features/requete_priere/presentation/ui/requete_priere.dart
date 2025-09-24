import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../commons/ui/widgets/custom_app_bar.dart';
import '../../../../commons/ui/widgets/text_field_edit_widget.dart'
    show TextFieldEditWidget;
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../di/di_helper.dart';
import '../adapters/requete_priere_ui_controller.dart'
    show RequetePriereUiController;
import '../../../../utils/field_formatter.dart' show FieldFormatter;

class RequetePrierePage extends StatelessWidget {
  const RequetePrierePage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final requetePriereUiController =
        DiHelper.findOrCreate(creator: () => RequetePriereUiController());
    //

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(title: 'Intentions de prière'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior
            .opaque, // pour capter les taps même sur les zones vides
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: requetePriereUiController.sendRequestFormState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16)),
                        child: Image.asset(
                          'assets/images/priere.png',
                          width: 120,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Requêtes de prière',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Confiez-nous votre sujet de prière, nous prierons avec foi pour vous.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Nom et prenoms',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFieldEditWidget(
                  controller: requetePriereUiController.nameController,
                  inputColor: Theme.of(context).highlightColor,
                  hint: "Saisissez votre nom et prenom",
                  withTitleWhenTexting: false,
                  keyboardType: TextInputType.text,
                  blocColor: Theme.of(context).highlightColor,
                  borderColor: Colors.black,
                  validator: (value) => FieldFormatter.validatorEmpty(value),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Intention de prière',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFieldEditWidget(
                  controller: requetePriereUiController.requestController,
                  inputColor: Theme.of(context).highlightColor,
                  hint: "Saisissez votre intention de prière",
                  withTitleWhenTexting: false,
                  keyboardType: TextInputType.text,
                  blocColor: Theme.of(context).highlightColor,
                  borderColor: Colors.black,
                  minLines: 4,
                  maxLines: 8,
                  validator: (value) => FieldFormatter.validatorEmpty(value),
                ),
                const SizedBox(height: 24),
                Center(
                  child: OutlinedButton(
                    onPressed: () async {
                      // à connecter avec Firebase ou autre backend
                      debugPrint('Nom: \${nameController.text}');
                      debugPrint('Intention: \${requestController.text}');
                      await requetePriereUiController.onSubmit();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white, // couleur du texte
                      backgroundColor: Colors.grey.shade900, // couleur de fond
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstantsUtils.radiusMedium),
                      ),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                    child: Obx(() {
                      if (requetePriereUiController.isSubmitting.value) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      return const Text(
                        "Soumettre",
                        style: TextStyle(fontSize: 16),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
