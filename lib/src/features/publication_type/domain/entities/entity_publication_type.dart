import 'package:equatable/equatable.dart';

class EntityPublicationType extends Equatable {
  final int? id;
  final String? typePublication;

  const EntityPublicationType({ this.id, this.typePublication });

  factory EntityPublicationType.fromJson(Map<String, dynamic> json) {
    return EntityPublicationType(
      id: _toInt(json['id']),
      typePublication: json['type_publication']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_publication': typePublication,
    };
  }

  @override
  List<Object?> get props => [id, typePublication];
}
/// Helper: convertit string|int|null en int?
int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}