// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/widgets.dart';
import 'package:tecnical_test/l10n/l10n_exporter.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

//run fvm flutter gen-l10n
extension AppLocalizationsX on BuildContext {
  AppLocalizations get intl => AppLocalizations.of(this);
}
