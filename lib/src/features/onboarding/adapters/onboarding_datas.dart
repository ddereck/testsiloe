class OnboardingDatas {
  static List<ObjectOnboarding> pages = [
    ObjectOnboarding(
      image: null,
      title: "",
      description: "", 
    ),
    ObjectOnboarding(
      image: null,
      title: "",
      description: "", 
    ),
    ObjectOnboarding(
      image: null,
      title: "",
      description: "", 
    ),
  ];
}

class ObjectOnboarding {
  final String? image;
  final String title;
  final String description;
  const ObjectOnboarding({this.image, required this.title, required this.description});
}