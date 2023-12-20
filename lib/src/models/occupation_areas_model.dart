// ignore_for_file: public_member_api_docs, sort_constructors_first
class OccupationAreasModel {
  String? area;
  List<String>? profissoes;

  OccupationAreasModel({
    this.area,
    this.profissoes,
  });

  @override
  String toString() => 'OccupationAreas(area: $area, profissoes: $profissoes)';
}
