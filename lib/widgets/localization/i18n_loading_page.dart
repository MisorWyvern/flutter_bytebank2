import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/models/cubits/i18n_messages_cubit.dart';
import 'package:flutter_bytebank02/models/i18n_messages.dart';
import 'package:flutter_bytebank02/pages/alert_page.dart';
import 'package:flutter_bytebank02/pages/progress_indicator_page.dart';

import 'i18n_states.dart';

typedef Widget I18NWidgetCreator(I18NMessages messages);

class I18NLoadingPage extends StatelessWidget {
  final I18NWidgetCreator _creator;
  I18NLoadingPage(this._creator);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state) {
        if (state is InitI18NMessagesState ||
            state is LoadingI18NMessagesState) {
          return ProgressIndicatorPage(
            message: "Loading...",
            title: "Loading...",
          );
        }

        if (state is LoadedI18NMessagesState) {
          final messages = state.messages;
          return _creator.call(messages);
        }

        return AlertPage();
      },
    );
  }
}
