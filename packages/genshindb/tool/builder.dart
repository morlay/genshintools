import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator/enum_extra_generator.dart';

Builder enumExtraBuilder(BuilderOptions options) =>
    SharedPartBuilder([const EnumExtraGenerator()], 'enum_extra');
