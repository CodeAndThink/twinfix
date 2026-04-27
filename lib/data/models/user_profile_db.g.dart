// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserProfileDbCollection on Isar {
  IsarCollection<UserProfileDb> get userProfileDbs => this.collection();
}

const UserProfileDbSchema = CollectionSchema(
  name: r'UserProfileDb',
  id: -8583122128458473749,
  properties: {
    r'badgeIds': PropertySchema(
      id: 0,
      name: r'badgeIds',
      type: IsarType.stringList,
    ),
    r'blurryDeletedPhotos': PropertySchema(
      id: 1,
      name: r'blurryDeletedPhotos',
      type: IsarType.long,
    ),
    r'duplicateDeletedPhotos': PropertySchema(
      id: 2,
      name: r'duplicateDeletedPhotos',
      type: IsarType.long,
    ),
    r'hasUsedAiCleaner': PropertySchema(
      id: 3,
      name: r'hasUsedAiCleaner',
      type: IsarType.bool,
    ),
    r'isPro': PropertySchema(id: 4, name: r'isPro', type: IsarType.bool),
    r'lastCleanedAt': PropertySchema(
      id: 5,
      name: r'lastCleanedAt',
      type: IsarType.dateTime,
    ),
    r'maxDeletedInOneSession': PropertySchema(
      id: 6,
      name: r'maxDeletedInOneSession',
      type: IsarType.long,
    ),
    r'streakDays': PropertySchema(
      id: 7,
      name: r'streakDays',
      type: IsarType.long,
    ),
    r'totalCleanedBytes': PropertySchema(
      id: 8,
      name: r'totalCleanedBytes',
      type: IsarType.long,
    ),
    r'totalDeletedPhotos': PropertySchema(
      id: 9,
      name: r'totalDeletedPhotos',
      type: IsarType.long,
    ),
  },

  estimateSize: _userProfileDbEstimateSize,
  serialize: _userProfileDbSerialize,
  deserialize: _userProfileDbDeserialize,
  deserializeProp: _userProfileDbDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _userProfileDbGetId,
  getLinks: _userProfileDbGetLinks,
  attach: _userProfileDbAttach,
  version: '3.3.2',
);

int _userProfileDbEstimateSize(
  UserProfileDb object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.badgeIds.length * 3;
  {
    for (var i = 0; i < object.badgeIds.length; i++) {
      final value = object.badgeIds[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _userProfileDbSerialize(
  UserProfileDb object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.badgeIds);
  writer.writeLong(offsets[1], object.blurryDeletedPhotos);
  writer.writeLong(offsets[2], object.duplicateDeletedPhotos);
  writer.writeBool(offsets[3], object.hasUsedAiCleaner);
  writer.writeBool(offsets[4], object.isPro);
  writer.writeDateTime(offsets[5], object.lastCleanedAt);
  writer.writeLong(offsets[6], object.maxDeletedInOneSession);
  writer.writeLong(offsets[7], object.streakDays);
  writer.writeLong(offsets[8], object.totalCleanedBytes);
  writer.writeLong(offsets[9], object.totalDeletedPhotos);
}

UserProfileDb _userProfileDbDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserProfileDb();
  object.badgeIds = reader.readStringList(offsets[0]) ?? [];
  object.blurryDeletedPhotos = reader.readLong(offsets[1]);
  object.duplicateDeletedPhotos = reader.readLong(offsets[2]);
  object.hasUsedAiCleaner = reader.readBool(offsets[3]);
  object.id = id;
  object.isPro = reader.readBool(offsets[4]);
  object.lastCleanedAt = reader.readDateTimeOrNull(offsets[5]);
  object.maxDeletedInOneSession = reader.readLong(offsets[6]);
  object.streakDays = reader.readLong(offsets[7]);
  object.totalCleanedBytes = reader.readLong(offsets[8]);
  object.totalDeletedPhotos = reader.readLong(offsets[9]);
  return object;
}

P _userProfileDbDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userProfileDbGetId(UserProfileDb object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userProfileDbGetLinks(UserProfileDb object) {
  return [];
}

void _userProfileDbAttach(
  IsarCollection<dynamic> col,
  Id id,
  UserProfileDb object,
) {
  object.id = id;
}

extension UserProfileDbQueryWhereSort
    on QueryBuilder<UserProfileDb, UserProfileDb, QWhere> {
  QueryBuilder<UserProfileDb, UserProfileDb, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserProfileDbQueryWhere
    on QueryBuilder<UserProfileDb, UserProfileDb, QWhereClause> {
  QueryBuilder<UserProfileDb, UserProfileDb, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterWhereClause> idBetween(
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
}

extension UserProfileDbQueryFilter
    on QueryBuilder<UserProfileDb, UserProfileDb, QFilterCondition> {
  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'badgeIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'badgeIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'badgeIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'badgeIds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'badgeIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'badgeIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'badgeIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'badgeIds',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'badgeIds', value: ''),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'badgeIds', value: ''),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'badgeIds', length, true, length, true);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'badgeIds', 0, true, 0, true);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'badgeIds', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'badgeIds', 0, true, length, include);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'badgeIds', length, include, 999999, true);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  badgeIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'badgeIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  blurryDeletedPhotosEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'blurryDeletedPhotos', value: value),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  blurryDeletedPhotosGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'blurryDeletedPhotos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  blurryDeletedPhotosLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'blurryDeletedPhotos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  blurryDeletedPhotosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'blurryDeletedPhotos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  duplicateDeletedPhotosEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'duplicateDeletedPhotos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  duplicateDeletedPhotosGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'duplicateDeletedPhotos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  duplicateDeletedPhotosLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'duplicateDeletedPhotos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  duplicateDeletedPhotosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'duplicateDeletedPhotos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  hasUsedAiCleanerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasUsedAiCleaner', value: value),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
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

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  isProEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isPro', value: value),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  lastCleanedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastCleanedAt'),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  lastCleanedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastCleanedAt'),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  lastCleanedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastCleanedAt', value: value),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  lastCleanedAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastCleanedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  lastCleanedAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastCleanedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  lastCleanedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastCleanedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  maxDeletedInOneSessionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'maxDeletedInOneSession',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  maxDeletedInOneSessionGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'maxDeletedInOneSession',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  maxDeletedInOneSessionLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'maxDeletedInOneSession',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  maxDeletedInOneSessionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'maxDeletedInOneSession',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  streakDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'streakDays', value: value),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  streakDaysGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'streakDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  streakDaysLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'streakDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  streakDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'streakDays',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  totalCleanedBytesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalCleanedBytes', value: value),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  totalCleanedBytesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalCleanedBytes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  totalCleanedBytesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalCleanedBytes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  totalCleanedBytesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalCleanedBytes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  totalDeletedPhotosEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalDeletedPhotos', value: value),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  totalDeletedPhotosGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalDeletedPhotos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  totalDeletedPhotosLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalDeletedPhotos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterFilterCondition>
  totalDeletedPhotosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalDeletedPhotos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension UserProfileDbQueryObject
    on QueryBuilder<UserProfileDb, UserProfileDb, QFilterCondition> {}

extension UserProfileDbQueryLinks
    on QueryBuilder<UserProfileDb, UserProfileDb, QFilterCondition> {}

extension UserProfileDbQuerySortBy
    on QueryBuilder<UserProfileDb, UserProfileDb, QSortBy> {
  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByBlurryDeletedPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurryDeletedPhotos', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByBlurryDeletedPhotosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurryDeletedPhotos', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByDuplicateDeletedPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duplicateDeletedPhotos', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByDuplicateDeletedPhotosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duplicateDeletedPhotos', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByHasUsedAiCleaner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasUsedAiCleaner', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByHasUsedAiCleanerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasUsedAiCleaner', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy> sortByIsPro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPro', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy> sortByIsProDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPro', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByLastCleanedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCleanedAt', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByLastCleanedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCleanedAt', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByMaxDeletedInOneSession() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDeletedInOneSession', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByMaxDeletedInOneSessionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDeletedInOneSession', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy> sortByStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByTotalCleanedBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCleanedBytes', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByTotalCleanedBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCleanedBytes', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByTotalDeletedPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDeletedPhotos', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  sortByTotalDeletedPhotosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDeletedPhotos', Sort.desc);
    });
  }
}

extension UserProfileDbQuerySortThenBy
    on QueryBuilder<UserProfileDb, UserProfileDb, QSortThenBy> {
  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByBlurryDeletedPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurryDeletedPhotos', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByBlurryDeletedPhotosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurryDeletedPhotos', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByDuplicateDeletedPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duplicateDeletedPhotos', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByDuplicateDeletedPhotosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duplicateDeletedPhotos', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByHasUsedAiCleaner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasUsedAiCleaner', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByHasUsedAiCleanerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasUsedAiCleaner', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy> thenByIsPro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPro', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy> thenByIsProDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPro', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByLastCleanedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCleanedAt', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByLastCleanedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCleanedAt', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByMaxDeletedInOneSession() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDeletedInOneSession', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByMaxDeletedInOneSessionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDeletedInOneSession', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy> thenByStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByTotalCleanedBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCleanedBytes', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByTotalCleanedBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCleanedBytes', Sort.desc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByTotalDeletedPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDeletedPhotos', Sort.asc);
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QAfterSortBy>
  thenByTotalDeletedPhotosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDeletedPhotos', Sort.desc);
    });
  }
}

extension UserProfileDbQueryWhereDistinct
    on QueryBuilder<UserProfileDb, UserProfileDb, QDistinct> {
  QueryBuilder<UserProfileDb, UserProfileDb, QDistinct> distinctByBadgeIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'badgeIds');
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QDistinct>
  distinctByBlurryDeletedPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blurryDeletedPhotos');
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QDistinct>
  distinctByDuplicateDeletedPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duplicateDeletedPhotos');
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QDistinct>
  distinctByHasUsedAiCleaner() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasUsedAiCleaner');
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QDistinct> distinctByIsPro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPro');
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QDistinct>
  distinctByLastCleanedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastCleanedAt');
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QDistinct>
  distinctByMaxDeletedInOneSession() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxDeletedInOneSession');
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QDistinct> distinctByStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streakDays');
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QDistinct>
  distinctByTotalCleanedBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCleanedBytes');
    });
  }

  QueryBuilder<UserProfileDb, UserProfileDb, QDistinct>
  distinctByTotalDeletedPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalDeletedPhotos');
    });
  }
}

extension UserProfileDbQueryProperty
    on QueryBuilder<UserProfileDb, UserProfileDb, QQueryProperty> {
  QueryBuilder<UserProfileDb, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserProfileDb, List<String>, QQueryOperations>
  badgeIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'badgeIds');
    });
  }

  QueryBuilder<UserProfileDb, int, QQueryOperations>
  blurryDeletedPhotosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blurryDeletedPhotos');
    });
  }

  QueryBuilder<UserProfileDb, int, QQueryOperations>
  duplicateDeletedPhotosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duplicateDeletedPhotos');
    });
  }

  QueryBuilder<UserProfileDb, bool, QQueryOperations>
  hasUsedAiCleanerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasUsedAiCleaner');
    });
  }

  QueryBuilder<UserProfileDb, bool, QQueryOperations> isProProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPro');
    });
  }

  QueryBuilder<UserProfileDb, DateTime?, QQueryOperations>
  lastCleanedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastCleanedAt');
    });
  }

  QueryBuilder<UserProfileDb, int, QQueryOperations>
  maxDeletedInOneSessionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxDeletedInOneSession');
    });
  }

  QueryBuilder<UserProfileDb, int, QQueryOperations> streakDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streakDays');
    });
  }

  QueryBuilder<UserProfileDb, int, QQueryOperations>
  totalCleanedBytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCleanedBytes');
    });
  }

  QueryBuilder<UserProfileDb, int, QQueryOperations>
  totalDeletedPhotosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalDeletedPhotos');
    });
  }
}
