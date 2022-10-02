extension StringExtension on String {
  // String capitalize() {
  //   if(length > 0) {
  //     return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  //   }
  //   return this;
  // }
  String get capitalize => length > 0 ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}" : this;
}
