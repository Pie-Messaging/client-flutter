///
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'core.pbenum.dart';

export 'core.pbenum.dart';

class GetAddrReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAddrReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..hasRequiredFields = false;

  GetAddrReq._() : super();
  factory GetAddrReq() => create();
  factory GetAddrReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAddrReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAddrReq clone() => GetAddrReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAddrReq copyWith(void Function(GetAddrReq) updates) =>
      super.copyWith((message) => updates(message as GetAddrReq)) as GetAddrReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAddrReq create() => GetAddrReq._();
  GetAddrReq createEmptyInstance() => create();
  static $pb.PbList<GetAddrReq> createRepeated() => $pb.PbList<GetAddrReq>();
  @$core.pragma('dart2js:noInline')
  static GetAddrReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAddrReq>(create);
  static GetAddrReq? _defaultInstance;
}

class GetAddrRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAddrRes',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addresses')
    ..hasRequiredFields = false;

  GetAddrRes._() : super();
  factory GetAddrRes({
    $core.Iterable<$core.String>? addresses,
  }) {
    final _result = create();
    if (addresses != null) {
      _result.addresses.addAll(addresses);
    }
    return _result;
  }
  factory GetAddrRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAddrRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAddrRes clone() => GetAddrRes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAddrRes copyWith(void Function(GetAddrRes) updates) =>
      super.copyWith((message) => updates(message as GetAddrRes)) as GetAddrRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAddrRes create() => GetAddrRes._();
  GetAddrRes createEmptyInstance() => create();
  static $pb.PbList<GetAddrRes> createRepeated() => $pb.PbList<GetAddrRes>();
  @$core.pragma('dart2js:noInline')
  static GetAddrRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAddrRes>(create);
  static GetAddrRes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get addresses => $_getList(0);
}

class FindTrackerReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FindTrackerReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  FindTrackerReq._() : super();
  factory FindTrackerReq({
    $core.List<$core.int>? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory FindTrackerReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FindTrackerReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FindTrackerReq clone() => FindTrackerReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FindTrackerReq copyWith(void Function(FindTrackerReq) updates) =>
      super.copyWith((message) => updates(message as FindTrackerReq)) as FindTrackerReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FindTrackerReq create() => FindTrackerReq._();
  FindTrackerReq createEmptyInstance() => create();
  static $pb.PbList<FindTrackerReq> createRepeated() => $pb.PbList<FindTrackerReq>();
  @$core.pragma('dart2js:noInline')
  static FindTrackerReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FindTrackerReq>(create);
  static FindTrackerReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class FindTrackerRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FindTrackerRes',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..e<Status>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: Status.OK, valueOf: Status.valueOf, enumValues: Status.values)
    ..pc<Tracker>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'candidates', $pb.PbFieldType.PM,
        subBuilder: Tracker.create)
    ..hasRequiredFields = false;

  FindTrackerRes._() : super();
  factory FindTrackerRes({
    Status? status,
    $core.Iterable<Tracker>? candidates,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (candidates != null) {
      _result.candidates.addAll(candidates);
    }
    return _result;
  }
  factory FindTrackerRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FindTrackerRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FindTrackerRes clone() => FindTrackerRes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FindTrackerRes copyWith(void Function(FindTrackerRes) updates) =>
      super.copyWith((message) => updates(message as FindTrackerRes)) as FindTrackerRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FindTrackerRes create() => FindTrackerRes._();
  FindTrackerRes createEmptyInstance() => create();
  static $pb.PbList<FindTrackerRes> createRepeated() => $pb.PbList<FindTrackerRes>();
  @$core.pragma('dart2js:noInline')
  static FindTrackerRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FindTrackerRes>(create);
  static FindTrackerRes? _defaultInstance;

  @$pb.TagNumber(1)
  Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(Status v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Tracker> get candidates => $_getList(1);
}

class FindResourceReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FindResourceReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OY)
    ..e<ResourceType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: ResourceType.USER, valueOf: ResourceType.valueOf, enumValues: ResourceType.values)
    ..hasRequiredFields = false;

  FindResourceReq._() : super();
  factory FindResourceReq({
    $core.List<$core.int>? id,
    ResourceType? type,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory FindResourceReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FindResourceReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FindResourceReq clone() => FindResourceReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FindResourceReq copyWith(void Function(FindResourceReq) updates) =>
      super.copyWith((message) => updates(message as FindResourceReq)) as FindResourceReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FindResourceReq create() => FindResourceReq._();
  FindResourceReq createEmptyInstance() => create();
  static $pb.PbList<FindResourceReq> createRepeated() => $pb.PbList<FindResourceReq>();
  @$core.pragma('dart2js:noInline')
  static FindResourceReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FindResourceReq>(create);
  static FindResourceReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  ResourceType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(ResourceType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
}

class FindResourceRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FindResourceRes',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..e<Status>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: Status.OK, valueOf: Status.valueOf, enumValues: Status.values)
    ..aOM<Resource>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resource', subBuilder: Resource.create)
    ..pc<Tracker>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'candidateTrackers', $pb.PbFieldType.PM,
        subBuilder: Tracker.create)
    ..hasRequiredFields = false;

  FindResourceRes._() : super();
  factory FindResourceRes({
    Status? status,
    Resource? resource,
    $core.Iterable<Tracker>? candidateTrackers,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (resource != null) {
      _result.resource = resource;
    }
    if (candidateTrackers != null) {
      _result.candidateTrackers.addAll(candidateTrackers);
    }
    return _result;
  }
  factory FindResourceRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FindResourceRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FindResourceRes clone() => FindResourceRes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FindResourceRes copyWith(void Function(FindResourceRes) updates) =>
      super.copyWith((message) => updates(message as FindResourceRes)) as FindResourceRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FindResourceRes create() => FindResourceRes._();
  FindResourceRes createEmptyInstance() => create();
  static $pb.PbList<FindResourceRes> createRepeated() => $pb.PbList<FindResourceRes>();
  @$core.pragma('dart2js:noInline')
  static FindResourceRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FindResourceRes>(create);
  static FindResourceRes? _defaultInstance;

  @$pb.TagNumber(1)
  Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(Status v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  Resource get resource => $_getN(1);
  @$pb.TagNumber(2)
  set resource(Resource v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasResource() => $_has(1);
  @$pb.TagNumber(2)
  void clearResource() => clearField(2);
  @$pb.TagNumber(2)
  Resource ensureResource() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<Tracker> get candidateTrackers => $_getList(2);
}

class PutResourceReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PutResourceReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..e<ResourceType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: ResourceType.USER, valueOf: ResourceType.valueOf, enumValues: ResourceType.values)
    ..aOM<Resource>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resource', subBuilder: Resource.create)
    ..hasRequiredFields = false;

  PutResourceReq._() : super();
  factory PutResourceReq({
    ResourceType? type,
    Resource? resource,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (resource != null) {
      _result.resource = resource;
    }
    return _result;
  }
  factory PutResourceReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PutResourceReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PutResourceReq clone() => PutResourceReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PutResourceReq copyWith(void Function(PutResourceReq) updates) =>
      super.copyWith((message) => updates(message as PutResourceReq)) as PutResourceReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PutResourceReq create() => PutResourceReq._();
  PutResourceReq createEmptyInstance() => create();
  static $pb.PbList<PutResourceReq> createRepeated() => $pb.PbList<PutResourceReq>();
  @$core.pragma('dart2js:noInline')
  static PutResourceReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PutResourceReq>(create);
  static PutResourceReq? _defaultInstance;

  @$pb.TagNumber(1)
  ResourceType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(ResourceType v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  Resource get resource => $_getN(1);
  @$pb.TagNumber(2)
  set resource(Resource v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasResource() => $_has(1);
  @$pb.TagNumber(2)
  void clearResource() => clearField(2);
  @$pb.TagNumber(2)
  Resource ensureResource() => $_ensure(1);
}

class PutResourceRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PutResourceRes',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..e<Status>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: Status.OK, valueOf: Status.valueOf, enumValues: Status.values)
    ..hasRequiredFields = false;

  PutResourceRes._() : super();
  factory PutResourceRes({
    Status? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory PutResourceRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PutResourceRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PutResourceRes clone() => PutResourceRes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PutResourceRes copyWith(void Function(PutResourceRes) updates) =>
      super.copyWith((message) => updates(message as PutResourceRes)) as PutResourceRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PutResourceRes create() => PutResourceRes._();
  PutResourceRes createEmptyInstance() => create();
  static $pb.PbList<PutResourceRes> createRepeated() => $pb.PbList<PutResourceRes>();
  @$core.pragma('dart2js:noInline')
  static PutResourceRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PutResourceRes>(create);
  static PutResourceRes? _defaultInstance;

  @$pb.TagNumber(1)
  Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(Status v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class ClientCertReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClientCertReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'certDer', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serverCertSign', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  ClientCertReq._() : super();
  factory ClientCertReq({
    $core.List<$core.int>? id,
    $core.List<$core.int>? certDer,
    $core.List<$core.int>? serverCertSign,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (certDer != null) {
      _result.certDer = certDer;
    }
    if (serverCertSign != null) {
      _result.serverCertSign = serverCertSign;
    }
    return _result;
  }
  factory ClientCertReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ClientCertReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ClientCertReq clone() => ClientCertReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ClientCertReq copyWith(void Function(ClientCertReq) updates) =>
      super.copyWith((message) => updates(message as ClientCertReq)) as ClientCertReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClientCertReq create() => ClientCertReq._();
  ClientCertReq createEmptyInstance() => create();
  static $pb.PbList<ClientCertReq> createRepeated() => $pb.PbList<ClientCertReq>();
  @$core.pragma('dart2js:noInline')
  static ClientCertReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientCertReq>(create);
  static ClientCertReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get certDer => $_getN(1);
  @$pb.TagNumber(2)
  set certDer($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCertDer() => $_has(1);
  @$pb.TagNumber(2)
  void clearCertDer() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get serverCertSign => $_getN(2);
  @$pb.TagNumber(3)
  set serverCertSign($core.List<$core.int> v) {
    $_setBytes(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasServerCertSign() => $_has(2);
  @$pb.TagNumber(3)
  void clearServerCertSign() => clearField(3);
}

class AddContactReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddContactReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOM<User>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  AddContactReq._() : super();
  factory AddContactReq({
    $core.String? token,
    User? user,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory AddContactReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AddContactReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AddContactReq clone() => AddContactReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AddContactReq copyWith(void Function(AddContactReq) updates) =>
      super.copyWith((message) => updates(message as AddContactReq)) as AddContactReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddContactReq create() => AddContactReq._();
  AddContactReq createEmptyInstance() => create();
  static $pb.PbList<AddContactReq> createRepeated() => $pb.PbList<AddContactReq>();
  @$core.pragma('dart2js:noInline')
  static AddContactReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddContactReq>(create);
  static AddContactReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  User get user => $_getN(1);
  @$pb.TagNumber(2)
  set user(User v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => clearField(2);
  @$pb.TagNumber(2)
  User ensureUser() => $_ensure(1);
}

class AddContactRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddContactRes',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..e<Status>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: Status.OK, valueOf: Status.valueOf, enumValues: Status.values)
    ..hasRequiredFields = false;

  AddContactRes._() : super();
  factory AddContactRes({
    Status? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory AddContactRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AddContactRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AddContactRes clone() => AddContactRes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AddContactRes copyWith(void Function(AddContactRes) updates) =>
      super.copyWith((message) => updates(message as AddContactRes)) as AddContactRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddContactRes create() => AddContactRes._();
  AddContactRes createEmptyInstance() => create();
  static $pb.PbList<AddContactRes> createRepeated() => $pb.PbList<AddContactRes>();
  @$core.pragma('dart2js:noInline')
  static AddContactRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddContactRes>(create);
  static AddContactRes? _defaultInstance;

  @$pb.TagNumber(1)
  Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(Status v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class ApprovalContactAddingReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ApprovalContactAddingReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..hasRequiredFields = false;

  ApprovalContactAddingReq._() : super();
  factory ApprovalContactAddingReq() => create();
  factory ApprovalContactAddingReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ApprovalContactAddingReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ApprovalContactAddingReq clone() => ApprovalContactAddingReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ApprovalContactAddingReq copyWith(void Function(ApprovalContactAddingReq) updates) =>
      super.copyWith((message) => updates(message as ApprovalContactAddingReq)) as ApprovalContactAddingReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ApprovalContactAddingReq create() => ApprovalContactAddingReq._();
  ApprovalContactAddingReq createEmptyInstance() => create();
  static $pb.PbList<ApprovalContactAddingReq> createRepeated() => $pb.PbList<ApprovalContactAddingReq>();
  @$core.pragma('dart2js:noInline')
  static ApprovalContactAddingReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApprovalContactAddingReq>(create);
  static ApprovalContactAddingReq? _defaultInstance;
}

class ApprovalContactAddingRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ApprovalContactAddingRes',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..e<Status>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: Status.OK, valueOf: Status.valueOf, enumValues: Status.values)
    ..hasRequiredFields = false;

  ApprovalContactAddingRes._() : super();
  factory ApprovalContactAddingRes({
    Status? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory ApprovalContactAddingRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ApprovalContactAddingRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ApprovalContactAddingRes clone() => ApprovalContactAddingRes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ApprovalContactAddingRes copyWith(void Function(ApprovalContactAddingRes) updates) =>
      super.copyWith((message) => updates(message as ApprovalContactAddingRes)) as ApprovalContactAddingRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ApprovalContactAddingRes create() => ApprovalContactAddingRes._();
  ApprovalContactAddingRes createEmptyInstance() => create();
  static $pb.PbList<ApprovalContactAddingRes> createRepeated() => $pb.PbList<ApprovalContactAddingRes>();
  @$core.pragma('dart2js:noInline')
  static ApprovalContactAddingRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApprovalContactAddingRes>(create);
  static ApprovalContactAddingRes? _defaultInstance;

  @$pb.TagNumber(1)
  Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(Status v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class SendMessageReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendMessageReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..aOM<Message>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message', subBuilder: Message.create)
    ..hasRequiredFields = false;

  SendMessageReq._() : super();
  factory SendMessageReq({
    Message? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory SendMessageReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SendMessageReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SendMessageReq clone() => SendMessageReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SendMessageReq copyWith(void Function(SendMessageReq) updates) =>
      super.copyWith((message) => updates(message as SendMessageReq)) as SendMessageReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendMessageReq create() => SendMessageReq._();
  SendMessageReq createEmptyInstance() => create();
  static $pb.PbList<SendMessageReq> createRepeated() => $pb.PbList<SendMessageReq>();
  @$core.pragma('dart2js:noInline')
  static SendMessageReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMessageReq>(create);
  static SendMessageReq? _defaultInstance;

  @$pb.TagNumber(1)
  Message get message => $_getN(0);
  @$pb.TagNumber(1)
  set message(Message v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
  @$pb.TagNumber(1)
  Message ensureMessage() => $_ensure(0);
}

class SendMessageRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendMessageRes',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..e<Status>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: Status.OK, valueOf: Status.valueOf, enumValues: Status.values)
    ..hasRequiredFields = false;

  SendMessageRes._() : super();
  factory SendMessageRes({
    Status? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory SendMessageRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SendMessageRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SendMessageRes clone() => SendMessageRes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SendMessageRes copyWith(void Function(SendMessageRes) updates) =>
      super.copyWith((message) => updates(message as SendMessageRes)) as SendMessageRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendMessageRes create() => SendMessageRes._();
  SendMessageRes createEmptyInstance() => create();
  static $pb.PbList<SendMessageRes> createRepeated() => $pb.PbList<SendMessageRes>();
  @$core.pragma('dart2js:noInline')
  static SendMessageRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMessageRes>(create);
  static SendMessageRes? _defaultInstance;

  @$pb.TagNumber(1)
  Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(Status v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class GetFileReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFileReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileIdList', $pb.PbFieldType.PY)
    ..hasRequiredFields = false;

  GetFileReq._() : super();
  factory GetFileReq({
    $core.Iterable<$core.List<$core.int>>? fileIdList,
  }) {
    final _result = create();
    if (fileIdList != null) {
      _result.fileIdList.addAll(fileIdList);
    }
    return _result;
  }
  factory GetFileReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFileReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetFileReq clone() => GetFileReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetFileReq copyWith(void Function(GetFileReq) updates) =>
      super.copyWith((message) => updates(message as GetFileReq)) as GetFileReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFileReq create() => GetFileReq._();
  GetFileReq createEmptyInstance() => create();
  static $pb.PbList<GetFileReq> createRepeated() => $pb.PbList<GetFileReq>();
  @$core.pragma('dart2js:noInline')
  static GetFileReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFileReq>(create);
  static GetFileReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.List<$core.int>> get fileIdList => $_getList(0);
}

class GetFileRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFileRes',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..e<Status>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: Status.OK, valueOf: Status.valueOf, enumValues: Status.values)
    ..hasRequiredFields = false;

  GetFileRes._() : super();
  factory GetFileRes({
    Status? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory GetFileRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFileRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetFileRes clone() => GetFileRes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetFileRes copyWith(void Function(GetFileRes) updates) =>
      super.copyWith((message) => updates(message as GetFileRes)) as GetFileRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFileRes create() => GetFileRes._();
  GetFileRes createEmptyInstance() => create();
  static $pb.PbList<GetFileRes> createRepeated() => $pb.PbList<GetFileRes>();
  @$core.pragma('dart2js:noInline')
  static GetFileRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFileRes>(create);
  static GetFileRes? _defaultInstance;

  @$pb.TagNumber(1)
  Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(Status v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class SendFileReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendFileReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageId', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'index', $pb.PbFieldType.O3)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileId', $pb.PbFieldType.OY)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'suffix')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'size')
    ..hasRequiredFields = false;

  SendFileReq._() : super();
  factory SendFileReq({
    $core.List<$core.int>? messageId,
    $core.int? index,
    $core.List<$core.int>? fileId,
    $core.String? suffix,
    $fixnum.Int64? size,
  }) {
    final _result = create();
    if (messageId != null) {
      _result.messageId = messageId;
    }
    if (index != null) {
      _result.index = index;
    }
    if (fileId != null) {
      _result.fileId = fileId;
    }
    if (suffix != null) {
      _result.suffix = suffix;
    }
    if (size != null) {
      _result.size = size;
    }
    return _result;
  }
  factory SendFileReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendFileReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SendFileReq clone() => SendFileReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SendFileReq copyWith(void Function(SendFileReq) updates) =>
      super.copyWith((message) => updates(message as SendFileReq)) as SendFileReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendFileReq create() => SendFileReq._();
  SendFileReq createEmptyInstance() => create();
  static $pb.PbList<SendFileReq> createRepeated() => $pb.PbList<SendFileReq>();
  @$core.pragma('dart2js:noInline')
  static SendFileReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendFileReq>(create);
  static SendFileReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get messageId => $_getN(0);
  @$pb.TagNumber(1)
  set messageId($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get index => $_getIZ(1);
  @$pb.TagNumber(2)
  set index($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndex() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get fileId => $_getN(2);
  @$pb.TagNumber(3)
  set fileId($core.List<$core.int> v) {
    $_setBytes(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFileId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get suffix => $_getSZ(3);
  @$pb.TagNumber(4)
  set suffix($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSuffix() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuffix() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get size => $_getI64(4);
  @$pb.TagNumber(5)
  set size($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearSize() => clearField(5);
}

class SendFileRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendFileRes',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..e<Status>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: Status.OK, valueOf: Status.valueOf, enumValues: Status.values)
    ..hasRequiredFields = false;

  SendFileRes._() : super();
  factory SendFileRes({
    Status? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory SendFileRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendFileRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SendFileRes clone() => SendFileRes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SendFileRes copyWith(void Function(SendFileRes) updates) =>
      super.copyWith((message) => updates(message as SendFileRes)) as SendFileRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendFileRes create() => SendFileRes._();
  SendFileRes createEmptyInstance() => create();
  static $pb.PbList<SendFileRes> createRepeated() => $pb.PbList<SendFileRes>();
  @$core.pragma('dart2js:noInline')
  static SendFileRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendFileRes>(create);
  static SendFileRes? _defaultInstance;

  @$pb.TagNumber(1)
  Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(Status v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class FinishSendFileReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FinishSendFileReq',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  FinishSendFileReq._() : super();
  factory FinishSendFileReq({
    $core.List<$core.int>? fileId,
  }) {
    final _result = create();
    if (fileId != null) {
      _result.fileId = fileId;
    }
    return _result;
  }
  factory FinishSendFileReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FinishSendFileReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FinishSendFileReq clone() => FinishSendFileReq()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FinishSendFileReq copyWith(void Function(FinishSendFileReq) updates) =>
      super.copyWith((message) => updates(message as FinishSendFileReq)) as FinishSendFileReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FinishSendFileReq create() => FinishSendFileReq._();
  FinishSendFileReq createEmptyInstance() => create();
  static $pb.PbList<FinishSendFileReq> createRepeated() => $pb.PbList<FinishSendFileReq>();
  @$core.pragma('dart2js:noInline')
  static FinishSendFileReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FinishSendFileReq>(create);
  static FinishSendFileReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get fileId => $_getN(0);
  @$pb.TagNumber(1)
  set fileId($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFileId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileId() => clearField(1);
}

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'User',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OY)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bio')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'avatar', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'certDer', $pb.PbFieldType.OY)
    ..pPS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addresses')
    ..hasRequiredFields = false;

  User._() : super();
  factory User({
    $core.List<$core.int>? id,
    $core.String? name,
    $core.String? email,
    $core.String? bio,
    $core.List<$core.int>? avatar,
    $core.List<$core.int>? certDer,
    $core.Iterable<$core.String>? addresses,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (email != null) {
      _result.email = email;
    }
    if (bio != null) {
      _result.bio = bio;
    }
    if (avatar != null) {
      _result.avatar = avatar;
    }
    if (certDer != null) {
      _result.certDer = certDer;
    }
    if (addresses != null) {
      _result.addresses.addAll(addresses);
    }
    return _result;
  }
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get bio => $_getSZ(3);
  @$pb.TagNumber(4)
  set bio($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasBio() => $_has(3);
  @$pb.TagNumber(4)
  void clearBio() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get avatar => $_getN(4);
  @$pb.TagNumber(5)
  set avatar($core.List<$core.int> v) {
    $_setBytes(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvatar() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get certDer => $_getN(5);
  @$pb.TagNumber(6)
  set certDer($core.List<$core.int> v) {
    $_setBytes(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCertDer() => $_has(5);
  @$pb.TagNumber(6)
  void clearCertDer() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get addresses => $_getList(6);
}

class Tracker extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tracker',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OY)
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addr')
    ..hasRequiredFields = false;

  Tracker._() : super();
  factory Tracker({
    $core.List<$core.int>? id,
    $core.Iterable<$core.String>? addr,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (addr != null) {
      _result.addr.addAll(addr);
    }
    return _result;
  }
  factory Tracker.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tracker.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Tracker clone() => Tracker()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Tracker copyWith(void Function(Tracker) updates) =>
      super.copyWith((message) => updates(message as Tracker)) as Tracker; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tracker create() => Tracker._();
  Tracker createEmptyInstance() => create();
  static $pb.PbList<Tracker> createRepeated() => $pb.PbList<Tracker>();
  @$core.pragma('dart2js:noInline')
  static Tracker getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tracker>(create);
  static Tracker? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get addr => $_getList(1);
}

class Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OY)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..pc<MessageMeta>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metaList', $pb.PbFieldType.PM,
        subBuilder: MessageMeta.create)
    ..pc<File>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'files', $pb.PbFieldType.PM, subBuilder: File.create)
    ..hasRequiredFields = false;

  Message._() : super();
  factory Message({
    $core.List<$core.int>? id,
    $core.String? content,
    $core.Iterable<MessageMeta>? metaList,
    $core.Iterable<File>? files,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (content != null) {
      _result.content = content;
    }
    if (metaList != null) {
      _result.metaList.addAll(metaList);
    }
    if (files != null) {
      _result.files.addAll(files);
    }
    return _result;
  }
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Message copyWith(void Function(Message) updates) =>
      super.copyWith((message) => updates(message as Message)) as Message; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<MessageMeta> get metaList => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<File> get files => $_getList(3);
}

class MessageMeta extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MessageMeta',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startOffset', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endOffset', $pb.PbFieldType.O3)
    ..e<MessageMetaType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: MessageMetaType.MARKDOWN, valueOf: MessageMetaType.valueOf, enumValues: MessageMetaType.values)
    ..hasRequiredFields = false;

  MessageMeta._() : super();
  factory MessageMeta({
    $core.int? startOffset,
    $core.int? endOffset,
    MessageMetaType? type,
  }) {
    final _result = create();
    if (startOffset != null) {
      _result.startOffset = startOffset;
    }
    if (endOffset != null) {
      _result.endOffset = endOffset;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory MessageMeta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MessageMeta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MessageMeta clone() => MessageMeta()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MessageMeta copyWith(void Function(MessageMeta) updates) =>
      super.copyWith((message) => updates(message as MessageMeta)) as MessageMeta; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MessageMeta create() => MessageMeta._();
  MessageMeta createEmptyInstance() => create();
  static $pb.PbList<MessageMeta> createRepeated() => $pb.PbList<MessageMeta>();
  @$core.pragma('dart2js:noInline')
  static MessageMeta getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessageMeta>(create);
  static MessageMeta? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get startOffset => $_getIZ(0);
  @$pb.TagNumber(1)
  set startOffset($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStartOffset() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartOffset() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get endOffset => $_getIZ(1);
  @$pb.TagNumber(2)
  set endOffset($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEndOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndOffset() => clearField(2);

  @$pb.TagNumber(3)
  MessageMetaType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(MessageMetaType v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);
}

class File extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'File',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OY)
    ..e<FileType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: FileType.UNKNOWN, valueOf: FileType.valueOf, enumValues: FileType.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'size')
    ..hasRequiredFields = false;

  File._() : super();
  factory File({
    $core.List<$core.int>? id,
    FileType? type,
    $core.String? name,
    $fixnum.Int64? size,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    if (name != null) {
      _result.name = name;
    }
    if (size != null) {
      _result.size = size;
    }
    return _result;
  }
  factory File.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory File.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  File clone() => File()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  File copyWith(void Function(File) updates) => super.copyWith((message) => updates(message as File)) as File; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static File create() => File._();
  File createEmptyInstance() => create();
  static $pb.PbList<File> createRepeated() => $pb.PbList<File>();
  @$core.pragma('dart2js:noInline')
  static File getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<File>(create);
  static File? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  FileType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(FileType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get size => $_getI64(3);
  @$pb.TagNumber(4)
  set size($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearSize() => clearField(4);
}

enum Resource_Resource { user, notSet }

class Resource extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Resource_Resource> _Resource_ResourceByTag = {1: Resource_Resource.user, 0: Resource_Resource.notSet};
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Resource',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  Resource._() : super();
  factory Resource({
    User? user,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory Resource.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Resource.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Resource clone() => Resource()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Resource copyWith(void Function(Resource) updates) =>
      super.copyWith((message) => updates(message as Resource)) as Resource; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Resource create() => Resource._();
  Resource createEmptyInstance() => create();
  static $pb.PbList<Resource> createRepeated() => $pb.PbList<Resource>();
  @$core.pragma('dart2js:noInline')
  static Resource getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Resource>(create);
  static Resource? _defaultInstance;

  Resource_Resource whichResource() => _Resource_ResourceByTag[$_whichOneof(0)]!;
  void clearResource() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

enum NetMessage_Body {
  getAddrReq,
  getAddrRes,
  findTrackerReq,
  findTrackerRes,
  findResourceReq,
  findResourceRes,
  putResourceReq,
  putResourceRes,
  clientCertReq,
  addContactReq,
  addContactRes,
  approvalContactAddingReq,
  approvalContactAddingRes,
  sendMessageReq,
  sendMessageRes,
  getFileReq,
  getFileRes,
  sendFileReq,
  sendFileRes,
  finishSendFileReq,
  notSet
}

class NetMessage extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, NetMessage_Body> _NetMessage_BodyByTag = {
    1: NetMessage_Body.getAddrReq,
    2: NetMessage_Body.getAddrRes,
    3: NetMessage_Body.findTrackerReq,
    4: NetMessage_Body.findTrackerRes,
    5: NetMessage_Body.findResourceReq,
    6: NetMessage_Body.findResourceRes,
    7: NetMessage_Body.putResourceReq,
    8: NetMessage_Body.putResourceRes,
    9: NetMessage_Body.clientCertReq,
    10: NetMessage_Body.addContactReq,
    11: NetMessage_Body.addContactRes,
    12: NetMessage_Body.approvalContactAddingReq,
    13: NetMessage_Body.approvalContactAddingRes,
    14: NetMessage_Body.sendMessageReq,
    15: NetMessage_Body.sendMessageRes,
    16: NetMessage_Body.getFileReq,
    17: NetMessage_Body.getFileRes,
    18: NetMessage_Body.sendFileReq,
    19: NetMessage_Body.sendFileRes,
    20: NetMessage_Body.finishSendFileReq,
    0: NetMessage_Body.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NetMessage',
      package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'core'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
    ..aOM<GetAddrReq>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'getAddrReq', subBuilder: GetAddrReq.create)
    ..aOM<GetAddrRes>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'getAddrRes', subBuilder: GetAddrRes.create)
    ..aOM<FindTrackerReq>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'findTrackerReq', subBuilder: FindTrackerReq.create)
    ..aOM<FindTrackerRes>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'findTrackerRes', subBuilder: FindTrackerRes.create)
    ..aOM<FindResourceReq>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'findResourceReq',
        subBuilder: FindResourceReq.create)
    ..aOM<FindResourceRes>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'findResourceRes',
        subBuilder: FindResourceRes.create)
    ..aOM<PutResourceReq>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'putResourceReq', subBuilder: PutResourceReq.create)
    ..aOM<PutResourceRes>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'putResourceRes', subBuilder: PutResourceRes.create)
    ..aOM<ClientCertReq>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clientCertReq', subBuilder: ClientCertReq.create)
    ..aOM<AddContactReq>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addContactReq', subBuilder: AddContactReq.create)
    ..aOM<AddContactRes>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addContactRes', subBuilder: AddContactRes.create)
    ..aOM<ApprovalContactAddingReq>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvalContactAddingReq',
        subBuilder: ApprovalContactAddingReq.create)
    ..aOM<ApprovalContactAddingRes>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvalContactAddingRes',
        subBuilder: ApprovalContactAddingRes.create)
    ..aOM<SendMessageReq>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sendMessageReq',
        subBuilder: SendMessageReq.create)
    ..aOM<SendMessageRes>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sendMessageRes',
        subBuilder: SendMessageRes.create)
    ..aOM<GetFileReq>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'getFileReq', subBuilder: GetFileReq.create)
    ..aOM<GetFileRes>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'getFileRes', subBuilder: GetFileRes.create)
    ..aOM<SendFileReq>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sendFileReq', subBuilder: SendFileReq.create)
    ..aOM<SendFileRes>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sendFileRes', subBuilder: SendFileRes.create)
    ..aOM<FinishSendFileReq>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'finishSendFileReq',
        subBuilder: FinishSendFileReq.create)
    ..hasRequiredFields = false;

  NetMessage._() : super();
  factory NetMessage({
    GetAddrReq? getAddrReq,
    GetAddrRes? getAddrRes,
    FindTrackerReq? findTrackerReq,
    FindTrackerRes? findTrackerRes,
    FindResourceReq? findResourceReq,
    FindResourceRes? findResourceRes,
    PutResourceReq? putResourceReq,
    PutResourceRes? putResourceRes,
    ClientCertReq? clientCertReq,
    AddContactReq? addContactReq,
    AddContactRes? addContactRes,
    ApprovalContactAddingReq? approvalContactAddingReq,
    ApprovalContactAddingRes? approvalContactAddingRes,
    SendMessageReq? sendMessageReq,
    SendMessageRes? sendMessageRes,
    GetFileReq? getFileReq,
    GetFileRes? getFileRes,
    SendFileReq? sendFileReq,
    SendFileRes? sendFileRes,
    FinishSendFileReq? finishSendFileReq,
  }) {
    final _result = create();
    if (getAddrReq != null) {
      _result.getAddrReq = getAddrReq;
    }
    if (getAddrRes != null) {
      _result.getAddrRes = getAddrRes;
    }
    if (findTrackerReq != null) {
      _result.findTrackerReq = findTrackerReq;
    }
    if (findTrackerRes != null) {
      _result.findTrackerRes = findTrackerRes;
    }
    if (findResourceReq != null) {
      _result.findResourceReq = findResourceReq;
    }
    if (findResourceRes != null) {
      _result.findResourceRes = findResourceRes;
    }
    if (putResourceReq != null) {
      _result.putResourceReq = putResourceReq;
    }
    if (putResourceRes != null) {
      _result.putResourceRes = putResourceRes;
    }
    if (clientCertReq != null) {
      _result.clientCertReq = clientCertReq;
    }
    if (addContactReq != null) {
      _result.addContactReq = addContactReq;
    }
    if (addContactRes != null) {
      _result.addContactRes = addContactRes;
    }
    if (approvalContactAddingReq != null) {
      _result.approvalContactAddingReq = approvalContactAddingReq;
    }
    if (approvalContactAddingRes != null) {
      _result.approvalContactAddingRes = approvalContactAddingRes;
    }
    if (sendMessageReq != null) {
      _result.sendMessageReq = sendMessageReq;
    }
    if (sendMessageRes != null) {
      _result.sendMessageRes = sendMessageRes;
    }
    if (getFileReq != null) {
      _result.getFileReq = getFileReq;
    }
    if (getFileRes != null) {
      _result.getFileRes = getFileRes;
    }
    if (sendFileReq != null) {
      _result.sendFileReq = sendFileReq;
    }
    if (sendFileRes != null) {
      _result.sendFileRes = sendFileRes;
    }
    if (finishSendFileReq != null) {
      _result.finishSendFileReq = finishSendFileReq;
    }
    return _result;
  }
  factory NetMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NetMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NetMessage clone() => NetMessage()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NetMessage copyWith(void Function(NetMessage) updates) =>
      super.copyWith((message) => updates(message as NetMessage)) as NetMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NetMessage create() => NetMessage._();
  NetMessage createEmptyInstance() => create();
  static $pb.PbList<NetMessage> createRepeated() => $pb.PbList<NetMessage>();
  @$core.pragma('dart2js:noInline')
  static NetMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NetMessage>(create);
  static NetMessage? _defaultInstance;

  NetMessage_Body whichBody() => _NetMessage_BodyByTag[$_whichOneof(0)]!;
  void clearBody() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  GetAddrReq get getAddrReq => $_getN(0);
  @$pb.TagNumber(1)
  set getAddrReq(GetAddrReq v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGetAddrReq() => $_has(0);
  @$pb.TagNumber(1)
  void clearGetAddrReq() => clearField(1);
  @$pb.TagNumber(1)
  GetAddrReq ensureGetAddrReq() => $_ensure(0);

  @$pb.TagNumber(2)
  GetAddrRes get getAddrRes => $_getN(1);
  @$pb.TagNumber(2)
  set getAddrRes(GetAddrRes v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasGetAddrRes() => $_has(1);
  @$pb.TagNumber(2)
  void clearGetAddrRes() => clearField(2);
  @$pb.TagNumber(2)
  GetAddrRes ensureGetAddrRes() => $_ensure(1);

  @$pb.TagNumber(3)
  FindTrackerReq get findTrackerReq => $_getN(2);
  @$pb.TagNumber(3)
  set findTrackerReq(FindTrackerReq v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFindTrackerReq() => $_has(2);
  @$pb.TagNumber(3)
  void clearFindTrackerReq() => clearField(3);
  @$pb.TagNumber(3)
  FindTrackerReq ensureFindTrackerReq() => $_ensure(2);

  @$pb.TagNumber(4)
  FindTrackerRes get findTrackerRes => $_getN(3);
  @$pb.TagNumber(4)
  set findTrackerRes(FindTrackerRes v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFindTrackerRes() => $_has(3);
  @$pb.TagNumber(4)
  void clearFindTrackerRes() => clearField(4);
  @$pb.TagNumber(4)
  FindTrackerRes ensureFindTrackerRes() => $_ensure(3);

  @$pb.TagNumber(5)
  FindResourceReq get findResourceReq => $_getN(4);
  @$pb.TagNumber(5)
  set findResourceReq(FindResourceReq v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasFindResourceReq() => $_has(4);
  @$pb.TagNumber(5)
  void clearFindResourceReq() => clearField(5);
  @$pb.TagNumber(5)
  FindResourceReq ensureFindResourceReq() => $_ensure(4);

  @$pb.TagNumber(6)
  FindResourceRes get findResourceRes => $_getN(5);
  @$pb.TagNumber(6)
  set findResourceRes(FindResourceRes v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasFindResourceRes() => $_has(5);
  @$pb.TagNumber(6)
  void clearFindResourceRes() => clearField(6);
  @$pb.TagNumber(6)
  FindResourceRes ensureFindResourceRes() => $_ensure(5);

  @$pb.TagNumber(7)
  PutResourceReq get putResourceReq => $_getN(6);
  @$pb.TagNumber(7)
  set putResourceReq(PutResourceReq v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasPutResourceReq() => $_has(6);
  @$pb.TagNumber(7)
  void clearPutResourceReq() => clearField(7);
  @$pb.TagNumber(7)
  PutResourceReq ensurePutResourceReq() => $_ensure(6);

  @$pb.TagNumber(8)
  PutResourceRes get putResourceRes => $_getN(7);
  @$pb.TagNumber(8)
  set putResourceRes(PutResourceRes v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasPutResourceRes() => $_has(7);
  @$pb.TagNumber(8)
  void clearPutResourceRes() => clearField(8);
  @$pb.TagNumber(8)
  PutResourceRes ensurePutResourceRes() => $_ensure(7);

  @$pb.TagNumber(9)
  ClientCertReq get clientCertReq => $_getN(8);
  @$pb.TagNumber(9)
  set clientCertReq(ClientCertReq v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasClientCertReq() => $_has(8);
  @$pb.TagNumber(9)
  void clearClientCertReq() => clearField(9);
  @$pb.TagNumber(9)
  ClientCertReq ensureClientCertReq() => $_ensure(8);

  @$pb.TagNumber(10)
  AddContactReq get addContactReq => $_getN(9);
  @$pb.TagNumber(10)
  set addContactReq(AddContactReq v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasAddContactReq() => $_has(9);
  @$pb.TagNumber(10)
  void clearAddContactReq() => clearField(10);
  @$pb.TagNumber(10)
  AddContactReq ensureAddContactReq() => $_ensure(9);

  @$pb.TagNumber(11)
  AddContactRes get addContactRes => $_getN(10);
  @$pb.TagNumber(11)
  set addContactRes(AddContactRes v) {
    setField(11, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasAddContactRes() => $_has(10);
  @$pb.TagNumber(11)
  void clearAddContactRes() => clearField(11);
  @$pb.TagNumber(11)
  AddContactRes ensureAddContactRes() => $_ensure(10);

  @$pb.TagNumber(12)
  ApprovalContactAddingReq get approvalContactAddingReq => $_getN(11);
  @$pb.TagNumber(12)
  set approvalContactAddingReq(ApprovalContactAddingReq v) {
    setField(12, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasApprovalContactAddingReq() => $_has(11);
  @$pb.TagNumber(12)
  void clearApprovalContactAddingReq() => clearField(12);
  @$pb.TagNumber(12)
  ApprovalContactAddingReq ensureApprovalContactAddingReq() => $_ensure(11);

  @$pb.TagNumber(13)
  ApprovalContactAddingRes get approvalContactAddingRes => $_getN(12);
  @$pb.TagNumber(13)
  set approvalContactAddingRes(ApprovalContactAddingRes v) {
    setField(13, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasApprovalContactAddingRes() => $_has(12);
  @$pb.TagNumber(13)
  void clearApprovalContactAddingRes() => clearField(13);
  @$pb.TagNumber(13)
  ApprovalContactAddingRes ensureApprovalContactAddingRes() => $_ensure(12);

  @$pb.TagNumber(14)
  SendMessageReq get sendMessageReq => $_getN(13);
  @$pb.TagNumber(14)
  set sendMessageReq(SendMessageReq v) {
    setField(14, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasSendMessageReq() => $_has(13);
  @$pb.TagNumber(14)
  void clearSendMessageReq() => clearField(14);
  @$pb.TagNumber(14)
  SendMessageReq ensureSendMessageReq() => $_ensure(13);

  @$pb.TagNumber(15)
  SendMessageRes get sendMessageRes => $_getN(14);
  @$pb.TagNumber(15)
  set sendMessageRes(SendMessageRes v) {
    setField(15, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasSendMessageRes() => $_has(14);
  @$pb.TagNumber(15)
  void clearSendMessageRes() => clearField(15);
  @$pb.TagNumber(15)
  SendMessageRes ensureSendMessageRes() => $_ensure(14);

  @$pb.TagNumber(16)
  GetFileReq get getFileReq => $_getN(15);
  @$pb.TagNumber(16)
  set getFileReq(GetFileReq v) {
    setField(16, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasGetFileReq() => $_has(15);
  @$pb.TagNumber(16)
  void clearGetFileReq() => clearField(16);
  @$pb.TagNumber(16)
  GetFileReq ensureGetFileReq() => $_ensure(15);

  @$pb.TagNumber(17)
  GetFileRes get getFileRes => $_getN(16);
  @$pb.TagNumber(17)
  set getFileRes(GetFileRes v) {
    setField(17, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasGetFileRes() => $_has(16);
  @$pb.TagNumber(17)
  void clearGetFileRes() => clearField(17);
  @$pb.TagNumber(17)
  GetFileRes ensureGetFileRes() => $_ensure(16);

  @$pb.TagNumber(18)
  SendFileReq get sendFileReq => $_getN(17);
  @$pb.TagNumber(18)
  set sendFileReq(SendFileReq v) {
    setField(18, v);
  }

  @$pb.TagNumber(18)
  $core.bool hasSendFileReq() => $_has(17);
  @$pb.TagNumber(18)
  void clearSendFileReq() => clearField(18);
  @$pb.TagNumber(18)
  SendFileReq ensureSendFileReq() => $_ensure(17);

  @$pb.TagNumber(19)
  SendFileRes get sendFileRes => $_getN(18);
  @$pb.TagNumber(19)
  set sendFileRes(SendFileRes v) {
    setField(19, v);
  }

  @$pb.TagNumber(19)
  $core.bool hasSendFileRes() => $_has(18);
  @$pb.TagNumber(19)
  void clearSendFileRes() => clearField(19);
  @$pb.TagNumber(19)
  SendFileRes ensureSendFileRes() => $_ensure(18);

  @$pb.TagNumber(20)
  FinishSendFileReq get finishSendFileReq => $_getN(19);
  @$pb.TagNumber(20)
  set finishSendFileReq(FinishSendFileReq v) {
    setField(20, v);
  }

  @$pb.TagNumber(20)
  $core.bool hasFinishSendFileReq() => $_has(19);
  @$pb.TagNumber(20)
  void clearFinishSendFileReq() => clearField(20);
  @$pb.TagNumber(20)
  FinishSendFileReq ensureFinishSendFileReq() => $_ensure(19);
}
