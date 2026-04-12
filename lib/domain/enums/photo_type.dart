enum PhotoType {
  normal,
  duplicate, // Giống hệt nhau về size, date
  burst, // Chụp liên tục (tương lai)
  blurry, // Ảnh mờ (tương lai)
  screenshot; // Ảnh chụp màn hình

  bool get isNormal => this == PhotoType.normal;
  bool get isDuplicate => this == PhotoType.duplicate;
  bool get isBurst => this == PhotoType.burst;
  bool get isBlurry => this == PhotoType.blurry;
  bool get isScreenshot => this == PhotoType.screenshot;
}
