import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../commons/functions/widgets_functions.dart' show customSnackBar;
import '../../../../di/controllers_provider.dart' show ControllersProvider;
import '../../domain/entities/entity_demande_rencontre.dart'
    show EntityDemandeRencontre;

class DemandeRencontreUiController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<EntityDemandeRencontre> mesDemandeRencontres =
      <EntityDemandeRencontre>[].obs;
  RxList<EntityDemandeRencontre> allDemandeRencontres =
      <EntityDemandeRencontre>[].obs;
  void setMesDemandeRencontres(List<EntityDemandeRencontre> demandeRencontres) {
    mesDemandeRencontres.value = demandeRencontres;
    update();
  }

  void setDemandeRencontres(List<EntityDemandeRencontre> demandeRencontres) {
    allDemandeRencontres.value = demandeRencontres;
    update();
  }

  Future<void> initDemandeRencontres() async {
    final listdemandeRencontres = await ControllersProvider
        .DEMANDE_RENCONTRE_CONTROLLER
        .getDemandesRencontre();
    final listMesDemandeRencontres = await ControllersProvider
        .DEMANDE_RENCONTRE_CONTROLLER
        .getMesDemandesRencontre();
    setMesDemandeRencontres(listMesDemandeRencontres);
    setDemandeRencontres(listdemandeRencontres);

    // Ajouter toute aux filters
    filterMesDemandeRencontres.value = mesDemandeRencontres;
    filterAllDemandeRencontres.value = allDemandeRencontres;
    update();
  }

  RxList<EntityDemandeRencontre> filterMesDemandeRencontres =
      <EntityDemandeRencontre>[].obs;
  RxList<EntityDemandeRencontre> filterAllDemandeRencontres =
      <EntityDemandeRencontre>[].obs;
  final Rx<DateTime?> rencontreDateController = Rx<DateTime?>(null);
  void onSelectDate(DateTime selectedDay, DateTime? focusedDay) {
    rencontreDateController.value = selectedDay;
    update();

    // Filtre les rendez-vous pour la date choisie
    filterMesDemandeRencontres.value =
        mesDemandeRencontres.where((demandeRencontre) {
      if (demandeRencontre.date == null) return false;
      return DateTime.tryParse(demandeRencontre.date!) ==
          rencontreDateController.value;
    }).toList();
    filterAllDemandeRencontres.value =
        allDemandeRencontres.where((demandeRencontre) {
      if (demandeRencontre.date == null) return false;
      return DateTime.tryParse(demandeRencontre.date!) ==
          rencontreDateController.value;
    }).toList();
  }

  final makePrayerFormState = GlobalKey<FormState>();
  final TextEditingController makeRequestFullnameController =
      TextEditingController();
  final TextEditingController makeRequestPhoneController =
      TextEditingController();
  final Rx<DateTime?> makeRequestDateController = Rx<DateTime?>(null);
  final TextEditingController makeRequestObjectController =
      TextEditingController();
      final TextEditingController makeRequestEmailController =
      TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: makeRequestDateController.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Sélectionnez une date',
    );

    if (picked != null && picked != makeRequestDateController.value) {
      makeRequestDateController.value = picked;
      update();
    }
  }

  RxBool isSubmitting = RxBool(false);

  Future<void> onSubmitPrayerRequest() async {
    final formState = makePrayerFormState.currentState;
    if (formState == null) return;

    bool valid = formState.validate();

    // Vérifier date obligatoire
    if (makeRequestDateController.value == null) {
      valid = false;
      customSnackBar(
        title: "Erreur",
        message: "La date de rendez-vous est obligatoire.",
        isError: true,
      );
    }

  // Vérifier email non null / non vide si l’API l’exige
  final String emailInput = makeRequestEmailController.text.trim();
  if (emailInput.isEmpty) {
    valid = false;
    customSnackBar(
      title: "Erreur",
      message: "L’email est obligatoire.",
      isError: true,
    );
  } else {
    // Vérifier format de l’email
    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailPattern.hasMatch(emailInput)) {
      valid = false;
      customSnackBar(
        title: "Erreur",
        message: "Format de l’email invalide.",
        isError: true,
      );
    }
  }

    if (!valid) {
      return;
    }

    isSubmitting.value = true;
    update();

    try {
      final req = await ControllersProvider
          .DEMANDE_RENCONTRE_CONTROLLER
          .createDemandeRencontre(
        date: makeRequestDateController.value!.toIso8601String(),
        nomPrenoms: makeRequestFullnameController.text.trim(),
        telephone: makeRequestPhoneController.text.trim(),
        objet: makeRequestObjectController.text.trim(),
        email: emailInput, 
      );

      if (req == null) {
        customSnackBar(
          title: "Erreur",
          message: "Une erreur est survenue, veuillez réessayer.",
          isError: true,
        );
      } else {
        customSnackBar(
          title: "Merci",
          message: "Votre demande a bien été prise en compte.",
          isError: false,
        );
        // Optionnel: vider les champs
        makeRequestFullnameController.clear();
        makeRequestPhoneController.clear();
        makeRequestObjectController.clear();
        makeRequestEmailController.clear();
        makeRequestDateController.value = null;
        update();
      }
    } catch (e) {
      customSnackBar(
        title: "Erreur",
        message: "Exception lors de la soumission : $e",
        isError: true,
      );
    } finally {
      isSubmitting.value = false;
      update();
    }
  }

  RxBool showCalendar = RxBool(false);
  void toggleCalendar() {
    showCalendar.value = !showCalendar.value;
    update();
  }

  final List<Tab> myRdvTabs = const <Tab>[
    Tab(text: 'DEMANDES'),
    Tab(text: 'MES RDVS'),
  ];
  late final TabController rdvTabController;
  void initTabController() {
    rdvTabController = TabController(vsync: this, length: myRdvTabs.length);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    rdvTabController = TabController(vsync: this, length: myRdvTabs.length);
    update();
  }

  @override
  void onClose() {
    rdvTabController.dispose();
    makeRequestFullnameController.dispose();
    makeRequestPhoneController.dispose();
    makeRequestObjectController.dispose();
    makeRequestEmailController.dispose();
    super.onClose();
  }
}
