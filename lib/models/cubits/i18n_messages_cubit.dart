import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/http/webclients/i18n_webclient.dart';
import 'package:flutter_bytebank02/widgets/localization/i18n_states.dart';
import 'package:localstorage/localstorage.dart';

import '../i18n_messages.dart';

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  final LocalStorage storage = new LocalStorage('local_unsafe_v_1.json');

  final String _pageKey;
  I18NMessagesCubit(this._pageKey) : super(InitI18NMessagesState());

  void reload(I18NWebClient webClient) async {
    emit(LoadingI18NMessagesState());
    await storage.ready;

    //Verify internal storage
    final items = storage.getItem(_pageKey);
    if (items != null) {
      emit(
        LoadedI18NMessagesState(
          I18NMessages(items),
        ),
      );
      return;
    }

    //Download messages
    final Map<String, dynamic> messages = await webClient.findAll();
    if (messages != null) {
      saveAndRefresh(messages);
    }
  }

  void saveAndRefresh(Map<String, dynamic> messages) {
    storage.setItem(_pageKey, messages);
    emit(LoadedI18NMessagesState(I18NMessages(messages)));
  }
}
