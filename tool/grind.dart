import 'package:grinder/grinder.dart';
import 'dart:async';

Future main(List<String> args) async {
  await grind(args);
}

@Task()
void format() => DartFmt.format(existingSourceDirs);
