import 'dart:isolate';

class SpawnArg<ObjT, ArgT> {
  ObjT obj;
  ArgT arg;
  SendPort? sendPort;

  SpawnArg(this.obj, this.arg, [this.sendPort]);
}
