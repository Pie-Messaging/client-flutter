import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/components/chat_detail_page.dart';
import 'package:pie/components/error.dart';
import 'package:pie/components/util.dart';
import 'package:pie/entities/chat.dart';
import 'package:pie/entities/file.dart';
import 'package:pie/entities/message.dart';
import 'package:pie/entities/user.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/lib/log.dart';
import 'package:pie/lib/time.dart';
import 'package:pie/protobuf/core.pb.dart' as pb;

class ChatPage extends ConsumerStatefulWidget {
  final Chat chat;

  const ChatPage(this.chat, {Key? key}) : super(key: key);

  @override
  createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  void initState() {
    super.initState();
    widget.chat.user!.ensureSession(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 0,
        title: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => tapFeedback(context, Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailPage(widget.chat)))),
          child: SizedBox(
            height: 70,
            child: Row(
              children: [
                Hero(
                  tag: 'user_avatar',
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: ref.watch(widget.chat.user!.pro.select((user) => user.hasAvatar))
                        ? Image.file(File(widget.chat.user!.avatarPath)).image
                        : Image.asset('assets/icon/icon.png', width: 50).image,
                  ),
                ),
                const SizedBox(width: 9),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'user_name',
                      child: Text(
                        ref.watch(widget.chat.user!.pro.select((user) => user.contactName.isNotEmpty ? user.contactName : user.name)),
                        style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                      ),
                    ),
                    if (ref.watch(widget.chat.user!.pro.select((user) => user.state)) == UserState.selfAddingContact)
                      Text('已向对方发送联系人添加请求', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
                    if (ref.watch(widget.chat.user!.pro.select((user) => user.state)) == UserState.peerAddingContact)
                      Text('对方请求添加你为联系人', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: (ref.watch(widget.chat.user!.pro.select((user) => user.state)) != UserState.peerAddingContact)
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(icon: const Icon(Icons.block), label: const Text('屏蔽此用户...'), onPressed: () {}),
                      TextButton.icon(
                        icon: const Icon(Icons.person_add),
                        label: const Text('同意添加联系人'),
                        onPressed: () => widget.chat.user!.approvalContact(0),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      body: Column(
        children: [
          Expanded(child: MessageList(widget.chat)),
          MessageInput(widget.chat),
        ],
      ),
    );
  }
}

class MessageList extends ConsumerStatefulWidget {
  final Chat chat;

  const MessageList(this.chat, {Key? key}) : super(key: key);

  @override
  createState() => _MessageListState();
}

class _MessageListState extends ConsumerState<MessageList> {
  late final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    loadMessages();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future(() => _controller.jumpTo(_controller.position.maxScrollExtent));
    return ListView.builder(
      key: PageStorageKey('message_list_${widget.chat.user!.id}'),
      controller: _controller,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: ref.watch(widget.chat.messagesPro).length,
      itemBuilder: (context, index) => MessageTile(widget.chat.messages[index]),
    );
  }

  _scrollListener() {
    logger.d('chat page controller.position.extentBefore: ${_controller.position.extentBefore}');
    if (_controller.position.extentBefore < 1000) {
      loadMessages();
    }
  }

  Future loadMessages() async {
    _controller.removeListener(_scrollListener);
    final len = await widget.chat.loadMoreMessages();
    if (len == numMessageLoad) {
      _controller.addListener(_scrollListener);
    }
  }
}

class MessageTile extends ConsumerWidget {
  final Message message;

  const MessageTile(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSendFromMe = message.senderID == message.chat.account.id;
    // use task to avoid changing state when building
    Future(() => message.chat.setMessageRead(message));
    final isSysMsg = message.isSysMsg;
    var row = [
      Flexible(
        child: Container(
          padding: isSysMsg ? const EdgeInsets.symmetric(vertical: 3, horizontal: 4) : const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSendFromMe
                ? Theme.of(context).primaryColor
                : isSysMsg
                    ? Colors.grey.shade400
                    : chatTileColor,
          ),
          child: Column(
            children: [
              for (final file in ref.watch(message.pro.select((msg) => msg.files)))
                ref.watch(file.loadingPro).when(
                      loading: () => const CircularProgressIndicator(),
                      error: (e, _) => CenterError(e),
                      data: (_) => Image.file(
                        File(file.path),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                      ),
                    ),
              Text(
                ref.watch(message.pro.select((message) => message.content)),
                style: TextStyle(fontSize: isSysMsg ? 13 : 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      const VerticalDivider(width: 8),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            formatTime(ref.watch(message.pro.select((message) => message.time))),
            style: TextStyle(fontSize: 10, color: Theme.of(context).hintColor),
          ),
        ],
      ),
    ];
    if (isSendFromMe) row = row.reversed.toList();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        mainAxisAlignment: isSendFromMe
            ? MainAxisAlignment.end
            : isSysMsg
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
        children: row,
      ),
    );
  }
}

class MessageInput extends ConsumerStatefulWidget {
  final Chat chat;

  const MessageInput(this.chat, {Key? key}) : super(key: key);

  @override
  createState() => _MessageInputState();
}

class _MessageInputState extends ConsumerState<MessageInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              scrollPhysics: const AlwaysScrollableScrollPhysics(),
              minLines: 1,
              maxLines: 10,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: '消息',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: () => pickFileAndSendMessage(_controller.text),
          ),
          const VerticalDivider(width: 8),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => sendMessage(_controller.text),
            ),
          ),
        ],
      ),
    );
  }

  pickFileAndSendMessage(String content) async {
    late final FilePickerResult? results;
    try {
      results = await FilePicker.platform.pickFiles(type: FileType.any, allowMultiple: true, withReadStream: true);
    } on PlatformException catch (e) {
      logger.d('Failed to pick file: $e');
      return;
    }
    if (results == null || results.files.isEmpty) return;
    _controller.clear();
    final user = widget.chat.user!;
    final message = Message(widget.chat.account, widget.chat, ID.generate(), DateTime.now(), content, senderID: widget.chat.account.id, isRead: true)
      ..files.addAll(results.files.map((file) => MsgFile(widget.chat.account, MsgFileType.unknown)..complete(file.path)));
    widget.chat.addMessage(message);
    await Future.wait([
      () async {
        await user.loadSession.future;
        final stream = await user.session!.sendMessage(
          pb.NetMessage(
            sendMessageReq: pb.SendMessageReq(
              message: pb.Message(
                id: message.id.toIntList(),
                content: content,
                files: [
                  for (final file in results!.files)
                    pb.File(
                      size: Int64(file.size),
                    ),
                ],
              ),
            ),
          ),
          sendMsgTimeout,
        );
        await stream.recvMessage(0);
        stream.close();
      }(),
      () async {
        for (var i = 0; i < results!.files.length; i++) {
          final file = results.files[i];
          final stream = await user.session!.openStream();
          await stream.sendMessage(
            pb.NetMessage(
              sendFileReq: pb.SendFileReq(
                messageId: message.id.toIntList(),
                index: i,
                size: Int64(file.size),
              ),
            ),
            sendMsgTimeout,
          );
          await for (final block in file.readStream!) {
            await stream.sendData(block, sendMsgTimeout);
          }
          final msgFile = message.files[i];
          msgFile.id = ID.generate(); // TODO: calculate id
          () async {
            // final newPath = join(widget.chat.user.filesDir, msgFile.id.toHexStr());
            // await File(msgFile.path).copy(newPath);
            // msgFile.complete(newPath);
          }();
        }
        await widget.chat.account.db.transaction((txn) async {
          // TODO: save message first
          await message.save(txn);
          for (final file in message.files) {
            await file.save(txn);
            // await MsgFileAss(widget.chat.user, message.id, file.id).save(txn);
          }
        });
      }(),
    ], eagerError: true);
  }

  sendMessage(String content) async {
    _controller.clear();
    final user = widget.chat.user!;
    final id = ID.generate();
    final message = Message(widget.chat.account, widget.chat, id, DateTime.now(), content, senderID: widget.chat.account.id, isRead: true);
    widget.chat.addMessage(message);
    await Future.wait([
      message.save(),
      () async {
        await user.loadSession.future;
        final stream = await user.session!.sendMessage(
          pb.NetMessage(
            sendMessageReq: pb.SendMessageReq(
              message: pb.Message(
                id: id.toIntList(),
                content: content,
              ),
            ),
          ),
          0,
        );
        await stream.recvMessage(0);
        stream.close();
      }(),
    ], eagerError: true);
  }

// ID hashFile(Stream<List<int>> stream) {}
}
