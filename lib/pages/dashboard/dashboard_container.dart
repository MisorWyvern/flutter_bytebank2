import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/models/bloc_container.dart';
import 'package:flutter_bytebank02/models/cubits/name_cubit.dart';
import 'package:flutter_bytebank02/pages/dashboard/dashboard_page.dart';
import 'package:flutter_bytebank02/widgets/localization/i18n_loading_container.dart';

import 'dashboard_lazy_i18n.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NameCubit("Exemplo"),
      child: I18NLoadingContainer(
        pageKey: "dashboard",
        creator: (messages) => DashboardPage(DashboardPageLazyI18N(messages)),
      ),
    );
  }
}
