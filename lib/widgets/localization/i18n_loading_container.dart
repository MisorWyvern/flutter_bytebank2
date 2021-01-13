import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/http/webclients/i18n_webclient.dart';
import 'package:flutter_bytebank02/models/cubits/i18n_messages_cubit.dart';

import 'i18n_loading_page.dart';

class I18NLoadingContainer extends StatelessWidget {
  final I18NWidgetCreator creator;
  final String pageKey;

  const I18NLoadingContainer({@required this.pageKey, @required this.creator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = I18NMessagesCubit(pageKey);
        cubit.reload(I18NWebClient(pageKey));
        return cubit;
      },
      child: I18NLoadingPage(creator),
    );
  }
}
