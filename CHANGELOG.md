## 3.1.2

- Update dependencies

## 3.1.1

- Add `isDeleted` flag to watched change events

## 3.1.0

- Update to latest `crdt` version
- Breaking: tweaked signature of `watch` method to match `MapCrdtBase`

## 3.0.1

- Update to latest `crdt` version

## 3.0.0

This version introduces a major refactor which results in multiple breaking changes in line with `crdt` 5.0.0.

This package is now compatible with [crdt_sync](https://github.com/cachapa/crdt_sync), thereby abstracting the communication protocol and network management for real-time remote synchronization.

Changes:
- Removed direct interaction with the `Record` and `Hlc` classes
- Added multiple table support

## 2.0.4

- Avoid repeated records when generating changesets using `since`

## 2.0.3

- Update to Dart 3

## 2.0.2

- Fix watching for changes during a store purge

## 2.0.1

- Add purge() method to clear the data store

## 2.0.0

- Reapply breaking change: Remove nodeId from HlcAdapter, please use HlcCompatAdapter for backward compatibility

## 1.1.1

- Revert breaking change on minor version bump

## 1.1.0

- Breaking: Remove nodeId from HlcAdapter, please use HlcCompatAdapter for backward compatibility

## 1.0.3

- Fix getRecord returning non-nullable type

## 1.0.2

- Fix (de)serialization of deleted records

## 1.0.1

- Migrate to Dart null safety

## 0.1.0

- Project imported from [crdt](https://github.com/cachapa/crdt)
- Implement `crdt` version `3.0.0`
