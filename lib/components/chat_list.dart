import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/components/chat_page.dart';
import 'package:pie/entities/chat.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/time.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
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
    final chats = ref.watch(ref.watch(currAccountPro)!.chatsPro);
    if (chats.isEmpty) {
      return Center(
        child: Text('暂无消息', style: TextStyle(color: Theme.of(context).hintColor)),
      );
    }
    return ListView.builder(
      key: const PageStorageKey('chat_list'),
      controller: _controller,
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatTile(chats[chats.length - index - 1]);
      },
    );
  }

  _scrollListener() {
    if (_controller.position.extentAfter < 1000) {
      setState(() {});
    }
  }
}

class ChatTile extends ConsumerStatefulWidget {
  final Chat chat;

  const ChatTile(this.chat, {Key? key}) : super(key: key);

  @override
  createState() => _ChatTileState();
}

class _ChatTileState extends ConsumerState<ChatTile> {
  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(widget.chat.messagesPro);
    return SizedBox(
      height: 100,
      child: Material(
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(widget.chat))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: pagePaddingSize),
            child: Row(
              children: [
                Hero(
                  tag: 'user_avatar',
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: ref.watch(widget.chat.user!.pro.select((user) => user.hasAvatar))
                        ? Image.file(File(widget.chat.user!.avatarPath)).image
                        : Image.asset('assets/icon/icon.png').image,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Hero(
                                tag: 'user_name',
                                child: Text(
                                  ref.watch(widget.chat.user!.pro.select((user) => user.contactName.isNotEmpty ? user.contactName : user.name)),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                ref.watch(widget.chat.pro.select((chat) => formatTime(chat.time))),
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).hintColor),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: messages.isEmpty
                                  ? Container()
                                  : Text(
                                      ref.watch(messages.l.last.pro.select((msg) => msg.content)),
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).hintColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ref.watch(widget.chat.pro.select((chat) => chat.numUnread == 0))
                                  ? const SizedBox(width: 30)
                                  : Container(
                                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 12,
                                        minHeight: 12,
                                      ),
                                      child: Text(
                                        ref.watch(widget.chat.pro.select((chat) => chat.numUnread.toString())),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
