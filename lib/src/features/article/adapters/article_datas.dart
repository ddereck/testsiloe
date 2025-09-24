import '../../../utils/images_sources.dart';

class ArticleDatas {
  static const String articleArg = "articleArg";
  static const String articleId = "articleId";

  static final List<EntityComment> comments = [
    const EntityComment(
      id: 1,
      fullname: "John Doe",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      createdAt: "2023-06-01",
      photoUrl: ImagesSources.image1,
    ),
    const EntityComment(
      id: 2,
      fullname: "Jane Doe",
      content: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      createdAt: "2023-06-02",
      photoUrl: ImagesSources.image2,
    ),
    const EntityComment(
      id: 3,
      fullname: "Bob Smith",
      content: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      createdAt: "2023-06-03",
      photoUrl: ImagesSources.image1,
    ),
    const EntityComment(
      id: 4,
      fullname: "Alice Johnson",
      content: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      createdAt: "2023-06-04",
      photoUrl: ImagesSources.image2,
    ),
    const EntityComment(
      id: 5,
      fullname: "Charlie Brown",
      content: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      createdAt: "2023-06-05",
      photoUrl: ImagesSources.image1,
    ),
    const EntityComment(
      id: 6,
      fullname: "Eve Green",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      createdAt: "2023-06-06",
      photoUrl: ImagesSources.image2,
    ),
    const EntityComment(
      id: 7,
      fullname: "Frank White",
      content: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      createdAt: "2023-06-07",
      photoUrl: ImagesSources.image1,
    ),
    const EntityComment(
      id: 8,
      fullname: "Grace Black",
      content: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      createdAt: "2023-06-08",
      photoUrl: ImagesSources.image2,
    ),
    const EntityComment(
      id: 9,
      fullname: "Harry Red",
      content: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      createdAt: "2023-06-09",
      photoUrl: ImagesSources.image1,
    ),
    const EntityComment(
      id: 10,
      fullname: "Ivy Blue",
      content: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      createdAt: "2023-06-10",
      photoUrl: ImagesSources.image2,
    ),
  ];
}

class EntityComment {
  final int id;
  final String fullname;
  final String content;
  final String createdAt;
  final String photoUrl;

  const EntityComment({
    required this.id,
    required this.fullname,
    required this.content,
    required this.createdAt,
    required this.photoUrl
  });
}

enum ArticleCategory {
  education(label: "Enseignement"),
  verse(label: "Verset"),
  testimony(label: "Témoignage"),
  ;

  final String label;
  const ArticleCategory({required this.label});
}