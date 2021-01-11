import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:flutter_bytebank02/pages/contact_list.dart';

import '../contact.dart';

class ContactListCubit extends Cubit<ContactListState> {
  ContactListCubit() : super(InitContactListState());

  Future<void> reload(ContactDAO dao) async {
    emit(LoadingContactListState());
    List<Contact> contactList = await dao.findAll();
    emit(LoadedContactListState(contactList));
  }
}
