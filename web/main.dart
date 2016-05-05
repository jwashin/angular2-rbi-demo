import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/platform/browser.dart';

//import 'package:uuid/uuid.dart';
import 'package:contact_list/services/contacts.dart';

import 'package:contact_list/app.dart';

void main() {
  bootstrap(App, [
// This apparently doesn't work anymore, so we are removing it.
//    provide(Uuid, useValue: new Uuid()),
    Contacts,
    ROUTER_PROVIDERS,
    provide(LocationStrategy, useClass: HashLocationStrategy),
  ]);
}
