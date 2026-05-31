// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_history_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeletionHistoryDbCollection on Isar {
  IsarCollection<DeletionHistoryDb> get deletionHistoryDbs => this.collection();
}

const DeletionHistoryDbSchema = CollectionSchema(
  name: r'DeletionHistoryDb',
  id: -528848710651774976,
  properties: {
    r'blurryCount': PropertySchema(
      id: 0,
      name: r'blurryCount',
      type: IsarType.long,
    ),
    r'duplicateCount': PropertySchema(
      id: 1,
      name: r'duplicateCount',
      type: IsarType.long,
    ),
    r'isGuest': PropertySchema(id: 2, name: r'isGuest', type: IsarType.bool),
    r'remoteId': PropertySchema(
      id: 3,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 4,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _DeletionHistoryDbsyncStatusEnumValueMap,
    ),
    r'timestamp': PropertySchema(
      id: 5,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'totalCount': PropertySchema(
      id: 6,
      name: r'totalCount',
      type: IsarType.long,
    ),
    r'totalDeletedSize': PropertySchema(
      id: 7,
      name: r'totalDeletedSize',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 8,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(id: 9, name: r'userId', type: IsarType.string),
  },

  estimateSize: _deletionHistoryDbEstimateSize,
  serialize: _deletionHistoryDbSerialize,
  deserialize: _deletionHistoryDbDeserialize,
  deserializeProp: _deletionHistoryDbDeserializeProp,
  idName: r'id',
  indexes: {
    r'remoteId': IndexSchema(
      id: 6301175856541681032,
      name: r'remoteId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'remoteId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'timestamp': IndexSchema(
      id: 1852253767416892198,
      name: r'timestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'timestamp',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _deletionHistoryDbGetId,
  getLinks: _deletionHistoryDbGetLinks,
  attach: _deletionHistoryDbAttach,
  version: '3.3.2',
);

int _deletionHistoryDbEstimateSize(
  DeletionHistoryDb object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.remoteId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _deletionHistoryDbSerialize(
  DeletionHistoryDb object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.blurryCount);
  writer.writeLong(offsets[1], object.duplicateCount);
  writer.writeBool(offsets[2], object.isGuest);
  writer.writeString(offsets[3], object.remoteId);
  writer.writeByte(offsets[4], object.syncStatus.index);
  writer.writeDateTime(offsets[5], object.timestamp);
  writer.writeLong(offsets[6], object.totalCount);
  writer.writeLong(offsets[7], object.totalDeletedSize);
  writer.writeDateTime(offsets[8], object.updatedAt);
  writer.writeString(offsets[9], object.userId);
}

DeletionHistoryDb _deletionHistoryDbDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeletionHistoryDb();
  object.blurryCount = reader.readLong(offsets[0]);
  object.duplicateCount = reader.readLong(offsets[1]);
  object.id = id;
  object.isGuest = reader.readBool(offsets[2]);
  object.remoteId = reader.readStringOrNull(offsets[3]);
  object.syncStatus =
      _DeletionHistoryDbsyncStatusValueEnumMap[reader.readByteOrNull(
        offsets[4],
      )] ??
      SyncStatus.synced;
  object.timestamp = reader.readDateTime(offsets[5]);
  object.totalCount = reader.readLong(offsets[6]);
  object.totalDeletedSize = reader.readLong(offsets[7]);
  object.updatedAt = reader.readDateTime(offsets[8]);
  object.userId = reader.readStringOrNull(offsets[9]);
  return object;
}

P _deletionHistoryDbDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (_DeletionHistoryDbsyncStatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              SyncStatus.synced)
          as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DeletionHistoryDbsyncStatusEnumValueMap = {
  'synced': 0,
  'pendingCreate': 1,
  'pendingUpdate': 2,
  'pendingDelete': 3,
};
const _DeletionHistoryDbsyncStatusValueEnumMap = {
  0: SyncStatus.synced,
  1: SyncStatus.pendingCreate,
  2: SyncStatus.pendingUpdate,
  3: SyncStatus.pendingDelete,
};

Id _deletionHistoryDbGetId(DeletionHistoryDb object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deletionHistoryDbGetLinks(
  DeletionHistoryDb object,
) {
  return [];
}

void _deletionHistoryDbAttach(
  IsarCollection<dynamic> col,
  Id id,
  DeletionHistoryDb object,
) {
  object.id = id;
}

extension DeletionHistoryDbQueryWhereSort
    on QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QWhere> {
  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhere>
  anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }
}

extension DeletionHistoryDbQueryWhere
    on QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QWhereClause> {
  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [null]),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'remoteId',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  remoteIdEqualTo(String? remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [remoteId]),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  remoteIdNotEqualTo(String? remoteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [],
                upper: [remoteId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [remoteId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [remoteId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [],
                upper: [remoteId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'userId', value: [null]),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'userId',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  userIdEqualTo(String? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'userId', value: [userId]),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  userIdNotEqualTo(String? userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [],
                upper: [userId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [userId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [userId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [],
                upper: [userId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  timestampEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'timestamp', value: [timestamp]),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  timestampNotEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [],
                upper: [timestamp],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [timestamp],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [timestamp],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [],
                upper: [timestamp],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  timestampGreaterThan(DateTime timestamp, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'timestamp',
          lower: [timestamp],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  timestampLessThan(DateTime timestamp, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'timestamp',
          lower: [],
          upper: [timestamp],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterWhereClause>
  timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'timestamp',
          lower: [lowerTimestamp],
          includeLower: includeLower,
          upper: [upperTimestamp],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DeletionHistoryDbQueryFilter
    on QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QFilterCondition> {
  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  blurryCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'blurryCount', value: value),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  blurryCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'blurryCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  blurryCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'blurryCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  blurryCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'blurryCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  duplicateCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'duplicateCount', value: value),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  duplicateCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'duplicateCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  duplicateCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'duplicateCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  duplicateCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'duplicateCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  isGuestEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isGuest', value: value),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'remoteId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'remoteId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  syncStatusEqualTo(SyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncStatus', value: value),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  syncStatusGreaterThan(SyncStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'syncStatus',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  syncStatusLessThan(SyncStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'syncStatus',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  syncStatusBetween(
    SyncStatus lower,
    SyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'syncStatus',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timestamp', value: value),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  timestampGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  timestampLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timestamp',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  totalCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalCount', value: value),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  totalCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  totalCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  totalCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  totalDeletedSizeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalDeletedSize', value: value),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  totalDeletedSizeGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalDeletedSize',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  totalDeletedSizeLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalDeletedSize',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  totalDeletedSizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalDeletedSize',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'userId'),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'userId'),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'userId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'userId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'userId', value: ''),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'userId', value: ''),
      );
    });
  }
}

extension DeletionHistoryDbQueryObject
    on QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QFilterCondition> {}

extension DeletionHistoryDbQueryLinks
    on QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QFilterCondition> {}

extension DeletionHistoryDbQuerySortBy
    on QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QSortBy> {
  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByBlurryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurryCount', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByBlurryCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurryCount', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByDuplicateCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duplicateCount', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByDuplicateCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duplicateCount', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByIsGuest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuest', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByIsGuestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuest', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByTotalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCount', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByTotalCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCount', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByTotalDeletedSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDeletedSize', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByTotalDeletedSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDeletedSize', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension DeletionHistoryDbQuerySortThenBy
    on QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QSortThenBy> {
  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByBlurryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurryCount', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByBlurryCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurryCount', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByDuplicateCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duplicateCount', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByDuplicateCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duplicateCount', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByIsGuest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuest', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByIsGuestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuest', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByTotalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCount', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByTotalCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCount', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByTotalDeletedSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDeletedSize', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByTotalDeletedSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDeletedSize', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension DeletionHistoryDbQueryWhereDistinct
    on QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct> {
  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctByBlurryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blurryCount');
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctByDuplicateCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duplicateCount');
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctByIsGuest() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGuest');
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctByTotalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCount');
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctByTotalDeletedSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalDeletedSize');
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension DeletionHistoryDbQueryProperty
    on QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QQueryProperty> {
  QueryBuilder<DeletionHistoryDb, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DeletionHistoryDb, int, QQueryOperations> blurryCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blurryCount');
    });
  }

  QueryBuilder<DeletionHistoryDb, int, QQueryOperations>
  duplicateCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duplicateCount');
    });
  }

  QueryBuilder<DeletionHistoryDb, bool, QQueryOperations> isGuestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGuest');
    });
  }

  QueryBuilder<DeletionHistoryDb, String?, QQueryOperations>
  remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<DeletionHistoryDb, SyncStatus, QQueryOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<DeletionHistoryDb, DateTime, QQueryOperations>
  timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<DeletionHistoryDb, int, QQueryOperations> totalCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCount');
    });
  }

  QueryBuilder<DeletionHistoryDb, int, QQueryOperations>
  totalDeletedSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalDeletedSize');
    });
  }

  QueryBuilder<DeletionHistoryDb, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<DeletionHistoryDb, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
