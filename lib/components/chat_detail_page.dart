import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/entities/chat.dart';
import 'package:pie/lib/config.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  final Chat chat;

  const ChatDetailPage(this.chat, {Key? key}) : super(key: key);

  @override
  createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    final userPro = widget.chat.user!.pro;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (ref.watch(userPro.select((user) => user.contactName)).isNotEmpty) Text(ref.watch(userPro.select((user) => user.contactName))),
                  Text(ref.watch(userPro.select((user) => user.name))),
                ],
              ),
              background: Hero(
                tag: 'user_avatar',
                child: Container(
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.black.withAlpha(0), Colors.black26],
                    ),
                  ),
                  child: ref.watch(userPro.select((user) => user.hasAvatar))
                      ? Image.file(File(widget.chat.user!.avatarPath), width: MediaQuery.of(context).size.width)
                      : Image.asset('assets/icon/icon.png', width: MediaQuery.of(context).size.width),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (ref.watch(userPro.select((user) => user.email)).isNotEmpty || ref.watch(userPro.select((user) => user.bio)).isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: pagePaddingSize),
                            child: Text('个人信息', style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).primaryColor)),
                          ),
                          if (ref.watch(userPro.select((user) => user.email)).isNotEmpty)
                            ListTile(
                              title: Text(ref.watch(userPro.select((user) => user.email))),
                              subtitle: const Text('电子邮箱'),
                              onTap: () {},
                            ),
                          if (ref.watch(userPro.select((user) => user.bio)).isNotEmpty)
                            ListTile(
                              title: Text(ref.watch(userPro.select((user) => user.bio))),
                              subtitle: const Text('个人简介'),
                              onTap: () {},
                            ),
                        ],
                      )
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
