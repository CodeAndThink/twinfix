// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_item_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPhotoItemDbCollection on Isar {
  IsarCollection<PhotoItemDb> get photoItemDbs => this.collection();
}

const PhotoItemDbSchema = CollectionSchema(
  name: r'PhotoItemDb',
  id: 6740910476478380371,
  properties: {
    r'createDateTime': PropertySchema(
      id: 0,
      name: r'createDateTime',
      type: IsarType.long,
    ),
    r'dHash': PropertySchema(id: 1, name: r'dHash', type: IsarType.string),
    r'groupId': PropertySchema(id: 2, name: r'groupId', type: IsarType.string),
    r'height': PropertySchema(id: 3, name: r'height', type: IsarType.long),
    r'localId': PropertySchema(id: 4, name: r'localId', type: IsarType.string),
    r'pHash': PropertySchema(id: 5, name: r'pHash', type: IsarType.string),
    r'path': PropertySchema(id: 6, name: r'path', type: IsarType.string),
    r'type': PropertySchema(
      id: 7,
      name: r'type',
      type: IsarType.byte,
      enumMap: _PhotoItemDbtypeEnumValueMap,
    ),
    r'width': PropertySchema(id: 8, name: r'width', type: IsarType.long),
  },
  estimateSize: _photoItemDbEstimateSize,
  serialize: _photoItemDbSerialize,
  deserialize: _photoItemDbDeserialize,
  deserializeProp: _photoItemDbDeserializeProp,
  idName: r'id',
  indexes: {
    r'localId': IndexSchema(
      id: 1199848425898359622,
      name: r'localId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'localId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'groupId': IndexSchema(
      id: -8523216633229774932,
      name: r'groupId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'groupId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _photoItemDbGetId,
  getLinks: _photoItemDbGetLinks,
  attach: _photoItemDbAttach,
  version: '3.3.2',
);

int _photoItemDbEstimateSize(
  PhotoItemDb object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.dHash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.groupId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.localId.length * 3;
  {
    final value = object.pHash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.path.length * 3;
  return bytesCount;
}

void _photoItemDbSerialize(
  PhotoItemDb object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createDateTime);
  writer.writeString(offsets[1], object.dHash);
  writer.writeString(offsets[2], object.groupId);
  writer.writeLong(offsets[3], object.height);
  writer.writeString(offsets[4], object.localId);
  writer.writeString(offsets[5], object.pHash);
  writer.writeString(offsets[6], object.path);
  writer.writeByte(offsets[7], object.type.index);
  writer.writeLong(offsets[8], object.width);
}

PhotoItemDb _photoItemDbDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PhotoItemDb();
  object.createDateTime = reader.readLong(offsets[0]);
  object.dHash = reader.readStringOrNull(offsets[1]);
  object.groupId = reader.readStringOrNull(offsets[2]);
  object.height = reader.readLong(offsets[3]);
  object.id = id;
  object.localId = reader.readString(offsets[4]);
  object.pHash = reader.readStringOrNull(offsets[5]);
  object.path = reader.readString(offsets[6]);
  object.type =
      _PhotoItemDbtypeValueEnumMap[reader.readByteOrNull(offsets[7])] ??
      PhotoTypeDb.normal;
  object.width = reader.readLong(offsets[8]);
  return object;
}

P _photoItemDbDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (_PhotoItemDbtypeValueEnumMap[reader.readByteOrNull(offset)] ??
              PhotoTypeDb.normal)
          as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PhotoItemDbtypeEnumValueMap = {
  'normal': 0,
  'duplicate': 1,
  'burst': 2,
  'blurry': 3,
  'screenshot': 4,
};
const _PhotoItemDbtypeValueEnumMap = {
  0: PhotoTypeDb.normal,
  1: PhotoTypeDb.duplicate,
  2: PhotoTypeDb.burst,
  3: PhotoTypeDb.blurry,
  4: PhotoTypeDb.screenshot,
};

Id _photoItemDbGetId(PhotoItemDb object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _photoItemDbGetLinks(PhotoItemDb object) {
  return [];
}

void _photoItemDbAttach(
  IsarCollection<dynamic> col,
  Id id,
  PhotoItemDb object,
) {
  object.id = id;
}

extension PhotoItemDbByIndex on IsarCollection<PhotoItemDb> {
  Future<PhotoItemDb?> getByLocalId(String localId) {
    return getByIndex(r'localId', [localId]);
  }

  PhotoItemDb? getByLocalIdSync(String localId) {
    return getByIndexSync(r'localId', [localId]);
  }

  Future<bool> deleteByLocalId(String localId) {
    return deleteByIndex(r'localId', [localId]);
  }

  bool deleteByLocalIdSync(String localId) {
    return deleteByIndexSync(r'localId', [localId]);
  }

  Future<List<PhotoItemDb?>> getAllByLocalId(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'localId', values);
  }

  List<PhotoItemDb?> getAllByLocalIdSync(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'localId', values);
  }

  Future<int> deleteAllByLocalId(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'localId', values);
  }

  int deleteAllByLocalIdSync(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'localId', values);
  }

  Future<Id> putByLocalId(PhotoItemDb object) {
    return putByIndex(r'localId', object);
  }

  Id putByLocalIdSync(PhotoItemDb object, {bool saveLinks = true}) {
    return putByIndexSync(r'localId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLocalId(List<PhotoItemDb> objects) {
    return putAllByIndex(r'localId', objects);
  }

  List<Id> putAllByLocalIdSync(
    List<PhotoItemDb> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'localId', objects, saveLinks: saveLinks);
  }
}

extension PhotoItemDbQueryWhereSort
    on QueryBuilder<PhotoItemDb, PhotoItemDb, QWhere> {
  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PhotoItemDbQueryWhere
    on QueryBuilder<PhotoItemDb, PhotoItemDb, QWhereClause> {
  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> idBetween(
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

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> localIdEqualTo(
    String localId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'localId', value: [localId]),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> localIdNotEqualTo(
    String localId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'localId',
                lower: [],
                upper: [localId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'localId',
                lower: [localId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'localId',
                lower: [localId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'localId',
                lower: [],
                upper: [localId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> groupIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'groupId', value: [null]),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> groupIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'groupId',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> groupIdEqualTo(
    String? groupId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'groupId', value: [groupId]),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterWhereClause> groupIdNotEqualTo(
    String? groupId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'groupId',
                lower: [],
                upper: [groupId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'groupId',
                lower: [groupId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'groupId',
                lower: [groupId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'groupId',
                lower: [],
                upper: [groupId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension PhotoItemDbQueryFilter
    on QueryBuilder<PhotoItemDb, PhotoItemDb, QFilterCondition> {
  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  createDateTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createDateTime', value: value),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  createDateTimeGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createDateTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  createDateTimeLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createDateTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  createDateTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createDateTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> dHashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'dHash'),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  dHashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'dHash'),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> dHashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  dHashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> dHashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> dHashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dHash',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> dHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'dHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> dHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'dHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> dHashContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'dHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> dHashMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'dHash',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> dHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dHash', value: ''),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  dHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dHash', value: ''),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  groupIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'groupId'),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  groupIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'groupId'),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> groupIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'groupId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  groupIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'groupId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> groupIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'groupId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> groupIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'groupId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  groupIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'groupId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> groupIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'groupId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> groupIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'groupId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> groupIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'groupId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  groupIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'groupId', value: ''),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  groupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'groupId', value: ''),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> heightEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'height', value: value),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  heightGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'height',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> heightLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'height',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> heightBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'height',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
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

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
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

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> localIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'localId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  localIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'localId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> localIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'localId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> localIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'localId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  localIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'localId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> localIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'localId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> localIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'localId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> localIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'localId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  localIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localId', value: ''),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  localIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'localId', value: ''),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pHashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'pHash'),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  pHashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'pHash'),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pHashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  pHashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pHashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pHashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pHash',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'pHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'pHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pHashContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'pHash',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pHashMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'pHash',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pHash', value: ''),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  pHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'pHash', value: ''),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'path',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'path',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'path',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'path',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'path',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'path',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pathContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'path',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pathMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'path',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'path', value: ''),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'path', value: ''),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> typeEqualTo(
    PhotoTypeDb value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'type', value: value),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> typeGreaterThan(
    PhotoTypeDb value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'type',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> typeLessThan(
    PhotoTypeDb value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'type',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> typeBetween(
    PhotoTypeDb lower,
    PhotoTypeDb upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'type',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> widthEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'width', value: value),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition>
  widthGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'width',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> widthLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'width',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterFilterCondition> widthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'width',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension PhotoItemDbQueryObject
    on QueryBuilder<PhotoItemDb, PhotoItemDb, QFilterCondition> {}

extension PhotoItemDbQueryLinks
    on QueryBuilder<PhotoItemDb, PhotoItemDb, QFilterCondition> {}

extension PhotoItemDbQuerySortBy
    on QueryBuilder<PhotoItemDb, PhotoItemDb, QSortBy> {
  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByCreateDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy>
  sortByCreateDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByDHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dHash', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByDHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dHash', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByPHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pHash', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByPHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pHash', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> sortByWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.desc);
    });
  }
}

extension PhotoItemDbQuerySortThenBy
    on QueryBuilder<PhotoItemDb, PhotoItemDb, QSortThenBy> {
  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByCreateDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy>
  thenByCreateDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByDHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dHash', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByDHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dHash', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByPHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pHash', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByPHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pHash', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.asc);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QAfterSortBy> thenByWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.desc);
    });
  }
}

extension PhotoItemDbQueryWhereDistinct
    on QueryBuilder<PhotoItemDb, PhotoItemDb, QDistinct> {
  QueryBuilder<PhotoItemDb, PhotoItemDb, QDistinct> distinctByCreateDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createDateTime');
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QDistinct> distinctByDHash({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QDistinct> distinctByGroupId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QDistinct> distinctByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height');
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QDistinct> distinctByLocalId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QDistinct> distinctByPHash({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QDistinct> distinctByPath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<PhotoItemDb, PhotoItemDb, QDistinct> distinctByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'width');
    });
  }
}

extension PhotoItemDbQueryProperty
    on QueryBuilder<PhotoItemDb, PhotoItemDb, QQueryProperty> {
  QueryBuilder<PhotoItemDb, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PhotoItemDb, int, QQueryOperations> createDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createDateTime');
    });
  }

  QueryBuilder<PhotoItemDb, String?, QQueryOperations> dHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dHash');
    });
  }

  QueryBuilder<PhotoItemDb, String?, QQueryOperations> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupId');
    });
  }

  QueryBuilder<PhotoItemDb, int, QQueryOperations> heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<PhotoItemDb, String, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<PhotoItemDb, String?, QQueryOperations> pHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pHash');
    });
  }

  QueryBuilder<PhotoItemDb, String, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }

  QueryBuilder<PhotoItemDb, PhotoTypeDb, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<PhotoItemDb, int, QQueryOperations> widthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'width');
    });
  }
}
