import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/entities/contact.dart';
import 'package:pie/lib/global.dart';

class ContactList extends ConsumerStatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  createState() => _ContactListState();
}

class _ContactListState extends ConsumerState<ContactList> {
  late final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contacts = ref.watch(ref.watch(currAccountPro)!.contactsPro);
    if (contacts.isEmpty) {
      return Center(
        child: Text('暂无联系人', style: TextStyle(color: Theme.of(context).hintColor)),
      );
    }

    return ListView.builder(
      key: const Key('contact_list'),
      controller: _controller,
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return ContactTile(contacts[contacts.length - index - 1]);
      },
    );
  }

  _scrollListener() {
    if (_controller.position.extentAfter < 1000) {
      setState(() {});
    }
  }
}

class ContactTile extends ConsumerStatefulWidget {
  final Contact contact;

  const ContactTile(this.contact, {Key? key}) : super(key: key);

  @override
  createState() => _ContactTileState();
}

class _ContactTileState extends ConsumerState<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      title: Text(ref.watch(widget.contact.user.pro.select((user) => user.name)), style: const TextStyle(fontSize: 15)),
      onTap: () {},
    );
  }
}
