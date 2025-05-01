enum ThemeType {
  light,
  dark;

  bool get isLight => this == ThemeType.light;
  bool get isDark => this == ThemeType.dark;
}
