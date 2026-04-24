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
    r'bytesFreed': PropertySchema(
      id: 1,
      name: r'bytesFreed',
      type: IsarType.long,
    ),
    r'duplicateCount': PropertySchema(
      id: 2,
      name: r'duplicateCount',
      type: IsarType.long,
    ),
    r'timestamp': PropertySchema(
      id: 3,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'totalCount': PropertySchema(
      id: 4,
      name: r'totalCount',
      type: IsarType.long,
    ),
  },

  estimateSize: _deletionHistoryDbEstimateSize,
  serialize: _deletionHistoryDbSerialize,
  deserialize: _deletionHistoryDbDeserialize,
  deserializeProp: _deletionHistoryDbDeserializeProp,
  idName: r'id',
  indexes: {
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
  return bytesCount;
}

void _deletionHistoryDbSerialize(
  DeletionHistoryDb object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.blurryCount);
  writer.writeLong(offsets[1], object.bytesFreed);
  writer.writeLong(offsets[2], object.duplicateCount);
  writer.writeDateTime(offsets[3], object.timestamp);
  writer.writeLong(offsets[4], object.totalCount);
}

DeletionHistoryDb _deletionHistoryDbDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeletionHistoryDb();
  object.blurryCount = reader.readLong(offsets[0]);
  object.bytesFreed = reader.readLong(offsets[1]);
  object.duplicateCount = reader.readLong(offsets[2]);
  object.id = id;
  object.timestamp = reader.readDateTime(offsets[3]);
  object.totalCount = reader.readLong(offsets[4]);
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

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
  bytesFreedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bytesFreed', value: value),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  bytesFreedGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bytesFreed',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  bytesFreedLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bytesFreed',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterFilterCondition>
  bytesFreedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bytesFreed',
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
  sortByBytesFreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bytesFreed', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  sortByBytesFreedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bytesFreed', Sort.desc);
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
  thenByBytesFreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bytesFreed', Sort.asc);
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QAfterSortBy>
  thenByBytesFreedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bytesFreed', Sort.desc);
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
  distinctByBytesFreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bytesFreed');
    });
  }

  QueryBuilder<DeletionHistoryDb, DeletionHistoryDb, QDistinct>
  distinctByDuplicateCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duplicateCount');
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

  QueryBuilder<DeletionHistoryDb, int, QQueryOperations> bytesFreedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bytesFreed');
    });
  }

  QueryBuilder<DeletionHistoryDb, int, QQueryOperations>
  duplicateCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duplicateCount');
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
}
