///
import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use resourceTypeDescriptor instead')
const ResourceType$json = const {
  '1': 'ResourceType',
  '2': const [
    const {'1': 'USER', '2': 0},
  ],
};

/// Descriptor for `ResourceType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List resourceTypeDescriptor = $convert.base64Decode('CgxSZXNvdXJjZVR5cGUSCAoEVVNFUhAA');
@$core.Deprecated('Use messageMetaTypeDescriptor instead')
const MessageMetaType$json = const {
  '1': 'MessageMetaType',
  '2': const [
    const {'1': 'MARKDOWN', '2': 0},
    const {'1': 'BOLD', '2': 1},
    const {'1': 'ITALIC', '2': 2},
    const {'1': 'UNDERLINE', '2': 3},
    const {'1': 'STRIKE', '2': 4},
    const {'1': 'CODE', '2': 5},
    const {'1': 'LINK', '2': 6},
  ],
};

/// Descriptor for `MessageMetaType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageMetaTypeDescriptor = $convert.base64Decode(
    'Cg9NZXNzYWdlTWV0YVR5cGUSDAoITUFSS0RPV04QABIICgRCT0xEEAESCgoGSVRBTElDEAISDQoJVU5ERVJMSU5FEAMSCgoGU1RSSUtFEAQSCAoEQ09ERRAFEggKBExJTksQBg==');
@$core.Deprecated('Use fileTypeDescriptor instead')
const FileType$json = const {
  '1': 'FileType',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'IMAGE', '2': 1},
    const {'1': 'AUDIO', '2': 2},
    const {'1': 'VIDEO', '2': 3},
    const {'1': 'TEXT', '2': 4},
  ],
};

/// Descriptor for `FileType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fileTypeDescriptor =
    $convert.base64Decode('CghGaWxlVHlwZRILCgdVTktOT1dOEAASCQoFSU1BR0UQARIJCgVBVURJTxACEgkKBVZJREVPEAMSCAoEVEVYVBAE');
@$core.Deprecated('Use statusDescriptor instead')
const Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'ALREADY_DONE', '2': 1},
    const {'1': 'NOT_FOUND', '2': 2},
    const {'1': 'USER_REJECTED', '2': 3},
    const {'1': 'CERT_ERROR', '2': 4},
    const {'1': 'TOO_MANY_REQUESTS', '2': 5},
    const {'1': 'INTERNAL_ERROR', '2': 6},
  ],
};

/// Descriptor for `Status`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List statusDescriptor = $convert.base64Decode(
    'CgZTdGF0dXMSBgoCT0sQABIQCgxBTFJFQURZX0RPTkUQARINCglOT1RfRk9VTkQQAhIRCg1VU0VSX1JFSkVDVEVEEAMSDgoKQ0VSVF9FUlJPUhAEEhUKEVRPT19NQU5ZX1JFUVVFU1RTEAUSEgoOSU5URVJOQUxfRVJST1IQBg==');
@$core.Deprecated('Use getAddrReqDescriptor instead')
const GetAddrReq$json = const {
  '1': 'GetAddrReq',
};

/// Descriptor for `GetAddrReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAddrReqDescriptor = $convert.base64Decode('CgpHZXRBZGRyUmVx');
@$core.Deprecated('Use getAddrResDescriptor instead')
const GetAddrRes$json = const {
  '1': 'GetAddrRes',
  '2': const [
    const {'1': 'addresses', '3': 1, '4': 3, '5': 9, '10': 'addresses'},
  ],
};

/// Descriptor for `GetAddrRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAddrResDescriptor = $convert.base64Decode('CgpHZXRBZGRyUmVzEhwKCWFkZHJlc3NlcxgBIAMoCVIJYWRkcmVzc2Vz');
@$core.Deprecated('Use findTrackerReqDescriptor instead')
const FindTrackerReq$json = const {
  '1': 'FindTrackerReq',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
  ],
};

/// Descriptor for `FindTrackerReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findTrackerReqDescriptor = $convert.base64Decode('Cg5GaW5kVHJhY2tlclJlcRIOCgJpZBgBIAEoDFICaWQ=');
@$core.Deprecated('Use findTrackerResDescriptor instead')
const FindTrackerRes$json = const {
  '1': 'FindTrackerRes',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.core.Status', '10': 'status'},
    const {'1': 'candidates', '3': 2, '4': 3, '5': 11, '6': '.core.Tracker', '10': 'candidates'},
  ],
};

/// Descriptor for `FindTrackerRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findTrackerResDescriptor = $convert.base64Decode(
    'Cg5GaW5kVHJhY2tlclJlcxIkCgZzdGF0dXMYASABKA4yDC5jb3JlLlN0YXR1c1IGc3RhdHVzEi0KCmNhbmRpZGF0ZXMYAiADKAsyDS5jb3JlLlRyYWNrZXJSCmNhbmRpZGF0ZXM=');
@$core.Deprecated('Use findResourceReqDescriptor instead')
const FindResourceReq$json = const {
  '1': 'FindResourceReq',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.core.ResourceType', '10': 'type'},
  ],
};

/// Descriptor for `FindResourceReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findResourceReqDescriptor =
    $convert.base64Decode('Cg9GaW5kUmVzb3VyY2VSZXESDgoCaWQYASABKAxSAmlkEiYKBHR5cGUYAiABKA4yEi5jb3JlLlJlc291cmNlVHlwZVIEdHlwZQ==');
@$core.Deprecated('Use findResourceResDescriptor instead')
const FindResourceRes$json = const {
  '1': 'FindResourceRes',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.core.Status', '10': 'status'},
    const {'1': 'resource', '3': 2, '4': 1, '5': 11, '6': '.core.Resource', '10': 'resource'},
    const {'1': 'candidate_trackers', '3': 3, '4': 3, '5': 11, '6': '.core.Tracker', '10': 'candidateTrackers'},
  ],
};

/// Descriptor for `FindResourceRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findResourceResDescriptor = $convert.base64Decode(
    'Cg9GaW5kUmVzb3VyY2VSZXMSJAoGc3RhdHVzGAEgASgOMgwuY29yZS5TdGF0dXNSBnN0YXR1cxIqCghyZXNvdXJjZRgCIAEoCzIOLmNvcmUuUmVzb3VyY2VSCHJlc291cmNlEjwKEmNhbmRpZGF0ZV90cmFja2VycxgDIAMoCzINLmNvcmUuVHJhY2tlclIRY2FuZGlkYXRlVHJhY2tlcnM=');
@$core.Deprecated('Use putResourceReqDescriptor instead')
const PutResourceReq$json = const {
  '1': 'PutResourceReq',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.core.ResourceType', '10': 'type'},
    const {'1': 'resource', '3': 2, '4': 1, '5': 11, '6': '.core.Resource', '10': 'resource'},
  ],
};

/// Descriptor for `PutResourceReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List putResourceReqDescriptor = $convert.base64Decode(
    'Cg5QdXRSZXNvdXJjZVJlcRImCgR0eXBlGAEgASgOMhIuY29yZS5SZXNvdXJjZVR5cGVSBHR5cGUSKgoIcmVzb3VyY2UYAiABKAsyDi5jb3JlLlJlc291cmNlUghyZXNvdXJjZQ==');
@$core.Deprecated('Use putResourceResDescriptor instead')
const PutResourceRes$json = const {
  '1': 'PutResourceRes',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.core.Status', '10': 'status'},
  ],
};

/// Descriptor for `PutResourceRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List putResourceResDescriptor =
    $convert.base64Decode('Cg5QdXRSZXNvdXJjZVJlcxIkCgZzdGF0dXMYASABKA4yDC5jb3JlLlN0YXR1c1IGc3RhdHVz');
@$core.Deprecated('Use clientCertReqDescriptor instead')
const ClientCertReq$json = const {
  '1': 'ClientCertReq',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    const {'1': 'cert_der', '3': 2, '4': 1, '5': 12, '10': 'certDer'},
    const {'1': 'server_cert_sign', '3': 3, '4': 1, '5': 12, '10': 'serverCertSign'},
  ],
};

/// Descriptor for `ClientCertReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientCertReqDescriptor = $convert.base64Decode(
    'Cg1DbGllbnRDZXJ0UmVxEg4KAmlkGAEgASgMUgJpZBIZCghjZXJ0X2RlchgCIAEoDFIHY2VydERlchIoChBzZXJ2ZXJfY2VydF9zaWduGAMgASgMUg5zZXJ2ZXJDZXJ0U2lnbg==');
@$core.Deprecated('Use addContactReqDescriptor instead')
const AddContactReq$json = const {
  '1': 'AddContactReq',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.core.User', '10': 'user'},
  ],
};

/// Descriptor for `AddContactReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addContactReqDescriptor =
    $convert.base64Decode('Cg1BZGRDb250YWN0UmVxEhQKBXRva2VuGAEgASgJUgV0b2tlbhIeCgR1c2VyGAIgASgLMgouY29yZS5Vc2VyUgR1c2Vy');
@$core.Deprecated('Use addContactResDescriptor instead')
const AddContactRes$json = const {
  '1': 'AddContactRes',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.core.Status', '10': 'status'},
  ],
};

/// Descriptor for `AddContactRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addContactResDescriptor =
    $convert.base64Decode('Cg1BZGRDb250YWN0UmVzEiQKBnN0YXR1cxgBIAEoDjIMLmNvcmUuU3RhdHVzUgZzdGF0dXM=');
@$core.Deprecated('Use approvalContactAddingReqDescriptor instead')
const ApprovalContactAddingReq$json = const {
  '1': 'ApprovalContactAddingReq',
};

/// Descriptor for `ApprovalContactAddingReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approvalContactAddingReqDescriptor = $convert.base64Decode('ChZBY2NlcHRDb250YWN0QWRkaW5nUmVx');
@$core.Deprecated('Use approvalContactAddingResDescriptor instead')
const ApprovalContactAddingRes$json = const {
  '1': 'ApprovalContactAddingRes',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.core.Status', '10': 'status'},
  ],
};

/// Descriptor for `ApprovalContactAddingRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approvalContactAddingResDescriptor =
    $convert.base64Decode('ChZBY2NlcHRDb250YWN0QWRkaW5nUmVzEiQKBnN0YXR1cxgBIAEoDjIMLmNvcmUuU3RhdHVzUgZzdGF0dXM=');
@$core.Deprecated('Use sendMessageReqDescriptor instead')
const SendMessageReq$json = const {
  '1': 'SendMessageReq',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 11, '6': '.core.Message', '10': 'message'},
  ],
};

/// Descriptor for `SendMessageReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageReqDescriptor =
    $convert.base64Decode('Cg5TZW5kTWVzc2FnZVJlcRInCgdtZXNzYWdlGAEgASgLMg0uY29yZS5NZXNzYWdlUgdtZXNzYWdl');
@$core.Deprecated('Use sendMessageResDescriptor instead')
const SendMessageRes$json = const {
  '1': 'SendMessageRes',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.core.Status', '10': 'status'},
  ],
};

/// Descriptor for `SendMessageRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageResDescriptor =
    $convert.base64Decode('Cg5TZW5kTWVzc2FnZVJlcxIkCgZzdGF0dXMYASABKA4yDC5jb3JlLlN0YXR1c1IGc3RhdHVz');
@$core.Deprecated('Use getFileReqDescriptor instead')
const GetFileReq$json = const {
  '1': 'GetFileReq',
  '2': const [
    const {'1': 'file_id_list', '3': 1, '4': 3, '5': 12, '10': 'fileIdList'},
  ],
};

/// Descriptor for `GetFileReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFileReqDescriptor = $convert.base64Decode('CgpHZXRGaWxlUmVxEiAKDGZpbGVfaWRfbGlzdBgBIAMoDFIKZmlsZUlkTGlzdA==');
@$core.Deprecated('Use getFileResDescriptor instead')
const GetFileRes$json = const {
  '1': 'GetFileRes',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.core.Status', '10': 'status'},
  ],
};

/// Descriptor for `GetFileRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFileResDescriptor = $convert.base64Decode('CgpHZXRGaWxlUmVzEiQKBnN0YXR1cxgBIAEoDjIMLmNvcmUuU3RhdHVzUgZzdGF0dXM=');
@$core.Deprecated('Use sendFileReqDescriptor instead')
const SendFileReq$json = const {
  '1': 'SendFileReq',
  '2': const [
    const {'1': 'message_id', '3': 1, '4': 1, '5': 12, '10': 'messageId'},
    const {'1': 'index', '3': 2, '4': 1, '5': 5, '10': 'index'},
    const {'1': 'file_id', '3': 3, '4': 1, '5': 12, '10': 'fileId'},
    const {'1': 'suffix', '3': 4, '4': 1, '5': 9, '10': 'suffix'},
    const {'1': 'size', '3': 5, '4': 1, '5': 3, '10': 'size'},
  ],
};

/// Descriptor for `SendFileReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendFileReqDescriptor = $convert.base64Decode(
    'CgtTZW5kRmlsZVJlcRIdCgptZXNzYWdlX2lkGAEgASgMUgltZXNzYWdlSWQSFAoFaW5kZXgYAiABKAVSBWluZGV4EhcKB2ZpbGVfaWQYAyABKAxSBmZpbGVJZBIWCgZzdWZmaXgYBCABKAlSBnN1ZmZpeBISCgRzaXplGAUgASgDUgRzaXpl');
@$core.Deprecated('Use sendFileResDescriptor instead')
const SendFileRes$json = const {
  '1': 'SendFileRes',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.core.Status', '10': 'status'},
  ],
};

/// Descriptor for `SendFileRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendFileResDescriptor = $convert.base64Decode('CgtTZW5kRmlsZVJlcxIkCgZzdGF0dXMYASABKA4yDC5jb3JlLlN0YXR1c1IGc3RhdHVz');
@$core.Deprecated('Use finishSendFileReqDescriptor instead')
const FinishSendFileReq$json = const {
  '1': 'FinishSendFileReq',
  '2': const [
    const {'1': 'file_id', '3': 1, '4': 1, '5': 12, '10': 'fileId'},
  ],
};

/// Descriptor for `FinishSendFileReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finishSendFileReqDescriptor = $convert.base64Decode('ChFGaW5pc2hTZW5kRmlsZVJlcRIXCgdmaWxlX2lkGAEgASgMUgZmaWxlSWQ=');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'bio', '3': 4, '4': 1, '5': 9, '10': 'bio'},
    const {'1': 'avatar', '3': 5, '4': 1, '5': 12, '10': 'avatar'},
    const {'1': 'cert_der', '3': 6, '4': 1, '5': 12, '10': 'certDer'},
    const {'1': 'addresses', '3': 7, '4': 3, '5': 9, '10': 'addresses'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgMUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBWVtYWlsGAMgASgJUgVlbWFpbBIQCgNiaW8YBCABKAlSA2JpbxIWCgZhdmF0YXIYBSABKAxSBmF2YXRhchIZCghjZXJ0X2RlchgGIAEoDFIHY2VydERlchIcCglhZGRyZXNzZXMYByADKAlSCWFkZHJlc3Nlcw==');
@$core.Deprecated('Use trackerDescriptor instead')
const Tracker$json = const {
  '1': 'Tracker',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    const {'1': 'addr', '3': 2, '4': 3, '5': 9, '10': 'addr'},
  ],
};

/// Descriptor for `Tracker`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackerDescriptor = $convert.base64Decode('CgdUcmFja2VyEg4KAmlkGAEgASgMUgJpZBISCgRhZGRyGAIgAygJUgRhZGRy');
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'meta_list', '3': 3, '4': 3, '5': 11, '6': '.core.MessageMeta', '10': 'metaList'},
    const {'1': 'files', '3': 4, '4': 3, '5': 11, '6': '.core.File', '10': 'files'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEg4KAmlkGAEgASgMUgJpZBIYCgdjb250ZW50GAIgASgJUgdjb250ZW50Ei4KCW1ldGFfbGlzdBgDIAMoCzIRLmNvcmUuTWVzc2FnZU1ldGFSCG1ldGFMaXN0EiAKBWZpbGVzGAQgAygLMgouY29yZS5GaWxlUgVmaWxlcw==');
@$core.Deprecated('Use messageMetaDescriptor instead')
const MessageMeta$json = const {
  '1': 'MessageMeta',
  '2': const [
    const {'1': 'start_offset', '3': 1, '4': 1, '5': 5, '10': 'startOffset'},
    const {'1': 'end_offset', '3': 2, '4': 1, '5': 5, '10': 'endOffset'},
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.core.MessageMetaType', '10': 'type'},
  ],
};

/// Descriptor for `MessageMeta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageMetaDescriptor = $convert.base64Decode(
    'CgtNZXNzYWdlTWV0YRIhCgxzdGFydF9vZmZzZXQYASABKAVSC3N0YXJ0T2Zmc2V0Eh0KCmVuZF9vZmZzZXQYAiABKAVSCWVuZE9mZnNldBIpCgR0eXBlGAMgASgOMhUuY29yZS5NZXNzYWdlTWV0YVR5cGVSBHR5cGU=');
@$core.Deprecated('Use fileDescriptor instead')
const File$json = const {
  '1': 'File',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.core.FileType', '10': 'type'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'size', '3': 4, '4': 1, '5': 3, '10': 'size'},
  ],
};

/// Descriptor for `File`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileDescriptor = $convert.base64Decode(
    'CgRGaWxlEg4KAmlkGAEgASgMUgJpZBIiCgR0eXBlGAIgASgOMg4uY29yZS5GaWxlVHlwZVIEdHlwZRISCgRuYW1lGAMgASgJUgRuYW1lEhIKBHNpemUYBCABKANSBHNpemU=');
@$core.Deprecated('Use resourceDescriptor instead')
const Resource$json = const {
  '1': 'Resource',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.core.User', '9': 0, '10': 'user'},
  ],
  '8': const [
    const {'1': 'resource'},
  ],
};

/// Descriptor for `Resource`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourceDescriptor =
    $convert.base64Decode('CghSZXNvdXJjZRIgCgR1c2VyGAEgASgLMgouY29yZS5Vc2VySABSBHVzZXJCCgoIcmVzb3VyY2U=');
@$core.Deprecated('Use netMessageDescriptor instead')
const NetMessage$json = const {
  '1': 'NetMessage',
  '2': const [
    const {'1': 'get_addr_req', '3': 1, '4': 1, '5': 11, '6': '.core.GetAddrReq', '9': 0, '10': 'getAddrReq'},
    const {'1': 'get_addr_res', '3': 2, '4': 1, '5': 11, '6': '.core.GetAddrRes', '9': 0, '10': 'getAddrRes'},
    const {'1': 'find_tracker_req', '3': 3, '4': 1, '5': 11, '6': '.core.FindTrackerReq', '9': 0, '10': 'findTrackerReq'},
    const {'1': 'find_tracker_res', '3': 4, '4': 1, '5': 11, '6': '.core.FindTrackerRes', '9': 0, '10': 'findTrackerRes'},
    const {'1': 'find_resource_req', '3': 5, '4': 1, '5': 11, '6': '.core.FindResourceReq', '9': 0, '10': 'findResourceReq'},
    const {'1': 'find_resource_res', '3': 6, '4': 1, '5': 11, '6': '.core.FindResourceRes', '9': 0, '10': 'findResourceRes'},
    const {'1': 'put_resource_req', '3': 7, '4': 1, '5': 11, '6': '.core.PutResourceReq', '9': 0, '10': 'putResourceReq'},
    const {'1': 'put_resource_res', '3': 8, '4': 1, '5': 11, '6': '.core.PutResourceRes', '9': 0, '10': 'putResourceRes'},
    const {'1': 'client_cert_req', '3': 9, '4': 1, '5': 11, '6': '.core.ClientCertReq', '9': 0, '10': 'clientCertReq'},
    const {'1': 'add_contact_req', '3': 10, '4': 1, '5': 11, '6': '.core.AddContactReq', '9': 0, '10': 'addContactReq'},
    const {'1': 'add_contact_res', '3': 11, '4': 1, '5': 11, '6': '.core.AddContactRes', '9': 0, '10': 'addContactRes'},
    const {
      '1': 'accept_contact_adding_req',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.core.ApprovalContactAddingReq',
      '9': 0,
      '10': 'approvalContactAddingReq'
    },
    const {
      '1': 'accept_contact_adding_res',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.core.ApprovalContactAddingRes',
      '9': 0,
      '10': 'approvalContactAddingRes'
    },
    const {'1': 'send_message_req', '3': 14, '4': 1, '5': 11, '6': '.core.SendMessageReq', '9': 0, '10': 'sendMessageReq'},
    const {'1': 'send_message_res', '3': 15, '4': 1, '5': 11, '6': '.core.SendMessageRes', '9': 0, '10': 'sendMessageRes'},
    const {'1': 'get_file_req', '3': 16, '4': 1, '5': 11, '6': '.core.GetFileReq', '9': 0, '10': 'getFileReq'},
    const {'1': 'get_file_res', '3': 17, '4': 1, '5': 11, '6': '.core.GetFileRes', '9': 0, '10': 'getFileRes'},
    const {'1': 'send_file_req', '3': 18, '4': 1, '5': 11, '6': '.core.SendFileReq', '9': 0, '10': 'sendFileReq'},
    const {'1': 'send_file_res', '3': 19, '4': 1, '5': 11, '6': '.core.SendFileRes', '9': 0, '10': 'sendFileRes'},
    const {'1': 'finish_send_file_req', '3': 20, '4': 1, '5': 11, '6': '.core.FinishSendFileReq', '9': 0, '10': 'finishSendFileReq'},
  ],
  '8': const [
    const {'1': 'body'},
  ],
};

/// Descriptor for `NetMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List netMessageDescriptor = $convert.base64Decode(
    'CgpOZXRNZXNzYWdlEjQKDGdldF9hZGRyX3JlcRgBIAEoCzIQLmNvcmUuR2V0QWRkclJlcUgAUgpnZXRBZGRyUmVxEjQKDGdldF9hZGRyX3JlcxgCIAEoCzIQLmNvcmUuR2V0QWRkclJlc0gAUgpnZXRBZGRyUmVzEkAKEGZpbmRfdHJhY2tlcl9yZXEYAyABKAsyFC5jb3JlLkZpbmRUcmFja2VyUmVxSABSDmZpbmRUcmFja2VyUmVxEkAKEGZpbmRfdHJhY2tlcl9yZXMYBCABKAsyFC5jb3JlLkZpbmRUcmFja2VyUmVzSABSDmZpbmRUcmFja2VyUmVzEkMKEWZpbmRfcmVzb3VyY2VfcmVxGAUgASgLMhUuY29yZS5GaW5kUmVzb3VyY2VSZXFIAFIPZmluZFJlc291cmNlUmVxEkMKEWZpbmRfcmVzb3VyY2VfcmVzGAYgASgLMhUuY29yZS5GaW5kUmVzb3VyY2VSZXNIAFIPZmluZFJlc291cmNlUmVzEkAKEHB1dF9yZXNvdXJjZV9yZXEYByABKAsyFC5jb3JlLlB1dFJlc291cmNlUmVxSABSDnB1dFJlc291cmNlUmVxEkAKEHB1dF9yZXNvdXJjZV9yZXMYCCABKAsyFC5jb3JlLlB1dFJlc291cmNlUmVzSABSDnB1dFJlc291cmNlUmVzEj0KD2NsaWVudF9jZXJ0X3JlcRgJIAEoCzITLmNvcmUuQ2xpZW50Q2VydFJlcUgAUg1jbGllbnRDZXJ0UmVxEj0KD2FkZF9jb250YWN0X3JlcRgKIAEoCzITLmNvcmUuQWRkQ29udGFjdFJlcUgAUg1hZGRDb250YWN0UmVxEj0KD2FkZF9jb250YWN0X3JlcxgLIAEoCzITLmNvcmUuQWRkQ29udGFjdFJlc0gAUg1hZGRDb250YWN0UmVzElkKGWFjY2VwdF9jb250YWN0X2FkZGluZ19yZXEYDCABKAsyHC5jb3JlLkFjY2VwdENvbnRhY3RBZGRpbmdSZXFIAFIWYWNjZXB0Q29udGFjdEFkZGluZ1JlcRJZChlhY2NlcHRfY29udGFjdF9hZGRpbmdfcmVzGA0gASgLMhwuY29yZS5BY2NlcHRDb250YWN0QWRkaW5nUmVzSABSFmFjY2VwdENvbnRhY3RBZGRpbmdSZXMSQAoQc2VuZF9tZXNzYWdlX3JlcRgOIAEoCzIULmNvcmUuU2VuZE1lc3NhZ2VSZXFIAFIOc2VuZE1lc3NhZ2VSZXESQAoQc2VuZF9tZXNzYWdlX3JlcxgPIAEoCzIULmNvcmUuU2VuZE1lc3NhZ2VSZXNIAFIOc2VuZE1lc3NhZ2VSZXMSNAoMZ2V0X2ZpbGVfcmVxGBAgASgLMhAuY29yZS5HZXRGaWxlUmVxSABSCmdldEZpbGVSZXESNAoMZ2V0X2ZpbGVfcmVzGBEgASgLMhAuY29yZS5HZXRGaWxlUmVzSABSCmdldEZpbGVSZXMSNwoNc2VuZF9maWxlX3JlcRgSIAEoCzIRLmNvcmUuU2VuZEZpbGVSZXFIAFILc2VuZEZpbGVSZXESNwoNc2VuZF9maWxlX3JlcxgTIAEoCzIRLmNvcmUuU2VuZEZpbGVSZXNIAFILc2VuZEZpbGVSZXMSSgoUZmluaXNoX3NlbmRfZmlsZV9yZXEYFCABKAsyFy5jb3JlLkZpbmlzaFNlbmRGaWxlUmVxSABSEWZpbmlzaFNlbmRGaWxlUmVxQgYKBGJvZHk=');
