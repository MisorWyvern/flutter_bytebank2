import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/http/webclients/i18n_webclient.dart';
import 'package:flutter_bytebank02/models/bloc_container.dart';
import 'package:flutter_bytebank02/pages/alert_page.dart';
import 'package:flutter_bytebank02/pages/progress_indicator_page.dart';

class LocalizationContainer extends BlocContainer {
  final Widget child;

  LocalizationContainer({@required this.child});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (context) => CurrentLocaleCubit(),
      child: child,
    );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super("pt-br");
}

class PageI18N {
  String _language;

  PageI18N(BuildContext context) {
    this._language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String localize(Map<String, String> values) {
    assert(values != null);
    assert(values.containsKey(_language));

    return values[_language];
  }
}

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
          final messages = state._messages;
          return _creator.call(messages);
        }

        return AlertPage();
      },
    );
  }
}

typedef Widget I18NWidgetCreator(I18NMessages messages);

class I18NLoadingContainer extends StatelessWidget {
  final I18NWidgetCreator creator;
  final String pageKey;

  const I18NLoadingContainer({@required this.pageKey, @required this.creator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = I18NMessagesCubit();
        cubit.reload(I18NWebClient(pageKey));
        return cubit;
      },
      child: I18NLoadingPage(creator),
    );
  }
}

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  I18NMessagesCubit() : super(InitI18NMessagesState());

  reload(I18NWebClient webClient) async {
    emit(LoadingI18NMessagesState());
    webClient.findAll().then(
          (messages) => emit(
            LoadedI18NMessagesState(
              I18NMessages(messages),
            ),
          ),
        );
  }
}

class I18NMessages {
  final Map<String, dynamic> _messages;

  I18NMessages(this._messages);

  String get(String key) {
    assert(key != null);
    assert(_messages.containsKey(key));
    return _messages[key];
  }
}

@immutable
abstract class I18NMessagesState {
  const I18NMessagesState();
}

@immutable
class InitI18NMessagesState extends I18NMessagesState {
  const InitI18NMessagesState();
}

@immutable
class LoadingI18NMessagesState extends I18NMessagesState {
  const LoadingI18NMessagesState();
}

@immutable
class LoadedI18NMessagesState extends I18NMessagesState {
  final I18NMessages _messages;
  const LoadedI18NMessagesState(this._messages) : assert(I18NMessages != null);
}

@immutable
class FatalErrorI18NMessagesState extends I18NMessagesState {
  const FatalErrorI18NMessagesState();
}
