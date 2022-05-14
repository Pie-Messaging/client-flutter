///
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ResourceType extends $pb.ProtobufEnum {
  static const ResourceType USER = ResourceType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'USER');

  static const $core.List<ResourceType> values = <ResourceType>[
    USER,
  ];

  static final $core.Map<$core.int, ResourceType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ResourceType? valueOf($core.int value) => _byValue[value];

  const ResourceType._($core.int v, $core.String n) : super(v, n);
}

class MessageMetaType extends $pb.ProtobufEnum {
  static const MessageMetaType MARKDOWN = MessageMetaType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MARKDOWN');
  static const MessageMetaType BOLD = MessageMetaType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BOLD');
  static const MessageMetaType ITALIC = MessageMetaType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ITALIC');
  static const MessageMetaType UNDERLINE = MessageMetaType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNDERLINE');
  static const MessageMetaType STRIKE = MessageMetaType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STRIKE');
  static const MessageMetaType CODE = MessageMetaType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CODE');
  static const MessageMetaType LINK = MessageMetaType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LINK');

  static const $core.List<MessageMetaType> values = <MessageMetaType>[
    MARKDOWN,
    BOLD,
    ITALIC,
    UNDERLINE,
    STRIKE,
    CODE,
    LINK,
  ];

  static final $core.Map<$core.int, MessageMetaType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageMetaType? valueOf($core.int value) => _byValue[value];

  const MessageMetaType._($core.int v, $core.String n) : super(v, n);
}

class FileType extends $pb.ProtobufEnum {
  static const FileType UNKNOWN = FileType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const FileType IMAGE = FileType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IMAGE');
  static const FileType AUDIO = FileType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AUDIO');
  static const FileType VIDEO = FileType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO');
  static const FileType TEXT = FileType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEXT');

  static const $core.List<FileType> values = <FileType>[
    UNKNOWN,
    IMAGE,
    AUDIO,
    VIDEO,
    TEXT,
  ];

  static final $core.Map<$core.int, FileType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FileType? valueOf($core.int value) => _byValue[value];

  const FileType._($core.int v, $core.String n) : super(v, n);
}

class Status extends $pb.ProtobufEnum {
  static const Status OK = Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const Status ALREADY_DONE = Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ALREADY_DONE');
  static const Status NOT_FOUND = Status._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOT_FOUND');
  static const Status USER_REJECTED = Status._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'USER_REJECTED');
  static const Status CERT_ERROR = Status._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CERT_ERROR');
  static const Status TOO_MANY_REQUESTS = Status._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TOO_MANY_REQUESTS');
  static const Status INTERNAL_ERROR = Status._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INTERNAL_ERROR');

  static const $core.List<Status> values = <Status>[
    OK,
    ALREADY_DONE,
    NOT_FOUND,
    USER_REJECTED,
    CERT_ERROR,
    TOO_MANY_REQUESTS,
    INTERNAL_ERROR,
  ];

  static final $core.Map<$core.int, Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Status? valueOf($core.int value) => _byValue[value];

  const Status._($core.int v, $core.String n) : super(v, n);
}
