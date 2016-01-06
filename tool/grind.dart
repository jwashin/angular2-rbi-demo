import 'package:grinder/grinder.dart';

main(List<String> args) => grind(args);

@Task()
void format() => DartFmt.format(existingSourceDirs);
