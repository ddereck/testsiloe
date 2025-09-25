import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:siloe/src/utils/image_utils.dart';
import '../../../../di/di_helper.dart' show DiHelper;
import '../adapters/upsert_event_ui_controller.dart' show UpsertEventUIController;

class UpsertEventUI extends StatelessWidget {
  const UpsertEventUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        DiHelper.findOrCreate(creator: () => UpsertEventUIController());
    final isEditing = controller.currentEvent.value != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier un événement' : 'Créer un événement'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: controller.onSubmit,
              child: Obx(() => controller.isSubmitting.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Publier')),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.upsertEventFormState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: controller.titreController,
                label: 'Titre',
                hint: 'Saisissez le titre',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.sousTitreController,
                label: 'Sous Titre',
                hint: 'Saisissez le sous-titre',
              ),
              const SizedBox(height: 16),
              _buildImagePicker(controller),
              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.textePublicationController,
                label: 'Texte de publication',
                hint: 'Ecrire le texte de la publication',
                maxLines: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          maxLines: maxLines,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ce champ ne peut pas être vide';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildImagePicker(UpsertEventUIController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Insérer une image',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: controller.pickFile,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(Icons.attachment, color: Colors.grey),
                ),
                Text('Selectionnez le media',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.currentCoverFile.value != null) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                controller.currentCoverFile.value!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          } else if (controller.currentEvent.value?.imageDeCouverture != null) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: ImageUtils.buildImageUrl(
                    controller.currentEvent.value!.imageDeCouverture!),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}