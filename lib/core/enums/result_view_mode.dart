enum ResultViewMode {
  individual, // Duyệt từng ảnh (Stack/Swiper)
  grouped; // Duyệt theo nhóm (Grid)

  bool get isIndividual => this == ResultViewMode.individual;
  bool get isGrouped => this == ResultViewMode.grouped;
}
