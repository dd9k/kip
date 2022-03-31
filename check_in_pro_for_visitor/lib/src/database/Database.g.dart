// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ConfigurationEntry extends DataClass
    implements Insertable<ConfigurationEntry> {
  final String id;
  final String code;
  final String value;
  final String createdBy;
  final DateTime createdDate;
  final String updatedBy;
  final DateTime updatedDate;
  final String deletedBy;
  final DateTime deletedDate;
  ConfigurationEntry(
      {@required this.id,
      @required this.code,
      this.value,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.deletedBy,
      this.deletedDate});
  factory ConfigurationEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ConfigurationEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      code: stringType.mapFromDatabaseResponse(data['${effectivePrefix}code']),
      value:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
      createdBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      updatedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_by']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
      deletedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_by']),
      deletedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || updatedDate != null) {
      map['updated_date'] = Variable<DateTime>(updatedDate);
    }
    if (!nullToAbsent || deletedBy != null) {
      map['deleted_by'] = Variable<String>(deletedBy);
    }
    if (!nullToAbsent || deletedDate != null) {
      map['deleted_date'] = Variable<DateTime>(deletedDate);
    }
    return map;
  }

  ConfigurationEntityCompanion toCompanion(bool nullToAbsent) {
    return ConfigurationEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
      deletedBy: deletedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedBy),
      deletedDate: deletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedDate),
    );
  }

  factory ConfigurationEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ConfigurationEntry(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      value: serializer.fromJson<String>(json['value']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      deletedBy: serializer.fromJson<String>(json['deletedBy']),
      deletedDate: serializer.fromJson<DateTime>(json['deletedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'value': serializer.toJson<String>(value),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'deletedBy': serializer.toJson<String>(deletedBy),
      'deletedDate': serializer.toJson<DateTime>(deletedDate),
    };
  }

  ConfigurationEntry copyWith(
          {String id,
          String code,
          String value,
          String createdBy,
          DateTime createdDate,
          String updatedBy,
          DateTime updatedDate,
          String deletedBy,
          DateTime deletedDate}) =>
      ConfigurationEntry(
        id: id ?? this.id,
        code: code ?? this.code,
        value: value ?? this.value,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedDate: deletedDate ?? this.deletedDate,
      );
  @override
  String toString() {
    return (StringBuffer('ConfigurationEntry(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('value: $value, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          code.hashCode,
          $mrjc(
              value.hashCode,
              $mrjc(
                  createdBy.hashCode,
                  $mrjc(
                      createdDate.hashCode,
                      $mrjc(
                          updatedBy.hashCode,
                          $mrjc(
                              updatedDate.hashCode,
                              $mrjc(deletedBy.hashCode,
                                  deletedDate.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ConfigurationEntry &&
          other.id == this.id &&
          other.code == this.code &&
          other.value == this.value &&
          other.createdBy == this.createdBy &&
          other.createdDate == this.createdDate &&
          other.updatedBy == this.updatedBy &&
          other.updatedDate == this.updatedDate &&
          other.deletedBy == this.deletedBy &&
          other.deletedDate == this.deletedDate);
}

class ConfigurationEntityCompanion extends UpdateCompanion<ConfigurationEntry> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> value;
  final Value<String> createdBy;
  final Value<DateTime> createdDate;
  final Value<String> updatedBy;
  final Value<DateTime> updatedDate;
  final Value<String> deletedBy;
  final Value<DateTime> deletedDate;
  const ConfigurationEntityCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.value = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  });
  ConfigurationEntityCompanion.insert({
    this.id = const Value.absent(),
    @required String code,
    this.value = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  }) : code = Value(code);
  static Insertable<ConfigurationEntry> custom({
    Expression<String> id,
    Expression<String> code,
    Expression<String> value,
    Expression<String> createdBy,
    Expression<DateTime> createdDate,
    Expression<String> updatedBy,
    Expression<DateTime> updatedDate,
    Expression<String> deletedBy,
    Expression<DateTime> deletedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (value != null) 'value': value,
      if (createdBy != null) 'created_by': createdBy,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (deletedBy != null) 'deleted_by': deletedBy,
      if (deletedDate != null) 'deleted_date': deletedDate,
    });
  }

  ConfigurationEntityCompanion copyWith(
      {Value<String> id,
      Value<String> code,
      Value<String> value,
      Value<String> createdBy,
      Value<DateTime> createdDate,
      Value<String> updatedBy,
      Value<DateTime> updatedDate,
      Value<String> deletedBy,
      Value<DateTime> deletedDate}) {
    return ConfigurationEntityCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      value: value ?? this.value,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedDate: deletedDate ?? this.deletedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (deletedBy.present) {
      map['deleted_by'] = Variable<String>(deletedBy.value);
    }
    if (deletedDate.present) {
      map['deleted_date'] = Variable<DateTime>(deletedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfigurationEntityCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('value: $value, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }
}

class $ConfigurationEntityTable extends ConfigurationEntity
    with TableInfo<$ConfigurationEntityTable, ConfigurationEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ConfigurationEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => uuid.v1();
  }

  final VerificationMeta _codeMeta = const VerificationMeta('code');
  GeneratedTextColumn _code;
  @override
  GeneratedTextColumn get code => _code ??= _constructCode();
  GeneratedTextColumn _constructCode() {
    return GeneratedTextColumn(
      'code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedTextColumn _value;
  @override
  GeneratedTextColumn get value => _value ??= _constructValue();
  GeneratedTextColumn _constructValue() {
    return GeneratedTextColumn(
      'value',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedTextColumn _createdBy;
  @override
  GeneratedTextColumn get createdBy => _createdBy ??= _constructCreatedBy();
  GeneratedTextColumn _constructCreatedBy() {
    return GeneratedTextColumn(
      'created_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedByMeta = const VerificationMeta('updatedBy');
  GeneratedTextColumn _updatedBy;
  @override
  GeneratedTextColumn get updatedBy => _updatedBy ??= _constructUpdatedBy();
  GeneratedTextColumn _constructUpdatedBy() {
    return GeneratedTextColumn(
      'updated_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedByMeta = const VerificationMeta('deletedBy');
  GeneratedTextColumn _deletedBy;
  @override
  GeneratedTextColumn get deletedBy => _deletedBy ??= _constructDeletedBy();
  GeneratedTextColumn _constructDeletedBy() {
    return GeneratedTextColumn(
      'deleted_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedDateMeta =
      const VerificationMeta('deletedDate');
  GeneratedDateTimeColumn _deletedDate;
  @override
  GeneratedDateTimeColumn get deletedDate =>
      _deletedDate ??= _constructDeletedDate();
  GeneratedDateTimeColumn _constructDeletedDate() {
    return GeneratedDateTimeColumn(
      'deleted_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        value,
        createdBy,
        createdDate,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate
      ];
  @override
  $ConfigurationEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_configuration';
  @override
  final String actualTableName = 'cip_configuration';
  @override
  VerificationContext validateIntegrity(Insertable<ConfigurationEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code'], _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by'], _updatedByMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date'], _updatedDateMeta));
    }
    if (data.containsKey('deleted_by')) {
      context.handle(_deletedByMeta,
          deletedBy.isAcceptableOrUnknown(data['deleted_by'], _deletedByMeta));
    }
    if (data.containsKey('deleted_date')) {
      context.handle(
          _deletedDateMeta,
          deletedDate.isAcceptableOrUnknown(
              data['deleted_date'], _deletedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConfigurationEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ConfigurationEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ConfigurationEntityTable createAlias(String alias) {
    return $ConfigurationEntityTable(_db, alias);
  }
}

class VisitorCheckInEntry extends DataClass
    implements Insertable<VisitorCheckInEntry> {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String idCard;
  final String purpose;
  final String visitorId;
  final String visitorType;
  final String checkOutTimeExpected;
  final String customStep;
  final String fromCompany;
  final String toCompany;
  final double contactPersonId;
  final double faceCaptureRepoId;
  final int signInBy;
  final String signInType;
  final String imagePath;
  final double companyId;
  final double idCardRepoId;
  final double surveyId;
  final String idCardFile;
  final String faceCaptureFile;
  final String createdBy;
  final DateTime createdDate;
  final String updatedBy;
  final DateTime updatedDate;
  final String deletedBy;
  final DateTime deletedDate;
  final String cardNo;
  final String goods;
  final String receiver;
  final String visitorPosition;
  final String survey;
  final int gender;
  final String passportNo;
  final String nationality;
  final String birthDay;
  final String permanentAddress;
  final String departmentRoomNo;
  VisitorCheckInEntry(
      {@required this.id,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.idCard,
      this.purpose,
      this.visitorId,
      this.visitorType,
      this.checkOutTimeExpected,
      this.customStep,
      this.fromCompany,
      this.toCompany,
      this.contactPersonId,
      this.faceCaptureRepoId,
      this.signInBy,
      this.signInType,
      this.imagePath,
      this.companyId,
      this.idCardRepoId,
      this.surveyId,
      this.idCardFile,
      this.faceCaptureFile,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.deletedBy,
      this.deletedDate,
      this.cardNo,
      this.goods,
      this.receiver,
      this.visitorPosition,
      this.survey,
      this.gender,
      this.passportNo,
      this.nationality,
      this.birthDay,
      this.permanentAddress,
      this.departmentRoomNo});
  factory VisitorCheckInEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return VisitorCheckInEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      fullName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      phoneNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number']),
      idCard:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}id_card']),
      purpose:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}purpose']),
      visitorId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visitor_id']),
      visitorType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visitor_type']),
      checkOutTimeExpected: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}check_out_time_expected']),
      customStep: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}custom_step']),
      fromCompany: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}from_company']),
      toCompany: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}to_company']),
      contactPersonId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}contact_person_id']),
      faceCaptureRepoId: doubleType.mapFromDatabaseResponse(
          data['${effectivePrefix}face_capture_repo_id']),
      signInBy:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sign_in_by']),
      signInType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sign_in_type']),
      imagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
      companyId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_id']),
      idCardRepoId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_card_repo_id']),
      surveyId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}survey_id']),
      idCardFile: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_card_file']),
      faceCaptureFile: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}face_capture_file']),
      createdBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      updatedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_by']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
      deletedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_by']),
      deletedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_date']),
      cardNo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}card_no']),
      goods:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}goods']),
      receiver: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}receiver']),
      visitorPosition: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visitor_position']),
      survey:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}survey']),
      gender: intType.mapFromDatabaseResponse(data['${effectivePrefix}gender']),
      passportNo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}passport_no']),
      nationality: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}nationality']),
      birthDay: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}birth_day']),
      permanentAddress: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}permanent_address']),
      departmentRoomNo: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}department_room_no']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || idCard != null) {
      map['id_card'] = Variable<String>(idCard);
    }
    if (!nullToAbsent || purpose != null) {
      map['purpose'] = Variable<String>(purpose);
    }
    if (!nullToAbsent || visitorId != null) {
      map['visitor_id'] = Variable<String>(visitorId);
    }
    if (!nullToAbsent || visitorType != null) {
      map['visitor_type'] = Variable<String>(visitorType);
    }
    if (!nullToAbsent || checkOutTimeExpected != null) {
      map['check_out_time_expected'] = Variable<String>(checkOutTimeExpected);
    }
    if (!nullToAbsent || customStep != null) {
      map['custom_step'] = Variable<String>(customStep);
    }
    if (!nullToAbsent || fromCompany != null) {
      map['from_company'] = Variable<String>(fromCompany);
    }
    if (!nullToAbsent || toCompany != null) {
      map['to_company'] = Variable<String>(toCompany);
    }
    if (!nullToAbsent || contactPersonId != null) {
      map['contact_person_id'] = Variable<double>(contactPersonId);
    }
    if (!nullToAbsent || faceCaptureRepoId != null) {
      map['face_capture_repo_id'] = Variable<double>(faceCaptureRepoId);
    }
    if (!nullToAbsent || signInBy != null) {
      map['sign_in_by'] = Variable<int>(signInBy);
    }
    if (!nullToAbsent || signInType != null) {
      map['sign_in_type'] = Variable<String>(signInType);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<double>(companyId);
    }
    if (!nullToAbsent || idCardRepoId != null) {
      map['id_card_repo_id'] = Variable<double>(idCardRepoId);
    }
    if (!nullToAbsent || surveyId != null) {
      map['survey_id'] = Variable<double>(surveyId);
    }
    if (!nullToAbsent || idCardFile != null) {
      map['id_card_file'] = Variable<String>(idCardFile);
    }
    if (!nullToAbsent || faceCaptureFile != null) {
      map['face_capture_file'] = Variable<String>(faceCaptureFile);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || updatedDate != null) {
      map['updated_date'] = Variable<DateTime>(updatedDate);
    }
    if (!nullToAbsent || deletedBy != null) {
      map['deleted_by'] = Variable<String>(deletedBy);
    }
    if (!nullToAbsent || deletedDate != null) {
      map['deleted_date'] = Variable<DateTime>(deletedDate);
    }
    if (!nullToAbsent || cardNo != null) {
      map['card_no'] = Variable<String>(cardNo);
    }
    if (!nullToAbsent || goods != null) {
      map['goods'] = Variable<String>(goods);
    }
    if (!nullToAbsent || receiver != null) {
      map['receiver'] = Variable<String>(receiver);
    }
    if (!nullToAbsent || visitorPosition != null) {
      map['visitor_position'] = Variable<String>(visitorPosition);
    }
    if (!nullToAbsent || survey != null) {
      map['survey'] = Variable<String>(survey);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<int>(gender);
    }
    if (!nullToAbsent || passportNo != null) {
      map['passport_no'] = Variable<String>(passportNo);
    }
    if (!nullToAbsent || nationality != null) {
      map['nationality'] = Variable<String>(nationality);
    }
    if (!nullToAbsent || birthDay != null) {
      map['birth_day'] = Variable<String>(birthDay);
    }
    if (!nullToAbsent || permanentAddress != null) {
      map['permanent_address'] = Variable<String>(permanentAddress);
    }
    if (!nullToAbsent || departmentRoomNo != null) {
      map['department_room_no'] = Variable<String>(departmentRoomNo);
    }
    return map;
  }

  VisitorCheckInEntityCompanion toCompanion(bool nullToAbsent) {
    return VisitorCheckInEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      idCard:
          idCard == null && nullToAbsent ? const Value.absent() : Value(idCard),
      purpose: purpose == null && nullToAbsent
          ? const Value.absent()
          : Value(purpose),
      visitorId: visitorId == null && nullToAbsent
          ? const Value.absent()
          : Value(visitorId),
      visitorType: visitorType == null && nullToAbsent
          ? const Value.absent()
          : Value(visitorType),
      checkOutTimeExpected: checkOutTimeExpected == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOutTimeExpected),
      customStep: customStep == null && nullToAbsent
          ? const Value.absent()
          : Value(customStep),
      fromCompany: fromCompany == null && nullToAbsent
          ? const Value.absent()
          : Value(fromCompany),
      toCompany: toCompany == null && nullToAbsent
          ? const Value.absent()
          : Value(toCompany),
      contactPersonId: contactPersonId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPersonId),
      faceCaptureRepoId: faceCaptureRepoId == null && nullToAbsent
          ? const Value.absent()
          : Value(faceCaptureRepoId),
      signInBy: signInBy == null && nullToAbsent
          ? const Value.absent()
          : Value(signInBy),
      signInType: signInType == null && nullToAbsent
          ? const Value.absent()
          : Value(signInType),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      idCardRepoId: idCardRepoId == null && nullToAbsent
          ? const Value.absent()
          : Value(idCardRepoId),
      surveyId: surveyId == null && nullToAbsent
          ? const Value.absent()
          : Value(surveyId),
      idCardFile: idCardFile == null && nullToAbsent
          ? const Value.absent()
          : Value(idCardFile),
      faceCaptureFile: faceCaptureFile == null && nullToAbsent
          ? const Value.absent()
          : Value(faceCaptureFile),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
      deletedBy: deletedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedBy),
      deletedDate: deletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedDate),
      cardNo:
          cardNo == null && nullToAbsent ? const Value.absent() : Value(cardNo),
      goods:
          goods == null && nullToAbsent ? const Value.absent() : Value(goods),
      receiver: receiver == null && nullToAbsent
          ? const Value.absent()
          : Value(receiver),
      visitorPosition: visitorPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(visitorPosition),
      survey:
          survey == null && nullToAbsent ? const Value.absent() : Value(survey),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      passportNo: passportNo == null && nullToAbsent
          ? const Value.absent()
          : Value(passportNo),
      nationality: nationality == null && nullToAbsent
          ? const Value.absent()
          : Value(nationality),
      birthDay: birthDay == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDay),
      permanentAddress: permanentAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(permanentAddress),
      departmentRoomNo: departmentRoomNo == null && nullToAbsent
          ? const Value.absent()
          : Value(departmentRoomNo),
    );
  }

  factory VisitorCheckInEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VisitorCheckInEntry(
      id: serializer.fromJson<String>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      email: serializer.fromJson<String>(json['email']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      idCard: serializer.fromJson<String>(json['idCard']),
      purpose: serializer.fromJson<String>(json['purpose']),
      visitorId: serializer.fromJson<String>(json['visitorId']),
      visitorType: serializer.fromJson<String>(json['visitorType']),
      checkOutTimeExpected:
          serializer.fromJson<String>(json['checkOutTimeExpected']),
      customStep: serializer.fromJson<String>(json['customStep']),
      fromCompany: serializer.fromJson<String>(json['fromCompany']),
      toCompany: serializer.fromJson<String>(json['toCompany']),
      contactPersonId: serializer.fromJson<double>(json['contactPersonId']),
      faceCaptureRepoId: serializer.fromJson<double>(json['faceCaptureRepoId']),
      signInBy: serializer.fromJson<int>(json['signInBy']),
      signInType: serializer.fromJson<String>(json['signInType']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      companyId: serializer.fromJson<double>(json['companyId']),
      idCardRepoId: serializer.fromJson<double>(json['idCardRepoId']),
      surveyId: serializer.fromJson<double>(json['surveyId']),
      idCardFile: serializer.fromJson<String>(json['idCardFile']),
      faceCaptureFile: serializer.fromJson<String>(json['faceCaptureFile']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      deletedBy: serializer.fromJson<String>(json['deletedBy']),
      deletedDate: serializer.fromJson<DateTime>(json['deletedDate']),
      cardNo: serializer.fromJson<String>(json['cardNo']),
      goods: serializer.fromJson<String>(json['goods']),
      receiver: serializer.fromJson<String>(json['receiver']),
      visitorPosition: serializer.fromJson<String>(json['visitorPosition']),
      survey: serializer.fromJson<String>(json['survey']),
      gender: serializer.fromJson<int>(json['gender']),
      passportNo: serializer.fromJson<String>(json['passportNo']),
      nationality: serializer.fromJson<String>(json['nationality']),
      birthDay: serializer.fromJson<String>(json['birthDay']),
      permanentAddress: serializer.fromJson<String>(json['permanentAddress']),
      departmentRoomNo: serializer.fromJson<String>(json['departmentRoomNo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fullName': serializer.toJson<String>(fullName),
      'email': serializer.toJson<String>(email),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'idCard': serializer.toJson<String>(idCard),
      'purpose': serializer.toJson<String>(purpose),
      'visitorId': serializer.toJson<String>(visitorId),
      'visitorType': serializer.toJson<String>(visitorType),
      'checkOutTimeExpected': serializer.toJson<String>(checkOutTimeExpected),
      'customStep': serializer.toJson<String>(customStep),
      'fromCompany': serializer.toJson<String>(fromCompany),
      'toCompany': serializer.toJson<String>(toCompany),
      'contactPersonId': serializer.toJson<double>(contactPersonId),
      'faceCaptureRepoId': serializer.toJson<double>(faceCaptureRepoId),
      'signInBy': serializer.toJson<int>(signInBy),
      'signInType': serializer.toJson<String>(signInType),
      'imagePath': serializer.toJson<String>(imagePath),
      'companyId': serializer.toJson<double>(companyId),
      'idCardRepoId': serializer.toJson<double>(idCardRepoId),
      'surveyId': serializer.toJson<double>(surveyId),
      'idCardFile': serializer.toJson<String>(idCardFile),
      'faceCaptureFile': serializer.toJson<String>(faceCaptureFile),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'deletedBy': serializer.toJson<String>(deletedBy),
      'deletedDate': serializer.toJson<DateTime>(deletedDate),
      'cardNo': serializer.toJson<String>(cardNo),
      'goods': serializer.toJson<String>(goods),
      'receiver': serializer.toJson<String>(receiver),
      'visitorPosition': serializer.toJson<String>(visitorPosition),
      'survey': serializer.toJson<String>(survey),
      'gender': serializer.toJson<int>(gender),
      'passportNo': serializer.toJson<String>(passportNo),
      'nationality': serializer.toJson<String>(nationality),
      'birthDay': serializer.toJson<String>(birthDay),
      'permanentAddress': serializer.toJson<String>(permanentAddress),
      'departmentRoomNo': serializer.toJson<String>(departmentRoomNo),
    };
  }

  VisitorCheckInEntry copyWith(
          {String id,
          String fullName,
          String email,
          String phoneNumber,
          String idCard,
          String purpose,
          String visitorId,
          String visitorType,
          String checkOutTimeExpected,
          String customStep,
          String fromCompany,
          String toCompany,
          double contactPersonId,
          double faceCaptureRepoId,
          int signInBy,
          String signInType,
          String imagePath,
          double companyId,
          double idCardRepoId,
          double surveyId,
          String idCardFile,
          String faceCaptureFile,
          String createdBy,
          DateTime createdDate,
          String updatedBy,
          DateTime updatedDate,
          String deletedBy,
          DateTime deletedDate,
          String cardNo,
          String goods,
          String receiver,
          String visitorPosition,
          String survey,
          int gender,
          String passportNo,
          String nationality,
          String birthDay,
          String permanentAddress,
          String departmentRoomNo}) =>
      VisitorCheckInEntry(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        idCard: idCard ?? this.idCard,
        purpose: purpose ?? this.purpose,
        visitorId: visitorId ?? this.visitorId,
        visitorType: visitorType ?? this.visitorType,
        checkOutTimeExpected: checkOutTimeExpected ?? this.checkOutTimeExpected,
        customStep: customStep ?? this.customStep,
        fromCompany: fromCompany ?? this.fromCompany,
        toCompany: toCompany ?? this.toCompany,
        contactPersonId: contactPersonId ?? this.contactPersonId,
        faceCaptureRepoId: faceCaptureRepoId ?? this.faceCaptureRepoId,
        signInBy: signInBy ?? this.signInBy,
        signInType: signInType ?? this.signInType,
        imagePath: imagePath ?? this.imagePath,
        companyId: companyId ?? this.companyId,
        idCardRepoId: idCardRepoId ?? this.idCardRepoId,
        surveyId: surveyId ?? this.surveyId,
        idCardFile: idCardFile ?? this.idCardFile,
        faceCaptureFile: faceCaptureFile ?? this.faceCaptureFile,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedDate: deletedDate ?? this.deletedDate,
        cardNo: cardNo ?? this.cardNo,
        goods: goods ?? this.goods,
        receiver: receiver ?? this.receiver,
        visitorPosition: visitorPosition ?? this.visitorPosition,
        survey: survey ?? this.survey,
        gender: gender ?? this.gender,
        passportNo: passportNo ?? this.passportNo,
        nationality: nationality ?? this.nationality,
        birthDay: birthDay ?? this.birthDay,
        permanentAddress: permanentAddress ?? this.permanentAddress,
        departmentRoomNo: departmentRoomNo ?? this.departmentRoomNo,
      );
  @override
  String toString() {
    return (StringBuffer('VisitorCheckInEntry(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('idCard: $idCard, ')
          ..write('purpose: $purpose, ')
          ..write('visitorId: $visitorId, ')
          ..write('visitorType: $visitorType, ')
          ..write('checkOutTimeExpected: $checkOutTimeExpected, ')
          ..write('customStep: $customStep, ')
          ..write('fromCompany: $fromCompany, ')
          ..write('toCompany: $toCompany, ')
          ..write('contactPersonId: $contactPersonId, ')
          ..write('faceCaptureRepoId: $faceCaptureRepoId, ')
          ..write('signInBy: $signInBy, ')
          ..write('signInType: $signInType, ')
          ..write('imagePath: $imagePath, ')
          ..write('companyId: $companyId, ')
          ..write('idCardRepoId: $idCardRepoId, ')
          ..write('surveyId: $surveyId, ')
          ..write('idCardFile: $idCardFile, ')
          ..write('faceCaptureFile: $faceCaptureFile, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate, ')
          ..write('cardNo: $cardNo, ')
          ..write('goods: $goods, ')
          ..write('receiver: $receiver, ')
          ..write('visitorPosition: $visitorPosition, ')
          ..write('survey: $survey, ')
          ..write('gender: $gender, ')
          ..write('passportNo: $passportNo, ')
          ..write('nationality: $nationality, ')
          ..write('birthDay: $birthDay, ')
          ..write('permanentAddress: $permanentAddress, ')
          ..write('departmentRoomNo: $departmentRoomNo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          fullName.hashCode,
          $mrjc(
              email.hashCode,
              $mrjc(
                  phoneNumber.hashCode,
                  $mrjc(
                      idCard.hashCode,
                      $mrjc(
                          purpose.hashCode,
                          $mrjc(
                              visitorId.hashCode,
                              $mrjc(
                                  visitorType.hashCode,
                                  $mrjc(
                                      checkOutTimeExpected.hashCode,
                                      $mrjc(
                                          customStep.hashCode,
                                          $mrjc(
                                              fromCompany.hashCode,
                                              $mrjc(
                                                  toCompany.hashCode,
                                                  $mrjc(
                                                      contactPersonId.hashCode,
                                                      $mrjc(
                                                          faceCaptureRepoId
                                                              .hashCode,
                                                          $mrjc(
                                                              signInBy.hashCode,
                                                              $mrjc(
                                                                  signInType
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      imagePath
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          companyId
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              idCardRepoId.hashCode,
                                                                              $mrjc(surveyId.hashCode, $mrjc(idCardFile.hashCode, $mrjc(faceCaptureFile.hashCode, $mrjc(createdBy.hashCode, $mrjc(createdDate.hashCode, $mrjc(updatedBy.hashCode, $mrjc(updatedDate.hashCode, $mrjc(deletedBy.hashCode, $mrjc(deletedDate.hashCode, $mrjc(cardNo.hashCode, $mrjc(goods.hashCode, $mrjc(receiver.hashCode, $mrjc(visitorPosition.hashCode, $mrjc(survey.hashCode, $mrjc(gender.hashCode, $mrjc(passportNo.hashCode, $mrjc(nationality.hashCode, $mrjc(birthDay.hashCode, $mrjc(permanentAddress.hashCode, departmentRoomNo.hashCode)))))))))))))))))))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is VisitorCheckInEntry &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.email == this.email &&
          other.phoneNumber == this.phoneNumber &&
          other.idCard == this.idCard &&
          other.purpose == this.purpose &&
          other.visitorId == this.visitorId &&
          other.visitorType == this.visitorType &&
          other.checkOutTimeExpected == this.checkOutTimeExpected &&
          other.customStep == this.customStep &&
          other.fromCompany == this.fromCompany &&
          other.toCompany == this.toCompany &&
          other.contactPersonId == this.contactPersonId &&
          other.faceCaptureRepoId == this.faceCaptureRepoId &&
          other.signInBy == this.signInBy &&
          other.signInType == this.signInType &&
          other.imagePath == this.imagePath &&
          other.companyId == this.companyId &&
          other.idCardRepoId == this.idCardRepoId &&
          other.surveyId == this.surveyId &&
          other.idCardFile == this.idCardFile &&
          other.faceCaptureFile == this.faceCaptureFile &&
          other.createdBy == this.createdBy &&
          other.createdDate == this.createdDate &&
          other.updatedBy == this.updatedBy &&
          other.updatedDate == this.updatedDate &&
          other.deletedBy == this.deletedBy &&
          other.deletedDate == this.deletedDate &&
          other.cardNo == this.cardNo &&
          other.goods == this.goods &&
          other.receiver == this.receiver &&
          other.visitorPosition == this.visitorPosition &&
          other.survey == this.survey &&
          other.gender == this.gender &&
          other.passportNo == this.passportNo &&
          other.nationality == this.nationality &&
          other.birthDay == this.birthDay &&
          other.permanentAddress == this.permanentAddress &&
          other.departmentRoomNo == this.departmentRoomNo);
}

class VisitorCheckInEntityCompanion
    extends UpdateCompanion<VisitorCheckInEntry> {
  final Value<String> id;
  final Value<String> fullName;
  final Value<String> email;
  final Value<String> phoneNumber;
  final Value<String> idCard;
  final Value<String> purpose;
  final Value<String> visitorId;
  final Value<String> visitorType;
  final Value<String> checkOutTimeExpected;
  final Value<String> customStep;
  final Value<String> fromCompany;
  final Value<String> toCompany;
  final Value<double> contactPersonId;
  final Value<double> faceCaptureRepoId;
  final Value<int> signInBy;
  final Value<String> signInType;
  final Value<String> imagePath;
  final Value<double> companyId;
  final Value<double> idCardRepoId;
  final Value<double> surveyId;
  final Value<String> idCardFile;
  final Value<String> faceCaptureFile;
  final Value<String> createdBy;
  final Value<DateTime> createdDate;
  final Value<String> updatedBy;
  final Value<DateTime> updatedDate;
  final Value<String> deletedBy;
  final Value<DateTime> deletedDate;
  final Value<String> cardNo;
  final Value<String> goods;
  final Value<String> receiver;
  final Value<String> visitorPosition;
  final Value<String> survey;
  final Value<int> gender;
  final Value<String> passportNo;
  final Value<String> nationality;
  final Value<String> birthDay;
  final Value<String> permanentAddress;
  final Value<String> departmentRoomNo;
  const VisitorCheckInEntityCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.idCard = const Value.absent(),
    this.purpose = const Value.absent(),
    this.visitorId = const Value.absent(),
    this.visitorType = const Value.absent(),
    this.checkOutTimeExpected = const Value.absent(),
    this.customStep = const Value.absent(),
    this.fromCompany = const Value.absent(),
    this.toCompany = const Value.absent(),
    this.contactPersonId = const Value.absent(),
    this.faceCaptureRepoId = const Value.absent(),
    this.signInBy = const Value.absent(),
    this.signInType = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.companyId = const Value.absent(),
    this.idCardRepoId = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.idCardFile = const Value.absent(),
    this.faceCaptureFile = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
    this.cardNo = const Value.absent(),
    this.goods = const Value.absent(),
    this.receiver = const Value.absent(),
    this.visitorPosition = const Value.absent(),
    this.survey = const Value.absent(),
    this.gender = const Value.absent(),
    this.passportNo = const Value.absent(),
    this.nationality = const Value.absent(),
    this.birthDay = const Value.absent(),
    this.permanentAddress = const Value.absent(),
    this.departmentRoomNo = const Value.absent(),
  });
  VisitorCheckInEntityCompanion.insert({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.idCard = const Value.absent(),
    this.purpose = const Value.absent(),
    this.visitorId = const Value.absent(),
    this.visitorType = const Value.absent(),
    this.checkOutTimeExpected = const Value.absent(),
    this.customStep = const Value.absent(),
    this.fromCompany = const Value.absent(),
    this.toCompany = const Value.absent(),
    this.contactPersonId = const Value.absent(),
    this.faceCaptureRepoId = const Value.absent(),
    this.signInBy = const Value.absent(),
    this.signInType = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.companyId = const Value.absent(),
    this.idCardRepoId = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.idCardFile = const Value.absent(),
    this.faceCaptureFile = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
    this.cardNo = const Value.absent(),
    this.goods = const Value.absent(),
    this.receiver = const Value.absent(),
    this.visitorPosition = const Value.absent(),
    this.survey = const Value.absent(),
    this.gender = const Value.absent(),
    this.passportNo = const Value.absent(),
    this.nationality = const Value.absent(),
    this.birthDay = const Value.absent(),
    this.permanentAddress = const Value.absent(),
    this.departmentRoomNo = const Value.absent(),
  });
  static Insertable<VisitorCheckInEntry> custom({
    Expression<String> id,
    Expression<String> fullName,
    Expression<String> email,
    Expression<String> phoneNumber,
    Expression<String> idCard,
    Expression<String> purpose,
    Expression<String> visitorId,
    Expression<String> visitorType,
    Expression<String> checkOutTimeExpected,
    Expression<String> customStep,
    Expression<String> fromCompany,
    Expression<String> toCompany,
    Expression<double> contactPersonId,
    Expression<double> faceCaptureRepoId,
    Expression<int> signInBy,
    Expression<String> signInType,
    Expression<String> imagePath,
    Expression<double> companyId,
    Expression<double> idCardRepoId,
    Expression<double> surveyId,
    Expression<String> idCardFile,
    Expression<String> faceCaptureFile,
    Expression<String> createdBy,
    Expression<DateTime> createdDate,
    Expression<String> updatedBy,
    Expression<DateTime> updatedDate,
    Expression<String> deletedBy,
    Expression<DateTime> deletedDate,
    Expression<String> cardNo,
    Expression<String> goods,
    Expression<String> receiver,
    Expression<String> visitorPosition,
    Expression<String> survey,
    Expression<int> gender,
    Expression<String> passportNo,
    Expression<String> nationality,
    Expression<String> birthDay,
    Expression<String> permanentAddress,
    Expression<String> departmentRoomNo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (idCard != null) 'id_card': idCard,
      if (purpose != null) 'purpose': purpose,
      if (visitorId != null) 'visitor_id': visitorId,
      if (visitorType != null) 'visitor_type': visitorType,
      if (checkOutTimeExpected != null)
        'check_out_time_expected': checkOutTimeExpected,
      if (customStep != null) 'custom_step': customStep,
      if (fromCompany != null) 'from_company': fromCompany,
      if (toCompany != null) 'to_company': toCompany,
      if (contactPersonId != null) 'contact_person_id': contactPersonId,
      if (faceCaptureRepoId != null) 'face_capture_repo_id': faceCaptureRepoId,
      if (signInBy != null) 'sign_in_by': signInBy,
      if (signInType != null) 'sign_in_type': signInType,
      if (imagePath != null) 'image_path': imagePath,
      if (companyId != null) 'company_id': companyId,
      if (idCardRepoId != null) 'id_card_repo_id': idCardRepoId,
      if (surveyId != null) 'survey_id': surveyId,
      if (idCardFile != null) 'id_card_file': idCardFile,
      if (faceCaptureFile != null) 'face_capture_file': faceCaptureFile,
      if (createdBy != null) 'created_by': createdBy,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (deletedBy != null) 'deleted_by': deletedBy,
      if (deletedDate != null) 'deleted_date': deletedDate,
      if (cardNo != null) 'card_no': cardNo,
      if (goods != null) 'goods': goods,
      if (receiver != null) 'receiver': receiver,
      if (visitorPosition != null) 'visitor_position': visitorPosition,
      if (survey != null) 'survey': survey,
      if (gender != null) 'gender': gender,
      if (passportNo != null) 'passport_no': passportNo,
      if (nationality != null) 'nationality': nationality,
      if (birthDay != null) 'birth_day': birthDay,
      if (permanentAddress != null) 'permanent_address': permanentAddress,
      if (departmentRoomNo != null) 'department_room_no': departmentRoomNo,
    });
  }

  VisitorCheckInEntityCompanion copyWith(
      {Value<String> id,
      Value<String> fullName,
      Value<String> email,
      Value<String> phoneNumber,
      Value<String> idCard,
      Value<String> purpose,
      Value<String> visitorId,
      Value<String> visitorType,
      Value<String> checkOutTimeExpected,
      Value<String> customStep,
      Value<String> fromCompany,
      Value<String> toCompany,
      Value<double> contactPersonId,
      Value<double> faceCaptureRepoId,
      Value<int> signInBy,
      Value<String> signInType,
      Value<String> imagePath,
      Value<double> companyId,
      Value<double> idCardRepoId,
      Value<double> surveyId,
      Value<String> idCardFile,
      Value<String> faceCaptureFile,
      Value<String> createdBy,
      Value<DateTime> createdDate,
      Value<String> updatedBy,
      Value<DateTime> updatedDate,
      Value<String> deletedBy,
      Value<DateTime> deletedDate,
      Value<String> cardNo,
      Value<String> goods,
      Value<String> receiver,
      Value<String> visitorPosition,
      Value<String> survey,
      Value<int> gender,
      Value<String> passportNo,
      Value<String> nationality,
      Value<String> birthDay,
      Value<String> permanentAddress,
      Value<String> departmentRoomNo}) {
    return VisitorCheckInEntityCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      idCard: idCard ?? this.idCard,
      purpose: purpose ?? this.purpose,
      visitorId: visitorId ?? this.visitorId,
      visitorType: visitorType ?? this.visitorType,
      checkOutTimeExpected: checkOutTimeExpected ?? this.checkOutTimeExpected,
      customStep: customStep ?? this.customStep,
      fromCompany: fromCompany ?? this.fromCompany,
      toCompany: toCompany ?? this.toCompany,
      contactPersonId: contactPersonId ?? this.contactPersonId,
      faceCaptureRepoId: faceCaptureRepoId ?? this.faceCaptureRepoId,
      signInBy: signInBy ?? this.signInBy,
      signInType: signInType ?? this.signInType,
      imagePath: imagePath ?? this.imagePath,
      companyId: companyId ?? this.companyId,
      idCardRepoId: idCardRepoId ?? this.idCardRepoId,
      surveyId: surveyId ?? this.surveyId,
      idCardFile: idCardFile ?? this.idCardFile,
      faceCaptureFile: faceCaptureFile ?? this.faceCaptureFile,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedDate: deletedDate ?? this.deletedDate,
      cardNo: cardNo ?? this.cardNo,
      goods: goods ?? this.goods,
      receiver: receiver ?? this.receiver,
      visitorPosition: visitorPosition ?? this.visitorPosition,
      survey: survey ?? this.survey,
      gender: gender ?? this.gender,
      passportNo: passportNo ?? this.passportNo,
      nationality: nationality ?? this.nationality,
      birthDay: birthDay ?? this.birthDay,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      departmentRoomNo: departmentRoomNo ?? this.departmentRoomNo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (idCard.present) {
      map['id_card'] = Variable<String>(idCard.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>(purpose.value);
    }
    if (visitorId.present) {
      map['visitor_id'] = Variable<String>(visitorId.value);
    }
    if (visitorType.present) {
      map['visitor_type'] = Variable<String>(visitorType.value);
    }
    if (checkOutTimeExpected.present) {
      map['check_out_time_expected'] =
          Variable<String>(checkOutTimeExpected.value);
    }
    if (customStep.present) {
      map['custom_step'] = Variable<String>(customStep.value);
    }
    if (fromCompany.present) {
      map['from_company'] = Variable<String>(fromCompany.value);
    }
    if (toCompany.present) {
      map['to_company'] = Variable<String>(toCompany.value);
    }
    if (contactPersonId.present) {
      map['contact_person_id'] = Variable<double>(contactPersonId.value);
    }
    if (faceCaptureRepoId.present) {
      map['face_capture_repo_id'] = Variable<double>(faceCaptureRepoId.value);
    }
    if (signInBy.present) {
      map['sign_in_by'] = Variable<int>(signInBy.value);
    }
    if (signInType.present) {
      map['sign_in_type'] = Variable<String>(signInType.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<double>(companyId.value);
    }
    if (idCardRepoId.present) {
      map['id_card_repo_id'] = Variable<double>(idCardRepoId.value);
    }
    if (surveyId.present) {
      map['survey_id'] = Variable<double>(surveyId.value);
    }
    if (idCardFile.present) {
      map['id_card_file'] = Variable<String>(idCardFile.value);
    }
    if (faceCaptureFile.present) {
      map['face_capture_file'] = Variable<String>(faceCaptureFile.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (deletedBy.present) {
      map['deleted_by'] = Variable<String>(deletedBy.value);
    }
    if (deletedDate.present) {
      map['deleted_date'] = Variable<DateTime>(deletedDate.value);
    }
    if (cardNo.present) {
      map['card_no'] = Variable<String>(cardNo.value);
    }
    if (goods.present) {
      map['goods'] = Variable<String>(goods.value);
    }
    if (receiver.present) {
      map['receiver'] = Variable<String>(receiver.value);
    }
    if (visitorPosition.present) {
      map['visitor_position'] = Variable<String>(visitorPosition.value);
    }
    if (survey.present) {
      map['survey'] = Variable<String>(survey.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(gender.value);
    }
    if (passportNo.present) {
      map['passport_no'] = Variable<String>(passportNo.value);
    }
    if (nationality.present) {
      map['nationality'] = Variable<String>(nationality.value);
    }
    if (birthDay.present) {
      map['birth_day'] = Variable<String>(birthDay.value);
    }
    if (permanentAddress.present) {
      map['permanent_address'] = Variable<String>(permanentAddress.value);
    }
    if (departmentRoomNo.present) {
      map['department_room_no'] = Variable<String>(departmentRoomNo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitorCheckInEntityCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('idCard: $idCard, ')
          ..write('purpose: $purpose, ')
          ..write('visitorId: $visitorId, ')
          ..write('visitorType: $visitorType, ')
          ..write('checkOutTimeExpected: $checkOutTimeExpected, ')
          ..write('customStep: $customStep, ')
          ..write('fromCompany: $fromCompany, ')
          ..write('toCompany: $toCompany, ')
          ..write('contactPersonId: $contactPersonId, ')
          ..write('faceCaptureRepoId: $faceCaptureRepoId, ')
          ..write('signInBy: $signInBy, ')
          ..write('signInType: $signInType, ')
          ..write('imagePath: $imagePath, ')
          ..write('companyId: $companyId, ')
          ..write('idCardRepoId: $idCardRepoId, ')
          ..write('surveyId: $surveyId, ')
          ..write('idCardFile: $idCardFile, ')
          ..write('faceCaptureFile: $faceCaptureFile, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate, ')
          ..write('cardNo: $cardNo, ')
          ..write('goods: $goods, ')
          ..write('receiver: $receiver, ')
          ..write('visitorPosition: $visitorPosition, ')
          ..write('survey: $survey, ')
          ..write('gender: $gender, ')
          ..write('passportNo: $passportNo, ')
          ..write('nationality: $nationality, ')
          ..write('birthDay: $birthDay, ')
          ..write('permanentAddress: $permanentAddress, ')
          ..write('departmentRoomNo: $departmentRoomNo')
          ..write(')'))
        .toString();
  }
}

class $VisitorCheckInEntityTable extends VisitorCheckInEntity
    with TableInfo<$VisitorCheckInEntityTable, VisitorCheckInEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $VisitorCheckInEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => uuid.v1();
  }

  final VerificationMeta _fullNameMeta = const VerificationMeta('fullName');
  GeneratedTextColumn _fullName;
  @override
  GeneratedTextColumn get fullName => _fullName ??= _constructFullName();
  GeneratedTextColumn _constructFullName() {
    return GeneratedTextColumn(
      'full_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      true,
    );
  }

  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  GeneratedTextColumn _phoneNumber;
  @override
  GeneratedTextColumn get phoneNumber =>
      _phoneNumber ??= _constructPhoneNumber();
  GeneratedTextColumn _constructPhoneNumber() {
    return GeneratedTextColumn(
      'phone_number',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idCardMeta = const VerificationMeta('idCard');
  GeneratedTextColumn _idCard;
  @override
  GeneratedTextColumn get idCard => _idCard ??= _constructIdCard();
  GeneratedTextColumn _constructIdCard() {
    return GeneratedTextColumn(
      'id_card',
      $tableName,
      true,
    );
  }

  final VerificationMeta _purposeMeta = const VerificationMeta('purpose');
  GeneratedTextColumn _purpose;
  @override
  GeneratedTextColumn get purpose => _purpose ??= _constructPurpose();
  GeneratedTextColumn _constructPurpose() {
    return GeneratedTextColumn(
      'purpose',
      $tableName,
      true,
    );
  }

  final VerificationMeta _visitorIdMeta = const VerificationMeta('visitorId');
  GeneratedTextColumn _visitorId;
  @override
  GeneratedTextColumn get visitorId => _visitorId ??= _constructVisitorId();
  GeneratedTextColumn _constructVisitorId() {
    return GeneratedTextColumn(
      'visitor_id',
      $tableName,
      true,
    )..clientDefault = () => uuid.v1();
  }

  final VerificationMeta _visitorTypeMeta =
      const VerificationMeta('visitorType');
  GeneratedTextColumn _visitorType;
  @override
  GeneratedTextColumn get visitorType =>
      _visitorType ??= _constructVisitorType();
  GeneratedTextColumn _constructVisitorType() {
    return GeneratedTextColumn(
      'visitor_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _checkOutTimeExpectedMeta =
      const VerificationMeta('checkOutTimeExpected');
  GeneratedTextColumn _checkOutTimeExpected;
  @override
  GeneratedTextColumn get checkOutTimeExpected =>
      _checkOutTimeExpected ??= _constructCheckOutTimeExpected();
  GeneratedTextColumn _constructCheckOutTimeExpected() {
    return GeneratedTextColumn(
      'check_out_time_expected',
      $tableName,
      true,
    );
  }

  final VerificationMeta _customStepMeta = const VerificationMeta('customStep');
  GeneratedTextColumn _customStep;
  @override
  GeneratedTextColumn get customStep => _customStep ??= _constructCustomStep();
  GeneratedTextColumn _constructCustomStep() {
    return GeneratedTextColumn(
      'custom_step',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fromCompanyMeta =
      const VerificationMeta('fromCompany');
  GeneratedTextColumn _fromCompany;
  @override
  GeneratedTextColumn get fromCompany =>
      _fromCompany ??= _constructFromCompany();
  GeneratedTextColumn _constructFromCompany() {
    return GeneratedTextColumn(
      'from_company',
      $tableName,
      true,
    );
  }

  final VerificationMeta _toCompanyMeta = const VerificationMeta('toCompany');
  GeneratedTextColumn _toCompany;
  @override
  GeneratedTextColumn get toCompany => _toCompany ??= _constructToCompany();
  GeneratedTextColumn _constructToCompany() {
    return GeneratedTextColumn(
      'to_company',
      $tableName,
      true,
    );
  }

  final VerificationMeta _contactPersonIdMeta =
      const VerificationMeta('contactPersonId');
  GeneratedRealColumn _contactPersonId;
  @override
  GeneratedRealColumn get contactPersonId =>
      _contactPersonId ??= _constructContactPersonId();
  GeneratedRealColumn _constructContactPersonId() {
    return GeneratedRealColumn(
      'contact_person_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _faceCaptureRepoIdMeta =
      const VerificationMeta('faceCaptureRepoId');
  GeneratedRealColumn _faceCaptureRepoId;
  @override
  GeneratedRealColumn get faceCaptureRepoId =>
      _faceCaptureRepoId ??= _constructFaceCaptureRepoId();
  GeneratedRealColumn _constructFaceCaptureRepoId() {
    return GeneratedRealColumn(
      'face_capture_repo_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _signInByMeta = const VerificationMeta('signInBy');
  GeneratedIntColumn _signInBy;
  @override
  GeneratedIntColumn get signInBy => _signInBy ??= _constructSignInBy();
  GeneratedIntColumn _constructSignInBy() {
    return GeneratedIntColumn(
      'sign_in_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _signInTypeMeta = const VerificationMeta('signInType');
  GeneratedTextColumn _signInType;
  @override
  GeneratedTextColumn get signInType => _signInType ??= _constructSignInType();
  GeneratedTextColumn _constructSignInType() {
    return GeneratedTextColumn(
      'sign_in_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  GeneratedTextColumn _imagePath;
  @override
  GeneratedTextColumn get imagePath => _imagePath ??= _constructImagePath();
  GeneratedTextColumn _constructImagePath() {
    return GeneratedTextColumn(
      'image_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _companyIdMeta = const VerificationMeta('companyId');
  GeneratedRealColumn _companyId;
  @override
  GeneratedRealColumn get companyId => _companyId ??= _constructCompanyId();
  GeneratedRealColumn _constructCompanyId() {
    return GeneratedRealColumn(
      'company_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idCardRepoIdMeta =
      const VerificationMeta('idCardRepoId');
  GeneratedRealColumn _idCardRepoId;
  @override
  GeneratedRealColumn get idCardRepoId =>
      _idCardRepoId ??= _constructIdCardRepoId();
  GeneratedRealColumn _constructIdCardRepoId() {
    return GeneratedRealColumn(
      'id_card_repo_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _surveyIdMeta = const VerificationMeta('surveyId');
  GeneratedRealColumn _surveyId;
  @override
  GeneratedRealColumn get surveyId => _surveyId ??= _constructSurveyId();
  GeneratedRealColumn _constructSurveyId() {
    return GeneratedRealColumn(
      'survey_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idCardFileMeta = const VerificationMeta('idCardFile');
  GeneratedTextColumn _idCardFile;
  @override
  GeneratedTextColumn get idCardFile => _idCardFile ??= _constructIdCardFile();
  GeneratedTextColumn _constructIdCardFile() {
    return GeneratedTextColumn(
      'id_card_file',
      $tableName,
      true,
    );
  }

  final VerificationMeta _faceCaptureFileMeta =
      const VerificationMeta('faceCaptureFile');
  GeneratedTextColumn _faceCaptureFile;
  @override
  GeneratedTextColumn get faceCaptureFile =>
      _faceCaptureFile ??= _constructFaceCaptureFile();
  GeneratedTextColumn _constructFaceCaptureFile() {
    return GeneratedTextColumn(
      'face_capture_file',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedTextColumn _createdBy;
  @override
  GeneratedTextColumn get createdBy => _createdBy ??= _constructCreatedBy();
  GeneratedTextColumn _constructCreatedBy() {
    return GeneratedTextColumn(
      'created_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedByMeta = const VerificationMeta('updatedBy');
  GeneratedTextColumn _updatedBy;
  @override
  GeneratedTextColumn get updatedBy => _updatedBy ??= _constructUpdatedBy();
  GeneratedTextColumn _constructUpdatedBy() {
    return GeneratedTextColumn(
      'updated_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedByMeta = const VerificationMeta('deletedBy');
  GeneratedTextColumn _deletedBy;
  @override
  GeneratedTextColumn get deletedBy => _deletedBy ??= _constructDeletedBy();
  GeneratedTextColumn _constructDeletedBy() {
    return GeneratedTextColumn(
      'deleted_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedDateMeta =
      const VerificationMeta('deletedDate');
  GeneratedDateTimeColumn _deletedDate;
  @override
  GeneratedDateTimeColumn get deletedDate =>
      _deletedDate ??= _constructDeletedDate();
  GeneratedDateTimeColumn _constructDeletedDate() {
    return GeneratedDateTimeColumn(
      'deleted_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cardNoMeta = const VerificationMeta('cardNo');
  GeneratedTextColumn _cardNo;
  @override
  GeneratedTextColumn get cardNo => _cardNo ??= _constructCardNo();
  GeneratedTextColumn _constructCardNo() {
    return GeneratedTextColumn(
      'card_no',
      $tableName,
      true,
    );
  }

  final VerificationMeta _goodsMeta = const VerificationMeta('goods');
  GeneratedTextColumn _goods;
  @override
  GeneratedTextColumn get goods => _goods ??= _constructGoods();
  GeneratedTextColumn _constructGoods() {
    return GeneratedTextColumn(
      'goods',
      $tableName,
      true,
    );
  }

  final VerificationMeta _receiverMeta = const VerificationMeta('receiver');
  GeneratedTextColumn _receiver;
  @override
  GeneratedTextColumn get receiver => _receiver ??= _constructReceiver();
  GeneratedTextColumn _constructReceiver() {
    return GeneratedTextColumn(
      'receiver',
      $tableName,
      true,
    );
  }

  final VerificationMeta _visitorPositionMeta =
      const VerificationMeta('visitorPosition');
  GeneratedTextColumn _visitorPosition;
  @override
  GeneratedTextColumn get visitorPosition =>
      _visitorPosition ??= _constructVisitorPosition();
  GeneratedTextColumn _constructVisitorPosition() {
    return GeneratedTextColumn(
      'visitor_position',
      $tableName,
      true,
    );
  }

  final VerificationMeta _surveyMeta = const VerificationMeta('survey');
  GeneratedTextColumn _survey;
  @override
  GeneratedTextColumn get survey => _survey ??= _constructSurvey();
  GeneratedTextColumn _constructSurvey() {
    return GeneratedTextColumn(
      'survey',
      $tableName,
      true,
    );
  }

  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  GeneratedIntColumn _gender;
  @override
  GeneratedIntColumn get gender => _gender ??= _constructGender();
  GeneratedIntColumn _constructGender() {
    return GeneratedIntColumn(
      'gender',
      $tableName,
      true,
    );
  }

  final VerificationMeta _passportNoMeta = const VerificationMeta('passportNo');
  GeneratedTextColumn _passportNo;
  @override
  GeneratedTextColumn get passportNo => _passportNo ??= _constructPassportNo();
  GeneratedTextColumn _constructPassportNo() {
    return GeneratedTextColumn(
      'passport_no',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nationalityMeta =
      const VerificationMeta('nationality');
  GeneratedTextColumn _nationality;
  @override
  GeneratedTextColumn get nationality =>
      _nationality ??= _constructNationality();
  GeneratedTextColumn _constructNationality() {
    return GeneratedTextColumn(
      'nationality',
      $tableName,
      true,
    );
  }

  final VerificationMeta _birthDayMeta = const VerificationMeta('birthDay');
  GeneratedTextColumn _birthDay;
  @override
  GeneratedTextColumn get birthDay => _birthDay ??= _constructBirthDay();
  GeneratedTextColumn _constructBirthDay() {
    return GeneratedTextColumn(
      'birth_day',
      $tableName,
      true,
    );
  }

  final VerificationMeta _permanentAddressMeta =
      const VerificationMeta('permanentAddress');
  GeneratedTextColumn _permanentAddress;
  @override
  GeneratedTextColumn get permanentAddress =>
      _permanentAddress ??= _constructPermanentAddress();
  GeneratedTextColumn _constructPermanentAddress() {
    return GeneratedTextColumn(
      'permanent_address',
      $tableName,
      true,
    );
  }

  final VerificationMeta _departmentRoomNoMeta =
      const VerificationMeta('departmentRoomNo');
  GeneratedTextColumn _departmentRoomNo;
  @override
  GeneratedTextColumn get departmentRoomNo =>
      _departmentRoomNo ??= _constructDepartmentRoomNo();
  GeneratedTextColumn _constructDepartmentRoomNo() {
    return GeneratedTextColumn(
      'department_room_no',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        fullName,
        email,
        phoneNumber,
        idCard,
        purpose,
        visitorId,
        visitorType,
        checkOutTimeExpected,
        customStep,
        fromCompany,
        toCompany,
        contactPersonId,
        faceCaptureRepoId,
        signInBy,
        signInType,
        imagePath,
        companyId,
        idCardRepoId,
        surveyId,
        idCardFile,
        faceCaptureFile,
        createdBy,
        createdDate,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate,
        cardNo,
        goods,
        receiver,
        visitorPosition,
        survey,
        gender,
        passportNo,
        nationality,
        birthDay,
        permanentAddress,
        departmentRoomNo
      ];
  @override
  $VisitorCheckInEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_vistor_checkin';
  @override
  final String actualTableName = 'cip_vistor_checkin';
  @override
  VerificationContext validateIntegrity(
      Insertable<VisitorCheckInEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name'], _fullNameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number'], _phoneNumberMeta));
    }
    if (data.containsKey('id_card')) {
      context.handle(_idCardMeta,
          idCard.isAcceptableOrUnknown(data['id_card'], _idCardMeta));
    }
    if (data.containsKey('purpose')) {
      context.handle(_purposeMeta,
          purpose.isAcceptableOrUnknown(data['purpose'], _purposeMeta));
    }
    if (data.containsKey('visitor_id')) {
      context.handle(_visitorIdMeta,
          visitorId.isAcceptableOrUnknown(data['visitor_id'], _visitorIdMeta));
    }
    if (data.containsKey('visitor_type')) {
      context.handle(
          _visitorTypeMeta,
          visitorType.isAcceptableOrUnknown(
              data['visitor_type'], _visitorTypeMeta));
    }
    if (data.containsKey('check_out_time_expected')) {
      context.handle(
          _checkOutTimeExpectedMeta,
          checkOutTimeExpected.isAcceptableOrUnknown(
              data['check_out_time_expected'], _checkOutTimeExpectedMeta));
    }
    if (data.containsKey('custom_step')) {
      context.handle(
          _customStepMeta,
          customStep.isAcceptableOrUnknown(
              data['custom_step'], _customStepMeta));
    }
    if (data.containsKey('from_company')) {
      context.handle(
          _fromCompanyMeta,
          fromCompany.isAcceptableOrUnknown(
              data['from_company'], _fromCompanyMeta));
    }
    if (data.containsKey('to_company')) {
      context.handle(_toCompanyMeta,
          toCompany.isAcceptableOrUnknown(data['to_company'], _toCompanyMeta));
    }
    if (data.containsKey('contact_person_id')) {
      context.handle(
          _contactPersonIdMeta,
          contactPersonId.isAcceptableOrUnknown(
              data['contact_person_id'], _contactPersonIdMeta));
    }
    if (data.containsKey('face_capture_repo_id')) {
      context.handle(
          _faceCaptureRepoIdMeta,
          faceCaptureRepoId.isAcceptableOrUnknown(
              data['face_capture_repo_id'], _faceCaptureRepoIdMeta));
    }
    if (data.containsKey('sign_in_by')) {
      context.handle(_signInByMeta,
          signInBy.isAcceptableOrUnknown(data['sign_in_by'], _signInByMeta));
    }
    if (data.containsKey('sign_in_type')) {
      context.handle(
          _signInTypeMeta,
          signInType.isAcceptableOrUnknown(
              data['sign_in_type'], _signInTypeMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path'], _imagePathMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id'], _companyIdMeta));
    }
    if (data.containsKey('id_card_repo_id')) {
      context.handle(
          _idCardRepoIdMeta,
          idCardRepoId.isAcceptableOrUnknown(
              data['id_card_repo_id'], _idCardRepoIdMeta));
    }
    if (data.containsKey('survey_id')) {
      context.handle(_surveyIdMeta,
          surveyId.isAcceptableOrUnknown(data['survey_id'], _surveyIdMeta));
    }
    if (data.containsKey('id_card_file')) {
      context.handle(
          _idCardFileMeta,
          idCardFile.isAcceptableOrUnknown(
              data['id_card_file'], _idCardFileMeta));
    }
    if (data.containsKey('face_capture_file')) {
      context.handle(
          _faceCaptureFileMeta,
          faceCaptureFile.isAcceptableOrUnknown(
              data['face_capture_file'], _faceCaptureFileMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by'], _updatedByMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date'], _updatedDateMeta));
    }
    if (data.containsKey('deleted_by')) {
      context.handle(_deletedByMeta,
          deletedBy.isAcceptableOrUnknown(data['deleted_by'], _deletedByMeta));
    }
    if (data.containsKey('deleted_date')) {
      context.handle(
          _deletedDateMeta,
          deletedDate.isAcceptableOrUnknown(
              data['deleted_date'], _deletedDateMeta));
    }
    if (data.containsKey('card_no')) {
      context.handle(_cardNoMeta,
          cardNo.isAcceptableOrUnknown(data['card_no'], _cardNoMeta));
    }
    if (data.containsKey('goods')) {
      context.handle(
          _goodsMeta, goods.isAcceptableOrUnknown(data['goods'], _goodsMeta));
    }
    if (data.containsKey('receiver')) {
      context.handle(_receiverMeta,
          receiver.isAcceptableOrUnknown(data['receiver'], _receiverMeta));
    }
    if (data.containsKey('visitor_position')) {
      context.handle(
          _visitorPositionMeta,
          visitorPosition.isAcceptableOrUnknown(
              data['visitor_position'], _visitorPositionMeta));
    }
    if (data.containsKey('survey')) {
      context.handle(_surveyMeta,
          survey.isAcceptableOrUnknown(data['survey'], _surveyMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender'], _genderMeta));
    }
    if (data.containsKey('passport_no')) {
      context.handle(
          _passportNoMeta,
          passportNo.isAcceptableOrUnknown(
              data['passport_no'], _passportNoMeta));
    }
    if (data.containsKey('nationality')) {
      context.handle(
          _nationalityMeta,
          nationality.isAcceptableOrUnknown(
              data['nationality'], _nationalityMeta));
    }
    if (data.containsKey('birth_day')) {
      context.handle(_birthDayMeta,
          birthDay.isAcceptableOrUnknown(data['birth_day'], _birthDayMeta));
    }
    if (data.containsKey('permanent_address')) {
      context.handle(
          _permanentAddressMeta,
          permanentAddress.isAcceptableOrUnknown(
              data['permanent_address'], _permanentAddressMeta));
    }
    if (data.containsKey('department_room_no')) {
      context.handle(
          _departmentRoomNoMeta,
          departmentRoomNo.isAcceptableOrUnknown(
              data['department_room_no'], _departmentRoomNoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitorCheckInEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return VisitorCheckInEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VisitorCheckInEntityTable createAlias(String alias) {
    return $VisitorCheckInEntityTable(_db, alias);
  }
}

class VisitorTypeEntry extends DataClass
    implements Insertable<VisitorTypeEntry> {
  final String id;
  final String settingKey;
  final String settingValue;
  final String description;
  final bool isTakePicture;
  final bool isScanIdCard;
  final bool isSurvey;
  final bool isPrintCard;
  final bool allowToDisplayContactPerson;
  final DateTime createdDate;
  final String createdBy;
  final String updatedBy;
  final DateTime updatedDate;
  final String deletedBy;
  final DateTime deletedDate;
  VisitorTypeEntry(
      {@required this.id,
      this.settingKey,
      this.settingValue,
      this.description,
      this.isTakePicture,
      this.isScanIdCard,
      this.isSurvey,
      this.isPrintCard,
      this.allowToDisplayContactPerson,
      this.createdDate,
      this.createdBy,
      this.updatedBy,
      this.updatedDate,
      this.deletedBy,
      this.deletedDate});
  factory VisitorTypeEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return VisitorTypeEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      settingKey: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}setting_key']),
      settingValue: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}setting_value']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      isTakePicture: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_take_picture']),
      isScanIdCard: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_scan_id_card']),
      isSurvey:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_survey']),
      isPrintCard: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_print_card']),
      allowToDisplayContactPerson: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}allow_to_display_contact_person']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      createdBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
      updatedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_by']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
      deletedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_by']),
      deletedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || settingKey != null) {
      map['setting_key'] = Variable<String>(settingKey);
    }
    if (!nullToAbsent || settingValue != null) {
      map['setting_value'] = Variable<String>(settingValue);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || isTakePicture != null) {
      map['is_take_picture'] = Variable<bool>(isTakePicture);
    }
    if (!nullToAbsent || isScanIdCard != null) {
      map['is_scan_id_card'] = Variable<bool>(isScanIdCard);
    }
    if (!nullToAbsent || isSurvey != null) {
      map['is_survey'] = Variable<bool>(isSurvey);
    }
    if (!nullToAbsent || isPrintCard != null) {
      map['is_print_card'] = Variable<bool>(isPrintCard);
    }
    if (!nullToAbsent || allowToDisplayContactPerson != null) {
      map['allow_to_display_contact_person'] =
          Variable<bool>(allowToDisplayContactPerson);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || updatedDate != null) {
      map['updated_date'] = Variable<DateTime>(updatedDate);
    }
    if (!nullToAbsent || deletedBy != null) {
      map['deleted_by'] = Variable<String>(deletedBy);
    }
    if (!nullToAbsent || deletedDate != null) {
      map['deleted_date'] = Variable<DateTime>(deletedDate);
    }
    return map;
  }

  VisitorTypeEntityCompanion toCompanion(bool nullToAbsent) {
    return VisitorTypeEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      settingKey: settingKey == null && nullToAbsent
          ? const Value.absent()
          : Value(settingKey),
      settingValue: settingValue == null && nullToAbsent
          ? const Value.absent()
          : Value(settingValue),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isTakePicture: isTakePicture == null && nullToAbsent
          ? const Value.absent()
          : Value(isTakePicture),
      isScanIdCard: isScanIdCard == null && nullToAbsent
          ? const Value.absent()
          : Value(isScanIdCard),
      isSurvey: isSurvey == null && nullToAbsent
          ? const Value.absent()
          : Value(isSurvey),
      isPrintCard: isPrintCard == null && nullToAbsent
          ? const Value.absent()
          : Value(isPrintCard),
      allowToDisplayContactPerson:
          allowToDisplayContactPerson == null && nullToAbsent
              ? const Value.absent()
              : Value(allowToDisplayContactPerson),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
      deletedBy: deletedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedBy),
      deletedDate: deletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedDate),
    );
  }

  factory VisitorTypeEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VisitorTypeEntry(
      id: serializer.fromJson<String>(json['id']),
      settingKey: serializer.fromJson<String>(json['settingKey']),
      settingValue: serializer.fromJson<String>(json['settingValue']),
      description: serializer.fromJson<String>(json['description']),
      isTakePicture: serializer.fromJson<bool>(json['isTakePicture']),
      isScanIdCard: serializer.fromJson<bool>(json['isScanIdCard']),
      isSurvey: serializer.fromJson<bool>(json['isSurvey']),
      isPrintCard: serializer.fromJson<bool>(json['isPrintCard']),
      allowToDisplayContactPerson:
          serializer.fromJson<bool>(json['allowToDisplayContactPerson']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      deletedBy: serializer.fromJson<String>(json['deletedBy']),
      deletedDate: serializer.fromJson<DateTime>(json['deletedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'settingKey': serializer.toJson<String>(settingKey),
      'settingValue': serializer.toJson<String>(settingValue),
      'description': serializer.toJson<String>(description),
      'isTakePicture': serializer.toJson<bool>(isTakePicture),
      'isScanIdCard': serializer.toJson<bool>(isScanIdCard),
      'isSurvey': serializer.toJson<bool>(isSurvey),
      'isPrintCard': serializer.toJson<bool>(isPrintCard),
      'allowToDisplayContactPerson':
          serializer.toJson<bool>(allowToDisplayContactPerson),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'createdBy': serializer.toJson<String>(createdBy),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'deletedBy': serializer.toJson<String>(deletedBy),
      'deletedDate': serializer.toJson<DateTime>(deletedDate),
    };
  }

  VisitorTypeEntry copyWith(
          {String id,
          String settingKey,
          String settingValue,
          String description,
          bool isTakePicture,
          bool isScanIdCard,
          bool isSurvey,
          bool isPrintCard,
          bool allowToDisplayContactPerson,
          DateTime createdDate,
          String createdBy,
          String updatedBy,
          DateTime updatedDate,
          String deletedBy,
          DateTime deletedDate}) =>
      VisitorTypeEntry(
        id: id ?? this.id,
        settingKey: settingKey ?? this.settingKey,
        settingValue: settingValue ?? this.settingValue,
        description: description ?? this.description,
        isTakePicture: isTakePicture ?? this.isTakePicture,
        isScanIdCard: isScanIdCard ?? this.isScanIdCard,
        isSurvey: isSurvey ?? this.isSurvey,
        isPrintCard: isPrintCard ?? this.isPrintCard,
        allowToDisplayContactPerson:
            allowToDisplayContactPerson ?? this.allowToDisplayContactPerson,
        createdDate: createdDate ?? this.createdDate,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedDate: deletedDate ?? this.deletedDate,
      );
  @override
  String toString() {
    return (StringBuffer('VisitorTypeEntry(')
          ..write('id: $id, ')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue, ')
          ..write('description: $description, ')
          ..write('isTakePicture: $isTakePicture, ')
          ..write('isScanIdCard: $isScanIdCard, ')
          ..write('isSurvey: $isSurvey, ')
          ..write('isPrintCard: $isPrintCard, ')
          ..write('allowToDisplayContactPerson: $allowToDisplayContactPerson, ')
          ..write('createdDate: $createdDate, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          settingKey.hashCode,
          $mrjc(
              settingValue.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(
                      isTakePicture.hashCode,
                      $mrjc(
                          isScanIdCard.hashCode,
                          $mrjc(
                              isSurvey.hashCode,
                              $mrjc(
                                  isPrintCard.hashCode,
                                  $mrjc(
                                      allowToDisplayContactPerson.hashCode,
                                      $mrjc(
                                          createdDate.hashCode,
                                          $mrjc(
                                              createdBy.hashCode,
                                              $mrjc(
                                                  updatedBy.hashCode,
                                                  $mrjc(
                                                      updatedDate.hashCode,
                                                      $mrjc(
                                                          deletedBy.hashCode,
                                                          deletedDate
                                                              .hashCode)))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is VisitorTypeEntry &&
          other.id == this.id &&
          other.settingKey == this.settingKey &&
          other.settingValue == this.settingValue &&
          other.description == this.description &&
          other.isTakePicture == this.isTakePicture &&
          other.isScanIdCard == this.isScanIdCard &&
          other.isSurvey == this.isSurvey &&
          other.isPrintCard == this.isPrintCard &&
          other.allowToDisplayContactPerson ==
              this.allowToDisplayContactPerson &&
          other.createdDate == this.createdDate &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.updatedDate == this.updatedDate &&
          other.deletedBy == this.deletedBy &&
          other.deletedDate == this.deletedDate);
}

class VisitorTypeEntityCompanion extends UpdateCompanion<VisitorTypeEntry> {
  final Value<String> id;
  final Value<String> settingKey;
  final Value<String> settingValue;
  final Value<String> description;
  final Value<bool> isTakePicture;
  final Value<bool> isScanIdCard;
  final Value<bool> isSurvey;
  final Value<bool> isPrintCard;
  final Value<bool> allowToDisplayContactPerson;
  final Value<DateTime> createdDate;
  final Value<String> createdBy;
  final Value<String> updatedBy;
  final Value<DateTime> updatedDate;
  final Value<String> deletedBy;
  final Value<DateTime> deletedDate;
  const VisitorTypeEntityCompanion({
    this.id = const Value.absent(),
    this.settingKey = const Value.absent(),
    this.settingValue = const Value.absent(),
    this.description = const Value.absent(),
    this.isTakePicture = const Value.absent(),
    this.isScanIdCard = const Value.absent(),
    this.isSurvey = const Value.absent(),
    this.isPrintCard = const Value.absent(),
    this.allowToDisplayContactPerson = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  });
  VisitorTypeEntityCompanion.insert({
    this.id = const Value.absent(),
    this.settingKey = const Value.absent(),
    this.settingValue = const Value.absent(),
    this.description = const Value.absent(),
    this.isTakePicture = const Value.absent(),
    this.isScanIdCard = const Value.absent(),
    this.isSurvey = const Value.absent(),
    this.isPrintCard = const Value.absent(),
    this.allowToDisplayContactPerson = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  });
  static Insertable<VisitorTypeEntry> custom({
    Expression<String> id,
    Expression<String> settingKey,
    Expression<String> settingValue,
    Expression<String> description,
    Expression<bool> isTakePicture,
    Expression<bool> isScanIdCard,
    Expression<bool> isSurvey,
    Expression<bool> isPrintCard,
    Expression<bool> allowToDisplayContactPerson,
    Expression<DateTime> createdDate,
    Expression<String> createdBy,
    Expression<String> updatedBy,
    Expression<DateTime> updatedDate,
    Expression<String> deletedBy,
    Expression<DateTime> deletedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (settingKey != null) 'setting_key': settingKey,
      if (settingValue != null) 'setting_value': settingValue,
      if (description != null) 'description': description,
      if (isTakePicture != null) 'is_take_picture': isTakePicture,
      if (isScanIdCard != null) 'is_scan_id_card': isScanIdCard,
      if (isSurvey != null) 'is_survey': isSurvey,
      if (isPrintCard != null) 'is_print_card': isPrintCard,
      if (allowToDisplayContactPerson != null)
        'allow_to_display_contact_person': allowToDisplayContactPerson,
      if (createdDate != null) 'created_date': createdDate,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (deletedBy != null) 'deleted_by': deletedBy,
      if (deletedDate != null) 'deleted_date': deletedDate,
    });
  }

  VisitorTypeEntityCompanion copyWith(
      {Value<String> id,
      Value<String> settingKey,
      Value<String> settingValue,
      Value<String> description,
      Value<bool> isTakePicture,
      Value<bool> isScanIdCard,
      Value<bool> isSurvey,
      Value<bool> isPrintCard,
      Value<bool> allowToDisplayContactPerson,
      Value<DateTime> createdDate,
      Value<String> createdBy,
      Value<String> updatedBy,
      Value<DateTime> updatedDate,
      Value<String> deletedBy,
      Value<DateTime> deletedDate}) {
    return VisitorTypeEntityCompanion(
      id: id ?? this.id,
      settingKey: settingKey ?? this.settingKey,
      settingValue: settingValue ?? this.settingValue,
      description: description ?? this.description,
      isTakePicture: isTakePicture ?? this.isTakePicture,
      isScanIdCard: isScanIdCard ?? this.isScanIdCard,
      isSurvey: isSurvey ?? this.isSurvey,
      isPrintCard: isPrintCard ?? this.isPrintCard,
      allowToDisplayContactPerson:
          allowToDisplayContactPerson ?? this.allowToDisplayContactPerson,
      createdDate: createdDate ?? this.createdDate,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedDate: deletedDate ?? this.deletedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (settingKey.present) {
      map['setting_key'] = Variable<String>(settingKey.value);
    }
    if (settingValue.present) {
      map['setting_value'] = Variable<String>(settingValue.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isTakePicture.present) {
      map['is_take_picture'] = Variable<bool>(isTakePicture.value);
    }
    if (isScanIdCard.present) {
      map['is_scan_id_card'] = Variable<bool>(isScanIdCard.value);
    }
    if (isSurvey.present) {
      map['is_survey'] = Variable<bool>(isSurvey.value);
    }
    if (isPrintCard.present) {
      map['is_print_card'] = Variable<bool>(isPrintCard.value);
    }
    if (allowToDisplayContactPerson.present) {
      map['allow_to_display_contact_person'] =
          Variable<bool>(allowToDisplayContactPerson.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (deletedBy.present) {
      map['deleted_by'] = Variable<String>(deletedBy.value);
    }
    if (deletedDate.present) {
      map['deleted_date'] = Variable<DateTime>(deletedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitorTypeEntityCompanion(')
          ..write('id: $id, ')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue, ')
          ..write('description: $description, ')
          ..write('isTakePicture: $isTakePicture, ')
          ..write('isScanIdCard: $isScanIdCard, ')
          ..write('isSurvey: $isSurvey, ')
          ..write('isPrintCard: $isPrintCard, ')
          ..write('allowToDisplayContactPerson: $allowToDisplayContactPerson, ')
          ..write('createdDate: $createdDate, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }
}

class $VisitorTypeEntityTable extends VisitorTypeEntity
    with TableInfo<$VisitorTypeEntityTable, VisitorTypeEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $VisitorTypeEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => uuid.v1();
  }

  final VerificationMeta _settingKeyMeta = const VerificationMeta('settingKey');
  GeneratedTextColumn _settingKey;
  @override
  GeneratedTextColumn get settingKey => _settingKey ??= _constructSettingKey();
  GeneratedTextColumn _constructSettingKey() {
    return GeneratedTextColumn(
      'setting_key',
      $tableName,
      true,
    );
  }

  final VerificationMeta _settingValueMeta =
      const VerificationMeta('settingValue');
  GeneratedTextColumn _settingValue;
  @override
  GeneratedTextColumn get settingValue =>
      _settingValue ??= _constructSettingValue();
  GeneratedTextColumn _constructSettingValue() {
    return GeneratedTextColumn(
      'setting_value',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isTakePictureMeta =
      const VerificationMeta('isTakePicture');
  GeneratedBoolColumn _isTakePicture;
  @override
  GeneratedBoolColumn get isTakePicture =>
      _isTakePicture ??= _constructIsTakePicture();
  GeneratedBoolColumn _constructIsTakePicture() {
    return GeneratedBoolColumn(
      'is_take_picture',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isScanIdCardMeta =
      const VerificationMeta('isScanIdCard');
  GeneratedBoolColumn _isScanIdCard;
  @override
  GeneratedBoolColumn get isScanIdCard =>
      _isScanIdCard ??= _constructIsScanIdCard();
  GeneratedBoolColumn _constructIsScanIdCard() {
    return GeneratedBoolColumn(
      'is_scan_id_card',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isSurveyMeta = const VerificationMeta('isSurvey');
  GeneratedBoolColumn _isSurvey;
  @override
  GeneratedBoolColumn get isSurvey => _isSurvey ??= _constructIsSurvey();
  GeneratedBoolColumn _constructIsSurvey() {
    return GeneratedBoolColumn(
      'is_survey',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isPrintCardMeta =
      const VerificationMeta('isPrintCard');
  GeneratedBoolColumn _isPrintCard;
  @override
  GeneratedBoolColumn get isPrintCard =>
      _isPrintCard ??= _constructIsPrintCard();
  GeneratedBoolColumn _constructIsPrintCard() {
    return GeneratedBoolColumn(
      'is_print_card',
      $tableName,
      true,
    );
  }

  final VerificationMeta _allowToDisplayContactPersonMeta =
      const VerificationMeta('allowToDisplayContactPerson');
  GeneratedBoolColumn _allowToDisplayContactPerson;
  @override
  GeneratedBoolColumn get allowToDisplayContactPerson =>
      _allowToDisplayContactPerson ??= _constructAllowToDisplayContactPerson();
  GeneratedBoolColumn _constructAllowToDisplayContactPerson() {
    return GeneratedBoolColumn(
      'allow_to_display_contact_person',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedTextColumn _createdBy;
  @override
  GeneratedTextColumn get createdBy => _createdBy ??= _constructCreatedBy();
  GeneratedTextColumn _constructCreatedBy() {
    return GeneratedTextColumn(
      'created_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedByMeta = const VerificationMeta('updatedBy');
  GeneratedTextColumn _updatedBy;
  @override
  GeneratedTextColumn get updatedBy => _updatedBy ??= _constructUpdatedBy();
  GeneratedTextColumn _constructUpdatedBy() {
    return GeneratedTextColumn(
      'updated_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedByMeta = const VerificationMeta('deletedBy');
  GeneratedTextColumn _deletedBy;
  @override
  GeneratedTextColumn get deletedBy => _deletedBy ??= _constructDeletedBy();
  GeneratedTextColumn _constructDeletedBy() {
    return GeneratedTextColumn(
      'deleted_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedDateMeta =
      const VerificationMeta('deletedDate');
  GeneratedDateTimeColumn _deletedDate;
  @override
  GeneratedDateTimeColumn get deletedDate =>
      _deletedDate ??= _constructDeletedDate();
  GeneratedDateTimeColumn _constructDeletedDate() {
    return GeneratedDateTimeColumn(
      'deleted_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        settingKey,
        settingValue,
        description,
        isTakePicture,
        isScanIdCard,
        isSurvey,
        isPrintCard,
        allowToDisplayContactPerson,
        createdDate,
        createdBy,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate
      ];
  @override
  $VisitorTypeEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_vistor_type';
  @override
  final String actualTableName = 'cip_vistor_type';
  @override
  VerificationContext validateIntegrity(Insertable<VisitorTypeEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('setting_key')) {
      context.handle(
          _settingKeyMeta,
          settingKey.isAcceptableOrUnknown(
              data['setting_key'], _settingKeyMeta));
    }
    if (data.containsKey('setting_value')) {
      context.handle(
          _settingValueMeta,
          settingValue.isAcceptableOrUnknown(
              data['setting_value'], _settingValueMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('is_take_picture')) {
      context.handle(
          _isTakePictureMeta,
          isTakePicture.isAcceptableOrUnknown(
              data['is_take_picture'], _isTakePictureMeta));
    }
    if (data.containsKey('is_scan_id_card')) {
      context.handle(
          _isScanIdCardMeta,
          isScanIdCard.isAcceptableOrUnknown(
              data['is_scan_id_card'], _isScanIdCardMeta));
    }
    if (data.containsKey('is_survey')) {
      context.handle(_isSurveyMeta,
          isSurvey.isAcceptableOrUnknown(data['is_survey'], _isSurveyMeta));
    }
    if (data.containsKey('is_print_card')) {
      context.handle(
          _isPrintCardMeta,
          isPrintCard.isAcceptableOrUnknown(
              data['is_print_card'], _isPrintCardMeta));
    }
    if (data.containsKey('allow_to_display_contact_person')) {
      context.handle(
          _allowToDisplayContactPersonMeta,
          allowToDisplayContactPerson.isAcceptableOrUnknown(
              data['allow_to_display_contact_person'],
              _allowToDisplayContactPersonMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by'], _updatedByMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date'], _updatedDateMeta));
    }
    if (data.containsKey('deleted_by')) {
      context.handle(_deletedByMeta,
          deletedBy.isAcceptableOrUnknown(data['deleted_by'], _deletedByMeta));
    }
    if (data.containsKey('deleted_date')) {
      context.handle(
          _deletedDateMeta,
          deletedDate.isAcceptableOrUnknown(
              data['deleted_date'], _deletedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitorTypeEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return VisitorTypeEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VisitorTypeEntityTable createAlias(String alias) {
    return $VisitorTypeEntityTable(_db, alias);
  }
}

class CheckInFlowEntry extends DataClass
    implements Insertable<CheckInFlowEntry> {
  final String templateCode;
  final String templateName;
  final String stepName;
  final String stepCode;
  final String stepType;
  final String visitorType;
  final int isRequired;
  final String sort;
  final String createdBy;
  final DateTime createdDate;
  final String updatedBy;
  final DateTime updatedDate;
  final String deletedBy;
  final DateTime deletedDate;
  CheckInFlowEntry(
      {this.templateCode,
      this.templateName,
      this.stepName,
      this.stepCode,
      this.stepType,
      this.visitorType,
      this.isRequired,
      this.sort,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.deletedBy,
      this.deletedDate});
  factory CheckInFlowEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CheckInFlowEntry(
      templateCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}template_code']),
      templateName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}template_name']),
      stepName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}step_name']),
      stepCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}step_code']),
      stepType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}step_type']),
      visitorType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visitor_type']),
      isRequired: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_required']),
      sort: stringType.mapFromDatabaseResponse(data['${effectivePrefix}sort']),
      createdBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      updatedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_by']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
      deletedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_by']),
      deletedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || templateCode != null) {
      map['template_code'] = Variable<String>(templateCode);
    }
    if (!nullToAbsent || templateName != null) {
      map['template_name'] = Variable<String>(templateName);
    }
    if (!nullToAbsent || stepName != null) {
      map['step_name'] = Variable<String>(stepName);
    }
    if (!nullToAbsent || stepCode != null) {
      map['step_code'] = Variable<String>(stepCode);
    }
    if (!nullToAbsent || stepType != null) {
      map['step_type'] = Variable<String>(stepType);
    }
    if (!nullToAbsent || visitorType != null) {
      map['visitor_type'] = Variable<String>(visitorType);
    }
    if (!nullToAbsent || isRequired != null) {
      map['is_required'] = Variable<int>(isRequired);
    }
    if (!nullToAbsent || sort != null) {
      map['sort'] = Variable<String>(sort);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || updatedDate != null) {
      map['updated_date'] = Variable<DateTime>(updatedDate);
    }
    if (!nullToAbsent || deletedBy != null) {
      map['deleted_by'] = Variable<String>(deletedBy);
    }
    if (!nullToAbsent || deletedDate != null) {
      map['deleted_date'] = Variable<DateTime>(deletedDate);
    }
    return map;
  }

  CheckInFlowEntityCompanion toCompanion(bool nullToAbsent) {
    return CheckInFlowEntityCompanion(
      templateCode: templateCode == null && nullToAbsent
          ? const Value.absent()
          : Value(templateCode),
      templateName: templateName == null && nullToAbsent
          ? const Value.absent()
          : Value(templateName),
      stepName: stepName == null && nullToAbsent
          ? const Value.absent()
          : Value(stepName),
      stepCode: stepCode == null && nullToAbsent
          ? const Value.absent()
          : Value(stepCode),
      stepType: stepType == null && nullToAbsent
          ? const Value.absent()
          : Value(stepType),
      visitorType: visitorType == null && nullToAbsent
          ? const Value.absent()
          : Value(visitorType),
      isRequired: isRequired == null && nullToAbsent
          ? const Value.absent()
          : Value(isRequired),
      sort: sort == null && nullToAbsent ? const Value.absent() : Value(sort),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
      deletedBy: deletedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedBy),
      deletedDate: deletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedDate),
    );
  }

  factory CheckInFlowEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CheckInFlowEntry(
      templateCode: serializer.fromJson<String>(json['templateCode']),
      templateName: serializer.fromJson<String>(json['templateName']),
      stepName: serializer.fromJson<String>(json['stepName']),
      stepCode: serializer.fromJson<String>(json['stepCode']),
      stepType: serializer.fromJson<String>(json['stepType']),
      visitorType: serializer.fromJson<String>(json['visitorType']),
      isRequired: serializer.fromJson<int>(json['isRequired']),
      sort: serializer.fromJson<String>(json['sort']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      deletedBy: serializer.fromJson<String>(json['deletedBy']),
      deletedDate: serializer.fromJson<DateTime>(json['deletedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'templateCode': serializer.toJson<String>(templateCode),
      'templateName': serializer.toJson<String>(templateName),
      'stepName': serializer.toJson<String>(stepName),
      'stepCode': serializer.toJson<String>(stepCode),
      'stepType': serializer.toJson<String>(stepType),
      'visitorType': serializer.toJson<String>(visitorType),
      'isRequired': serializer.toJson<int>(isRequired),
      'sort': serializer.toJson<String>(sort),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'deletedBy': serializer.toJson<String>(deletedBy),
      'deletedDate': serializer.toJson<DateTime>(deletedDate),
    };
  }

  CheckInFlowEntry copyWith(
          {String templateCode,
          String templateName,
          String stepName,
          String stepCode,
          String stepType,
          String visitorType,
          int isRequired,
          String sort,
          String createdBy,
          DateTime createdDate,
          String updatedBy,
          DateTime updatedDate,
          String deletedBy,
          DateTime deletedDate}) =>
      CheckInFlowEntry(
        templateCode: templateCode ?? this.templateCode,
        templateName: templateName ?? this.templateName,
        stepName: stepName ?? this.stepName,
        stepCode: stepCode ?? this.stepCode,
        stepType: stepType ?? this.stepType,
        visitorType: visitorType ?? this.visitorType,
        isRequired: isRequired ?? this.isRequired,
        sort: sort ?? this.sort,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedDate: deletedDate ?? this.deletedDate,
      );
  @override
  String toString() {
    return (StringBuffer('CheckInFlowEntry(')
          ..write('templateCode: $templateCode, ')
          ..write('templateName: $templateName, ')
          ..write('stepName: $stepName, ')
          ..write('stepCode: $stepCode, ')
          ..write('stepType: $stepType, ')
          ..write('visitorType: $visitorType, ')
          ..write('isRequired: $isRequired, ')
          ..write('sort: $sort, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      templateCode.hashCode,
      $mrjc(
          templateName.hashCode,
          $mrjc(
              stepName.hashCode,
              $mrjc(
                  stepCode.hashCode,
                  $mrjc(
                      stepType.hashCode,
                      $mrjc(
                          visitorType.hashCode,
                          $mrjc(
                              isRequired.hashCode,
                              $mrjc(
                                  sort.hashCode,
                                  $mrjc(
                                      createdBy.hashCode,
                                      $mrjc(
                                          createdDate.hashCode,
                                          $mrjc(
                                              updatedBy.hashCode,
                                              $mrjc(
                                                  updatedDate.hashCode,
                                                  $mrjc(
                                                      deletedBy.hashCode,
                                                      deletedDate
                                                          .hashCode))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CheckInFlowEntry &&
          other.templateCode == this.templateCode &&
          other.templateName == this.templateName &&
          other.stepName == this.stepName &&
          other.stepCode == this.stepCode &&
          other.stepType == this.stepType &&
          other.visitorType == this.visitorType &&
          other.isRequired == this.isRequired &&
          other.sort == this.sort &&
          other.createdBy == this.createdBy &&
          other.createdDate == this.createdDate &&
          other.updatedBy == this.updatedBy &&
          other.updatedDate == this.updatedDate &&
          other.deletedBy == this.deletedBy &&
          other.deletedDate == this.deletedDate);
}

class CheckInFlowEntityCompanion extends UpdateCompanion<CheckInFlowEntry> {
  final Value<String> templateCode;
  final Value<String> templateName;
  final Value<String> stepName;
  final Value<String> stepCode;
  final Value<String> stepType;
  final Value<String> visitorType;
  final Value<int> isRequired;
  final Value<String> sort;
  final Value<String> createdBy;
  final Value<DateTime> createdDate;
  final Value<String> updatedBy;
  final Value<DateTime> updatedDate;
  final Value<String> deletedBy;
  final Value<DateTime> deletedDate;
  const CheckInFlowEntityCompanion({
    this.templateCode = const Value.absent(),
    this.templateName = const Value.absent(),
    this.stepName = const Value.absent(),
    this.stepCode = const Value.absent(),
    this.stepType = const Value.absent(),
    this.visitorType = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.sort = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  });
  CheckInFlowEntityCompanion.insert({
    this.templateCode = const Value.absent(),
    this.templateName = const Value.absent(),
    this.stepName = const Value.absent(),
    this.stepCode = const Value.absent(),
    this.stepType = const Value.absent(),
    this.visitorType = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.sort = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  });
  static Insertable<CheckInFlowEntry> custom({
    Expression<String> templateCode,
    Expression<String> templateName,
    Expression<String> stepName,
    Expression<String> stepCode,
    Expression<String> stepType,
    Expression<String> visitorType,
    Expression<int> isRequired,
    Expression<String> sort,
    Expression<String> createdBy,
    Expression<DateTime> createdDate,
    Expression<String> updatedBy,
    Expression<DateTime> updatedDate,
    Expression<String> deletedBy,
    Expression<DateTime> deletedDate,
  }) {
    return RawValuesInsertable({
      if (templateCode != null) 'template_code': templateCode,
      if (templateName != null) 'template_name': templateName,
      if (stepName != null) 'step_name': stepName,
      if (stepCode != null) 'step_code': stepCode,
      if (stepType != null) 'step_type': stepType,
      if (visitorType != null) 'visitor_type': visitorType,
      if (isRequired != null) 'is_required': isRequired,
      if (sort != null) 'sort': sort,
      if (createdBy != null) 'created_by': createdBy,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (deletedBy != null) 'deleted_by': deletedBy,
      if (deletedDate != null) 'deleted_date': deletedDate,
    });
  }

  CheckInFlowEntityCompanion copyWith(
      {Value<String> templateCode,
      Value<String> templateName,
      Value<String> stepName,
      Value<String> stepCode,
      Value<String> stepType,
      Value<String> visitorType,
      Value<int> isRequired,
      Value<String> sort,
      Value<String> createdBy,
      Value<DateTime> createdDate,
      Value<String> updatedBy,
      Value<DateTime> updatedDate,
      Value<String> deletedBy,
      Value<DateTime> deletedDate}) {
    return CheckInFlowEntityCompanion(
      templateCode: templateCode ?? this.templateCode,
      templateName: templateName ?? this.templateName,
      stepName: stepName ?? this.stepName,
      stepCode: stepCode ?? this.stepCode,
      stepType: stepType ?? this.stepType,
      visitorType: visitorType ?? this.visitorType,
      isRequired: isRequired ?? this.isRequired,
      sort: sort ?? this.sort,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedDate: deletedDate ?? this.deletedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (templateCode.present) {
      map['template_code'] = Variable<String>(templateCode.value);
    }
    if (templateName.present) {
      map['template_name'] = Variable<String>(templateName.value);
    }
    if (stepName.present) {
      map['step_name'] = Variable<String>(stepName.value);
    }
    if (stepCode.present) {
      map['step_code'] = Variable<String>(stepCode.value);
    }
    if (stepType.present) {
      map['step_type'] = Variable<String>(stepType.value);
    }
    if (visitorType.present) {
      map['visitor_type'] = Variable<String>(visitorType.value);
    }
    if (isRequired.present) {
      map['is_required'] = Variable<int>(isRequired.value);
    }
    if (sort.present) {
      map['sort'] = Variable<String>(sort.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (deletedBy.present) {
      map['deleted_by'] = Variable<String>(deletedBy.value);
    }
    if (deletedDate.present) {
      map['deleted_date'] = Variable<DateTime>(deletedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInFlowEntityCompanion(')
          ..write('templateCode: $templateCode, ')
          ..write('templateName: $templateName, ')
          ..write('stepName: $stepName, ')
          ..write('stepCode: $stepCode, ')
          ..write('stepType: $stepType, ')
          ..write('visitorType: $visitorType, ')
          ..write('isRequired: $isRequired, ')
          ..write('sort: $sort, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }
}

class $CheckInFlowEntityTable extends CheckInFlowEntity
    with TableInfo<$CheckInFlowEntityTable, CheckInFlowEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $CheckInFlowEntityTable(this._db, [this._alias]);
  final VerificationMeta _templateCodeMeta =
      const VerificationMeta('templateCode');
  GeneratedTextColumn _templateCode;
  @override
  GeneratedTextColumn get templateCode =>
      _templateCode ??= _constructTemplateCode();
  GeneratedTextColumn _constructTemplateCode() {
    return GeneratedTextColumn(
      'template_code',
      $tableName,
      true,
    );
  }

  final VerificationMeta _templateNameMeta =
      const VerificationMeta('templateName');
  GeneratedTextColumn _templateName;
  @override
  GeneratedTextColumn get templateName =>
      _templateName ??= _constructTemplateName();
  GeneratedTextColumn _constructTemplateName() {
    return GeneratedTextColumn(
      'template_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stepNameMeta = const VerificationMeta('stepName');
  GeneratedTextColumn _stepName;
  @override
  GeneratedTextColumn get stepName => _stepName ??= _constructStepName();
  GeneratedTextColumn _constructStepName() {
    return GeneratedTextColumn(
      'step_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stepCodeMeta = const VerificationMeta('stepCode');
  GeneratedTextColumn _stepCode;
  @override
  GeneratedTextColumn get stepCode => _stepCode ??= _constructStepCode();
  GeneratedTextColumn _constructStepCode() {
    return GeneratedTextColumn(
      'step_code',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stepTypeMeta = const VerificationMeta('stepType');
  GeneratedTextColumn _stepType;
  @override
  GeneratedTextColumn get stepType => _stepType ??= _constructStepType();
  GeneratedTextColumn _constructStepType() {
    return GeneratedTextColumn(
      'step_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _visitorTypeMeta =
      const VerificationMeta('visitorType');
  GeneratedTextColumn _visitorType;
  @override
  GeneratedTextColumn get visitorType =>
      _visitorType ??= _constructVisitorType();
  GeneratedTextColumn _constructVisitorType() {
    return GeneratedTextColumn(
      'visitor_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isRequiredMeta = const VerificationMeta('isRequired');
  GeneratedIntColumn _isRequired;
  @override
  GeneratedIntColumn get isRequired => _isRequired ??= _constructIsRequired();
  GeneratedIntColumn _constructIsRequired() {
    return GeneratedIntColumn(
      'is_required',
      $tableName,
      true,
    );
  }

  final VerificationMeta _sortMeta = const VerificationMeta('sort');
  GeneratedTextColumn _sort;
  @override
  GeneratedTextColumn get sort => _sort ??= _constructSort();
  GeneratedTextColumn _constructSort() {
    return GeneratedTextColumn(
      'sort',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedTextColumn _createdBy;
  @override
  GeneratedTextColumn get createdBy => _createdBy ??= _constructCreatedBy();
  GeneratedTextColumn _constructCreatedBy() {
    return GeneratedTextColumn(
      'created_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedByMeta = const VerificationMeta('updatedBy');
  GeneratedTextColumn _updatedBy;
  @override
  GeneratedTextColumn get updatedBy => _updatedBy ??= _constructUpdatedBy();
  GeneratedTextColumn _constructUpdatedBy() {
    return GeneratedTextColumn(
      'updated_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedByMeta = const VerificationMeta('deletedBy');
  GeneratedTextColumn _deletedBy;
  @override
  GeneratedTextColumn get deletedBy => _deletedBy ??= _constructDeletedBy();
  GeneratedTextColumn _constructDeletedBy() {
    return GeneratedTextColumn(
      'deleted_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedDateMeta =
      const VerificationMeta('deletedDate');
  GeneratedDateTimeColumn _deletedDate;
  @override
  GeneratedDateTimeColumn get deletedDate =>
      _deletedDate ??= _constructDeletedDate();
  GeneratedDateTimeColumn _constructDeletedDate() {
    return GeneratedDateTimeColumn(
      'deleted_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        templateCode,
        templateName,
        stepName,
        stepCode,
        stepType,
        visitorType,
        isRequired,
        sort,
        createdBy,
        createdDate,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate
      ];
  @override
  $CheckInFlowEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_check_in_flow';
  @override
  final String actualTableName = 'cip_check_in_flow';
  @override
  VerificationContext validateIntegrity(Insertable<CheckInFlowEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('template_code')) {
      context.handle(
          _templateCodeMeta,
          templateCode.isAcceptableOrUnknown(
              data['template_code'], _templateCodeMeta));
    }
    if (data.containsKey('template_name')) {
      context.handle(
          _templateNameMeta,
          templateName.isAcceptableOrUnknown(
              data['template_name'], _templateNameMeta));
    }
    if (data.containsKey('step_name')) {
      context.handle(_stepNameMeta,
          stepName.isAcceptableOrUnknown(data['step_name'], _stepNameMeta));
    }
    if (data.containsKey('step_code')) {
      context.handle(_stepCodeMeta,
          stepCode.isAcceptableOrUnknown(data['step_code'], _stepCodeMeta));
    }
    if (data.containsKey('step_type')) {
      context.handle(_stepTypeMeta,
          stepType.isAcceptableOrUnknown(data['step_type'], _stepTypeMeta));
    }
    if (data.containsKey('visitor_type')) {
      context.handle(
          _visitorTypeMeta,
          visitorType.isAcceptableOrUnknown(
              data['visitor_type'], _visitorTypeMeta));
    }
    if (data.containsKey('is_required')) {
      context.handle(
          _isRequiredMeta,
          isRequired.isAcceptableOrUnknown(
              data['is_required'], _isRequiredMeta));
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort'], _sortMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by'], _updatedByMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date'], _updatedDateMeta));
    }
    if (data.containsKey('deleted_by')) {
      context.handle(_deletedByMeta,
          deletedBy.isAcceptableOrUnknown(data['deleted_by'], _deletedByMeta));
    }
    if (data.containsKey('deleted_date')) {
      context.handle(
          _deletedDateMeta,
          deletedDate.isAcceptableOrUnknown(
              data['deleted_date'], _deletedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  CheckInFlowEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CheckInFlowEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CheckInFlowEntityTable createAlias(String alias) {
    return $CheckInFlowEntityTable(_db, alias);
  }
}

class VisitorLogEntry extends DataClass implements Insertable<VisitorLogEntry> {
  final String id;
  final String visitorId;
  final String logId;
  final DateTime signIn;
  final DateTime signOut;
  final double companyId;
  final double branchId;
  final int signOutBy;
  final String signOutType;
  final String checkOutTimeExpected;
  final String customStep;
  final String feedBack;
  final double rating;
  final String cardNo;
  final String goods;
  final String receiver;
  final String visitorPosition;
  final String imageIdPath;
  final double idCardRepoId;
  final double surveyId;
  final String idCardFile;
  final String createdBy;
  final DateTime createdDate;
  final String updatedBy;
  final DateTime updatedDate;
  final String deletedBy;
  final DateTime deletedDate;
  final String survey;
  final int gender;
  final String passportNo;
  final String nationality;
  final String birthDay;
  final String permanentAddress;
  final String departmentRoomNo;
  VisitorLogEntry(
      {@required this.id,
      @required this.visitorId,
      @required this.logId,
      this.signIn,
      this.signOut,
      this.companyId,
      this.branchId,
      this.signOutBy,
      this.signOutType,
      this.checkOutTimeExpected,
      this.customStep,
      this.feedBack,
      this.rating,
      this.cardNo,
      this.goods,
      this.receiver,
      this.visitorPosition,
      this.imageIdPath,
      this.idCardRepoId,
      this.surveyId,
      this.idCardFile,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.deletedBy,
      this.deletedDate,
      this.survey,
      this.gender,
      this.passportNo,
      this.nationality,
      this.birthDay,
      this.permanentAddress,
      this.departmentRoomNo});
  factory VisitorLogEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    return VisitorLogEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      visitorId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visitor_id']),
      logId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}log_id']),
      signIn: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}sign_in']),
      signOut: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}sign_out']),
      companyId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_id']),
      branchId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}branch_id']),
      signOutBy: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}sign_out_by']),
      signOutType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sign_out_type']),
      checkOutTimeExpected: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}check_out_time_expected']),
      customStep: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}custom_step']),
      feedBack: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}feed_back']),
      rating:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}rating']),
      cardNo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}card_no']),
      goods:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}goods']),
      receiver: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}receiver']),
      visitorPosition: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visitor_position']),
      imageIdPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_id_path']),
      idCardRepoId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_card_repo_id']),
      surveyId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}survey_id']),
      idCardFile: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_card_file']),
      createdBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      updatedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_by']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
      deletedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_by']),
      deletedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_date']),
      survey:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}survey']),
      gender: intType.mapFromDatabaseResponse(data['${effectivePrefix}gender']),
      passportNo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}passport_no']),
      nationality: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}nationality']),
      birthDay: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}birth_day']),
      permanentAddress: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}permanent_address']),
      departmentRoomNo: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}department_room_no']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || visitorId != null) {
      map['visitor_id'] = Variable<String>(visitorId);
    }
    if (!nullToAbsent || logId != null) {
      map['log_id'] = Variable<String>(logId);
    }
    if (!nullToAbsent || signIn != null) {
      map['sign_in'] = Variable<DateTime>(signIn);
    }
    if (!nullToAbsent || signOut != null) {
      map['sign_out'] = Variable<DateTime>(signOut);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<double>(companyId);
    }
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<double>(branchId);
    }
    if (!nullToAbsent || signOutBy != null) {
      map['sign_out_by'] = Variable<int>(signOutBy);
    }
    if (!nullToAbsent || signOutType != null) {
      map['sign_out_type'] = Variable<String>(signOutType);
    }
    if (!nullToAbsent || checkOutTimeExpected != null) {
      map['check_out_time_expected'] = Variable<String>(checkOutTimeExpected);
    }
    if (!nullToAbsent || customStep != null) {
      map['custom_step'] = Variable<String>(customStep);
    }
    if (!nullToAbsent || feedBack != null) {
      map['feed_back'] = Variable<String>(feedBack);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    if (!nullToAbsent || cardNo != null) {
      map['card_no'] = Variable<String>(cardNo);
    }
    if (!nullToAbsent || goods != null) {
      map['goods'] = Variable<String>(goods);
    }
    if (!nullToAbsent || receiver != null) {
      map['receiver'] = Variable<String>(receiver);
    }
    if (!nullToAbsent || visitorPosition != null) {
      map['visitor_position'] = Variable<String>(visitorPosition);
    }
    if (!nullToAbsent || imageIdPath != null) {
      map['image_id_path'] = Variable<String>(imageIdPath);
    }
    if (!nullToAbsent || idCardRepoId != null) {
      map['id_card_repo_id'] = Variable<double>(idCardRepoId);
    }
    if (!nullToAbsent || surveyId != null) {
      map['survey_id'] = Variable<double>(surveyId);
    }
    if (!nullToAbsent || idCardFile != null) {
      map['id_card_file'] = Variable<String>(idCardFile);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || updatedDate != null) {
      map['updated_date'] = Variable<DateTime>(updatedDate);
    }
    if (!nullToAbsent || deletedBy != null) {
      map['deleted_by'] = Variable<String>(deletedBy);
    }
    if (!nullToAbsent || deletedDate != null) {
      map['deleted_date'] = Variable<DateTime>(deletedDate);
    }
    if (!nullToAbsent || survey != null) {
      map['survey'] = Variable<String>(survey);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<int>(gender);
    }
    if (!nullToAbsent || passportNo != null) {
      map['passport_no'] = Variable<String>(passportNo);
    }
    if (!nullToAbsent || nationality != null) {
      map['nationality'] = Variable<String>(nationality);
    }
    if (!nullToAbsent || birthDay != null) {
      map['birth_day'] = Variable<String>(birthDay);
    }
    if (!nullToAbsent || permanentAddress != null) {
      map['permanent_address'] = Variable<String>(permanentAddress);
    }
    if (!nullToAbsent || departmentRoomNo != null) {
      map['department_room_no'] = Variable<String>(departmentRoomNo);
    }
    return map;
  }

  VisitorLogEntityCompanion toCompanion(bool nullToAbsent) {
    return VisitorLogEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      visitorId: visitorId == null && nullToAbsent
          ? const Value.absent()
          : Value(visitorId),
      logId:
          logId == null && nullToAbsent ? const Value.absent() : Value(logId),
      signIn:
          signIn == null && nullToAbsent ? const Value.absent() : Value(signIn),
      signOut: signOut == null && nullToAbsent
          ? const Value.absent()
          : Value(signOut),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      signOutBy: signOutBy == null && nullToAbsent
          ? const Value.absent()
          : Value(signOutBy),
      signOutType: signOutType == null && nullToAbsent
          ? const Value.absent()
          : Value(signOutType),
      checkOutTimeExpected: checkOutTimeExpected == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOutTimeExpected),
      customStep: customStep == null && nullToAbsent
          ? const Value.absent()
          : Value(customStep),
      feedBack: feedBack == null && nullToAbsent
          ? const Value.absent()
          : Value(feedBack),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      cardNo:
          cardNo == null && nullToAbsent ? const Value.absent() : Value(cardNo),
      goods:
          goods == null && nullToAbsent ? const Value.absent() : Value(goods),
      receiver: receiver == null && nullToAbsent
          ? const Value.absent()
          : Value(receiver),
      visitorPosition: visitorPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(visitorPosition),
      imageIdPath: imageIdPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imageIdPath),
      idCardRepoId: idCardRepoId == null && nullToAbsent
          ? const Value.absent()
          : Value(idCardRepoId),
      surveyId: surveyId == null && nullToAbsent
          ? const Value.absent()
          : Value(surveyId),
      idCardFile: idCardFile == null && nullToAbsent
          ? const Value.absent()
          : Value(idCardFile),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
      deletedBy: deletedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedBy),
      deletedDate: deletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedDate),
      survey:
          survey == null && nullToAbsent ? const Value.absent() : Value(survey),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      passportNo: passportNo == null && nullToAbsent
          ? const Value.absent()
          : Value(passportNo),
      nationality: nationality == null && nullToAbsent
          ? const Value.absent()
          : Value(nationality),
      birthDay: birthDay == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDay),
      permanentAddress: permanentAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(permanentAddress),
      departmentRoomNo: departmentRoomNo == null && nullToAbsent
          ? const Value.absent()
          : Value(departmentRoomNo),
    );
  }

  factory VisitorLogEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VisitorLogEntry(
      id: serializer.fromJson<String>(json['id']),
      visitorId: serializer.fromJson<String>(json['visitorId']),
      logId: serializer.fromJson<String>(json['logId']),
      signIn: serializer.fromJson<DateTime>(json['signIn']),
      signOut: serializer.fromJson<DateTime>(json['signOut']),
      companyId: serializer.fromJson<double>(json['companyId']),
      branchId: serializer.fromJson<double>(json['branchId']),
      signOutBy: serializer.fromJson<int>(json['signOutBy']),
      signOutType: serializer.fromJson<String>(json['signOutType']),
      checkOutTimeExpected:
          serializer.fromJson<String>(json['checkOutTimeExpected']),
      customStep: serializer.fromJson<String>(json['customStep']),
      feedBack: serializer.fromJson<String>(json['feedBack']),
      rating: serializer.fromJson<double>(json['rating']),
      cardNo: serializer.fromJson<String>(json['cardNo']),
      goods: serializer.fromJson<String>(json['goods']),
      receiver: serializer.fromJson<String>(json['receiver']),
      visitorPosition: serializer.fromJson<String>(json['visitorPosition']),
      imageIdPath: serializer.fromJson<String>(json['imageIdPath']),
      idCardRepoId: serializer.fromJson<double>(json['idCardRepoId']),
      surveyId: serializer.fromJson<double>(json['surveyId']),
      idCardFile: serializer.fromJson<String>(json['idCardFile']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      deletedBy: serializer.fromJson<String>(json['deletedBy']),
      deletedDate: serializer.fromJson<DateTime>(json['deletedDate']),
      survey: serializer.fromJson<String>(json['survey']),
      gender: serializer.fromJson<int>(json['gender']),
      passportNo: serializer.fromJson<String>(json['passportNo']),
      nationality: serializer.fromJson<String>(json['nationality']),
      birthDay: serializer.fromJson<String>(json['birthDay']),
      permanentAddress: serializer.fromJson<String>(json['permanentAddress']),
      departmentRoomNo: serializer.fromJson<String>(json['departmentRoomNo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'visitorId': serializer.toJson<String>(visitorId),
      'logId': serializer.toJson<String>(logId),
      'signIn': serializer.toJson<DateTime>(signIn),
      'signOut': serializer.toJson<DateTime>(signOut),
      'companyId': serializer.toJson<double>(companyId),
      'branchId': serializer.toJson<double>(branchId),
      'signOutBy': serializer.toJson<int>(signOutBy),
      'signOutType': serializer.toJson<String>(signOutType),
      'checkOutTimeExpected': serializer.toJson<String>(checkOutTimeExpected),
      'customStep': serializer.toJson<String>(customStep),
      'feedBack': serializer.toJson<String>(feedBack),
      'rating': serializer.toJson<double>(rating),
      'cardNo': serializer.toJson<String>(cardNo),
      'goods': serializer.toJson<String>(goods),
      'receiver': serializer.toJson<String>(receiver),
      'visitorPosition': serializer.toJson<String>(visitorPosition),
      'imageIdPath': serializer.toJson<String>(imageIdPath),
      'idCardRepoId': serializer.toJson<double>(idCardRepoId),
      'surveyId': serializer.toJson<double>(surveyId),
      'idCardFile': serializer.toJson<String>(idCardFile),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'deletedBy': serializer.toJson<String>(deletedBy),
      'deletedDate': serializer.toJson<DateTime>(deletedDate),
      'survey': serializer.toJson<String>(survey),
      'gender': serializer.toJson<int>(gender),
      'passportNo': serializer.toJson<String>(passportNo),
      'nationality': serializer.toJson<String>(nationality),
      'birthDay': serializer.toJson<String>(birthDay),
      'permanentAddress': serializer.toJson<String>(permanentAddress),
      'departmentRoomNo': serializer.toJson<String>(departmentRoomNo),
    };
  }

  VisitorLogEntry copyWith(
          {String id,
          String visitorId,
          String logId,
          DateTime signIn,
          DateTime signOut,
          double companyId,
          double branchId,
          int signOutBy,
          String signOutType,
          String checkOutTimeExpected,
          String customStep,
          String feedBack,
          double rating,
          String cardNo,
          String goods,
          String receiver,
          String visitorPosition,
          String imageIdPath,
          double idCardRepoId,
          double surveyId,
          String idCardFile,
          String createdBy,
          DateTime createdDate,
          String updatedBy,
          DateTime updatedDate,
          String deletedBy,
          DateTime deletedDate,
          String survey,
          int gender,
          String passportNo,
          String nationality,
          String birthDay,
          String permanentAddress,
          String departmentRoomNo}) =>
      VisitorLogEntry(
        id: id ?? this.id,
        visitorId: visitorId ?? this.visitorId,
        logId: logId ?? this.logId,
        signIn: signIn ?? this.signIn,
        signOut: signOut ?? this.signOut,
        companyId: companyId ?? this.companyId,
        branchId: branchId ?? this.branchId,
        signOutBy: signOutBy ?? this.signOutBy,
        signOutType: signOutType ?? this.signOutType,
        checkOutTimeExpected: checkOutTimeExpected ?? this.checkOutTimeExpected,
        customStep: customStep ?? this.customStep,
        feedBack: feedBack ?? this.feedBack,
        rating: rating ?? this.rating,
        cardNo: cardNo ?? this.cardNo,
        goods: goods ?? this.goods,
        receiver: receiver ?? this.receiver,
        visitorPosition: visitorPosition ?? this.visitorPosition,
        imageIdPath: imageIdPath ?? this.imageIdPath,
        idCardRepoId: idCardRepoId ?? this.idCardRepoId,
        surveyId: surveyId ?? this.surveyId,
        idCardFile: idCardFile ?? this.idCardFile,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedDate: deletedDate ?? this.deletedDate,
        survey: survey ?? this.survey,
        gender: gender ?? this.gender,
        passportNo: passportNo ?? this.passportNo,
        nationality: nationality ?? this.nationality,
        birthDay: birthDay ?? this.birthDay,
        permanentAddress: permanentAddress ?? this.permanentAddress,
        departmentRoomNo: departmentRoomNo ?? this.departmentRoomNo,
      );
  @override
  String toString() {
    return (StringBuffer('VisitorLogEntry(')
          ..write('id: $id, ')
          ..write('visitorId: $visitorId, ')
          ..write('logId: $logId, ')
          ..write('signIn: $signIn, ')
          ..write('signOut: $signOut, ')
          ..write('companyId: $companyId, ')
          ..write('branchId: $branchId, ')
          ..write('signOutBy: $signOutBy, ')
          ..write('signOutType: $signOutType, ')
          ..write('checkOutTimeExpected: $checkOutTimeExpected, ')
          ..write('customStep: $customStep, ')
          ..write('feedBack: $feedBack, ')
          ..write('rating: $rating, ')
          ..write('cardNo: $cardNo, ')
          ..write('goods: $goods, ')
          ..write('receiver: $receiver, ')
          ..write('visitorPosition: $visitorPosition, ')
          ..write('imageIdPath: $imageIdPath, ')
          ..write('idCardRepoId: $idCardRepoId, ')
          ..write('surveyId: $surveyId, ')
          ..write('idCardFile: $idCardFile, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate, ')
          ..write('survey: $survey, ')
          ..write('gender: $gender, ')
          ..write('passportNo: $passportNo, ')
          ..write('nationality: $nationality, ')
          ..write('birthDay: $birthDay, ')
          ..write('permanentAddress: $permanentAddress, ')
          ..write('departmentRoomNo: $departmentRoomNo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          visitorId.hashCode,
          $mrjc(
              logId.hashCode,
              $mrjc(
                  signIn.hashCode,
                  $mrjc(
                      signOut.hashCode,
                      $mrjc(
                          companyId.hashCode,
                          $mrjc(
                              branchId.hashCode,
                              $mrjc(
                                  signOutBy.hashCode,
                                  $mrjc(
                                      signOutType.hashCode,
                                      $mrjc(
                                          checkOutTimeExpected.hashCode,
                                          $mrjc(
                                              customStep.hashCode,
                                              $mrjc(
                                                  feedBack.hashCode,
                                                  $mrjc(
                                                      rating.hashCode,
                                                      $mrjc(
                                                          cardNo.hashCode,
                                                          $mrjc(
                                                              goods.hashCode,
                                                              $mrjc(
                                                                  receiver
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      visitorPosition
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          imageIdPath
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              idCardRepoId.hashCode,
                                                                              $mrjc(surveyId.hashCode, $mrjc(idCardFile.hashCode, $mrjc(createdBy.hashCode, $mrjc(createdDate.hashCode, $mrjc(updatedBy.hashCode, $mrjc(updatedDate.hashCode, $mrjc(deletedBy.hashCode, $mrjc(deletedDate.hashCode, $mrjc(survey.hashCode, $mrjc(gender.hashCode, $mrjc(passportNo.hashCode, $mrjc(nationality.hashCode, $mrjc(birthDay.hashCode, $mrjc(permanentAddress.hashCode, departmentRoomNo.hashCode))))))))))))))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is VisitorLogEntry &&
          other.id == this.id &&
          other.visitorId == this.visitorId &&
          other.logId == this.logId &&
          other.signIn == this.signIn &&
          other.signOut == this.signOut &&
          other.companyId == this.companyId &&
          other.branchId == this.branchId &&
          other.signOutBy == this.signOutBy &&
          other.signOutType == this.signOutType &&
          other.checkOutTimeExpected == this.checkOutTimeExpected &&
          other.customStep == this.customStep &&
          other.feedBack == this.feedBack &&
          other.rating == this.rating &&
          other.cardNo == this.cardNo &&
          other.goods == this.goods &&
          other.receiver == this.receiver &&
          other.visitorPosition == this.visitorPosition &&
          other.imageIdPath == this.imageIdPath &&
          other.idCardRepoId == this.idCardRepoId &&
          other.surveyId == this.surveyId &&
          other.idCardFile == this.idCardFile &&
          other.createdBy == this.createdBy &&
          other.createdDate == this.createdDate &&
          other.updatedBy == this.updatedBy &&
          other.updatedDate == this.updatedDate &&
          other.deletedBy == this.deletedBy &&
          other.deletedDate == this.deletedDate &&
          other.survey == this.survey &&
          other.gender == this.gender &&
          other.passportNo == this.passportNo &&
          other.nationality == this.nationality &&
          other.birthDay == this.birthDay &&
          other.permanentAddress == this.permanentAddress &&
          other.departmentRoomNo == this.departmentRoomNo);
}

class VisitorLogEntityCompanion extends UpdateCompanion<VisitorLogEntry> {
  final Value<String> id;
  final Value<String> visitorId;
  final Value<String> logId;
  final Value<DateTime> signIn;
  final Value<DateTime> signOut;
  final Value<double> companyId;
  final Value<double> branchId;
  final Value<int> signOutBy;
  final Value<String> signOutType;
  final Value<String> checkOutTimeExpected;
  final Value<String> customStep;
  final Value<String> feedBack;
  final Value<double> rating;
  final Value<String> cardNo;
  final Value<String> goods;
  final Value<String> receiver;
  final Value<String> visitorPosition;
  final Value<String> imageIdPath;
  final Value<double> idCardRepoId;
  final Value<double> surveyId;
  final Value<String> idCardFile;
  final Value<String> createdBy;
  final Value<DateTime> createdDate;
  final Value<String> updatedBy;
  final Value<DateTime> updatedDate;
  final Value<String> deletedBy;
  final Value<DateTime> deletedDate;
  final Value<String> survey;
  final Value<int> gender;
  final Value<String> passportNo;
  final Value<String> nationality;
  final Value<String> birthDay;
  final Value<String> permanentAddress;
  final Value<String> departmentRoomNo;
  const VisitorLogEntityCompanion({
    this.id = const Value.absent(),
    this.visitorId = const Value.absent(),
    this.logId = const Value.absent(),
    this.signIn = const Value.absent(),
    this.signOut = const Value.absent(),
    this.companyId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.signOutBy = const Value.absent(),
    this.signOutType = const Value.absent(),
    this.checkOutTimeExpected = const Value.absent(),
    this.customStep = const Value.absent(),
    this.feedBack = const Value.absent(),
    this.rating = const Value.absent(),
    this.cardNo = const Value.absent(),
    this.goods = const Value.absent(),
    this.receiver = const Value.absent(),
    this.visitorPosition = const Value.absent(),
    this.imageIdPath = const Value.absent(),
    this.idCardRepoId = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.idCardFile = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
    this.survey = const Value.absent(),
    this.gender = const Value.absent(),
    this.passportNo = const Value.absent(),
    this.nationality = const Value.absent(),
    this.birthDay = const Value.absent(),
    this.permanentAddress = const Value.absent(),
    this.departmentRoomNo = const Value.absent(),
  });
  VisitorLogEntityCompanion.insert({
    this.id = const Value.absent(),
    @required String visitorId,
    this.logId = const Value.absent(),
    this.signIn = const Value.absent(),
    this.signOut = const Value.absent(),
    this.companyId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.signOutBy = const Value.absent(),
    this.signOutType = const Value.absent(),
    this.checkOutTimeExpected = const Value.absent(),
    this.customStep = const Value.absent(),
    this.feedBack = const Value.absent(),
    this.rating = const Value.absent(),
    this.cardNo = const Value.absent(),
    this.goods = const Value.absent(),
    this.receiver = const Value.absent(),
    this.visitorPosition = const Value.absent(),
    this.imageIdPath = const Value.absent(),
    this.idCardRepoId = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.idCardFile = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
    this.survey = const Value.absent(),
    this.gender = const Value.absent(),
    this.passportNo = const Value.absent(),
    this.nationality = const Value.absent(),
    this.birthDay = const Value.absent(),
    this.permanentAddress = const Value.absent(),
    this.departmentRoomNo = const Value.absent(),
  }) : visitorId = Value(visitorId);
  static Insertable<VisitorLogEntry> custom({
    Expression<String> id,
    Expression<String> visitorId,
    Expression<String> logId,
    Expression<DateTime> signIn,
    Expression<DateTime> signOut,
    Expression<double> companyId,
    Expression<double> branchId,
    Expression<int> signOutBy,
    Expression<String> signOutType,
    Expression<String> checkOutTimeExpected,
    Expression<String> customStep,
    Expression<String> feedBack,
    Expression<double> rating,
    Expression<String> cardNo,
    Expression<String> goods,
    Expression<String> receiver,
    Expression<String> visitorPosition,
    Expression<String> imageIdPath,
    Expression<double> idCardRepoId,
    Expression<double> surveyId,
    Expression<String> idCardFile,
    Expression<String> createdBy,
    Expression<DateTime> createdDate,
    Expression<String> updatedBy,
    Expression<DateTime> updatedDate,
    Expression<String> deletedBy,
    Expression<DateTime> deletedDate,
    Expression<String> survey,
    Expression<int> gender,
    Expression<String> passportNo,
    Expression<String> nationality,
    Expression<String> birthDay,
    Expression<String> permanentAddress,
    Expression<String> departmentRoomNo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (visitorId != null) 'visitor_id': visitorId,
      if (logId != null) 'log_id': logId,
      if (signIn != null) 'sign_in': signIn,
      if (signOut != null) 'sign_out': signOut,
      if (companyId != null) 'company_id': companyId,
      if (branchId != null) 'branch_id': branchId,
      if (signOutBy != null) 'sign_out_by': signOutBy,
      if (signOutType != null) 'sign_out_type': signOutType,
      if (checkOutTimeExpected != null)
        'check_out_time_expected': checkOutTimeExpected,
      if (customStep != null) 'custom_step': customStep,
      if (feedBack != null) 'feed_back': feedBack,
      if (rating != null) 'rating': rating,
      if (cardNo != null) 'card_no': cardNo,
      if (goods != null) 'goods': goods,
      if (receiver != null) 'receiver': receiver,
      if (visitorPosition != null) 'visitor_position': visitorPosition,
      if (imageIdPath != null) 'image_id_path': imageIdPath,
      if (idCardRepoId != null) 'id_card_repo_id': idCardRepoId,
      if (surveyId != null) 'survey_id': surveyId,
      if (idCardFile != null) 'id_card_file': idCardFile,
      if (createdBy != null) 'created_by': createdBy,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (deletedBy != null) 'deleted_by': deletedBy,
      if (deletedDate != null) 'deleted_date': deletedDate,
      if (survey != null) 'survey': survey,
      if (gender != null) 'gender': gender,
      if (passportNo != null) 'passport_no': passportNo,
      if (nationality != null) 'nationality': nationality,
      if (birthDay != null) 'birth_day': birthDay,
      if (permanentAddress != null) 'permanent_address': permanentAddress,
      if (departmentRoomNo != null) 'department_room_no': departmentRoomNo,
    });
  }

  VisitorLogEntityCompanion copyWith(
      {Value<String> id,
      Value<String> visitorId,
      Value<String> logId,
      Value<DateTime> signIn,
      Value<DateTime> signOut,
      Value<double> companyId,
      Value<double> branchId,
      Value<int> signOutBy,
      Value<String> signOutType,
      Value<String> checkOutTimeExpected,
      Value<String> customStep,
      Value<String> feedBack,
      Value<double> rating,
      Value<String> cardNo,
      Value<String> goods,
      Value<String> receiver,
      Value<String> visitorPosition,
      Value<String> imageIdPath,
      Value<double> idCardRepoId,
      Value<double> surveyId,
      Value<String> idCardFile,
      Value<String> createdBy,
      Value<DateTime> createdDate,
      Value<String> updatedBy,
      Value<DateTime> updatedDate,
      Value<String> deletedBy,
      Value<DateTime> deletedDate,
      Value<String> survey,
      Value<int> gender,
      Value<String> passportNo,
      Value<String> nationality,
      Value<String> birthDay,
      Value<String> permanentAddress,
      Value<String> departmentRoomNo}) {
    return VisitorLogEntityCompanion(
      id: id ?? this.id,
      visitorId: visitorId ?? this.visitorId,
      logId: logId ?? this.logId,
      signIn: signIn ?? this.signIn,
      signOut: signOut ?? this.signOut,
      companyId: companyId ?? this.companyId,
      branchId: branchId ?? this.branchId,
      signOutBy: signOutBy ?? this.signOutBy,
      signOutType: signOutType ?? this.signOutType,
      checkOutTimeExpected: checkOutTimeExpected ?? this.checkOutTimeExpected,
      customStep: customStep ?? this.customStep,
      feedBack: feedBack ?? this.feedBack,
      rating: rating ?? this.rating,
      cardNo: cardNo ?? this.cardNo,
      goods: goods ?? this.goods,
      receiver: receiver ?? this.receiver,
      visitorPosition: visitorPosition ?? this.visitorPosition,
      imageIdPath: imageIdPath ?? this.imageIdPath,
      idCardRepoId: idCardRepoId ?? this.idCardRepoId,
      surveyId: surveyId ?? this.surveyId,
      idCardFile: idCardFile ?? this.idCardFile,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedDate: deletedDate ?? this.deletedDate,
      survey: survey ?? this.survey,
      gender: gender ?? this.gender,
      passportNo: passportNo ?? this.passportNo,
      nationality: nationality ?? this.nationality,
      birthDay: birthDay ?? this.birthDay,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      departmentRoomNo: departmentRoomNo ?? this.departmentRoomNo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (visitorId.present) {
      map['visitor_id'] = Variable<String>(visitorId.value);
    }
    if (logId.present) {
      map['log_id'] = Variable<String>(logId.value);
    }
    if (signIn.present) {
      map['sign_in'] = Variable<DateTime>(signIn.value);
    }
    if (signOut.present) {
      map['sign_out'] = Variable<DateTime>(signOut.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<double>(companyId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<double>(branchId.value);
    }
    if (signOutBy.present) {
      map['sign_out_by'] = Variable<int>(signOutBy.value);
    }
    if (signOutType.present) {
      map['sign_out_type'] = Variable<String>(signOutType.value);
    }
    if (checkOutTimeExpected.present) {
      map['check_out_time_expected'] =
          Variable<String>(checkOutTimeExpected.value);
    }
    if (customStep.present) {
      map['custom_step'] = Variable<String>(customStep.value);
    }
    if (feedBack.present) {
      map['feed_back'] = Variable<String>(feedBack.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (cardNo.present) {
      map['card_no'] = Variable<String>(cardNo.value);
    }
    if (goods.present) {
      map['goods'] = Variable<String>(goods.value);
    }
    if (receiver.present) {
      map['receiver'] = Variable<String>(receiver.value);
    }
    if (visitorPosition.present) {
      map['visitor_position'] = Variable<String>(visitorPosition.value);
    }
    if (imageIdPath.present) {
      map['image_id_path'] = Variable<String>(imageIdPath.value);
    }
    if (idCardRepoId.present) {
      map['id_card_repo_id'] = Variable<double>(idCardRepoId.value);
    }
    if (surveyId.present) {
      map['survey_id'] = Variable<double>(surveyId.value);
    }
    if (idCardFile.present) {
      map['id_card_file'] = Variable<String>(idCardFile.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (deletedBy.present) {
      map['deleted_by'] = Variable<String>(deletedBy.value);
    }
    if (deletedDate.present) {
      map['deleted_date'] = Variable<DateTime>(deletedDate.value);
    }
    if (survey.present) {
      map['survey'] = Variable<String>(survey.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(gender.value);
    }
    if (passportNo.present) {
      map['passport_no'] = Variable<String>(passportNo.value);
    }
    if (nationality.present) {
      map['nationality'] = Variable<String>(nationality.value);
    }
    if (birthDay.present) {
      map['birth_day'] = Variable<String>(birthDay.value);
    }
    if (permanentAddress.present) {
      map['permanent_address'] = Variable<String>(permanentAddress.value);
    }
    if (departmentRoomNo.present) {
      map['department_room_no'] = Variable<String>(departmentRoomNo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitorLogEntityCompanion(')
          ..write('id: $id, ')
          ..write('visitorId: $visitorId, ')
          ..write('logId: $logId, ')
          ..write('signIn: $signIn, ')
          ..write('signOut: $signOut, ')
          ..write('companyId: $companyId, ')
          ..write('branchId: $branchId, ')
          ..write('signOutBy: $signOutBy, ')
          ..write('signOutType: $signOutType, ')
          ..write('checkOutTimeExpected: $checkOutTimeExpected, ')
          ..write('customStep: $customStep, ')
          ..write('feedBack: $feedBack, ')
          ..write('rating: $rating, ')
          ..write('cardNo: $cardNo, ')
          ..write('goods: $goods, ')
          ..write('receiver: $receiver, ')
          ..write('visitorPosition: $visitorPosition, ')
          ..write('imageIdPath: $imageIdPath, ')
          ..write('idCardRepoId: $idCardRepoId, ')
          ..write('surveyId: $surveyId, ')
          ..write('idCardFile: $idCardFile, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate, ')
          ..write('survey: $survey, ')
          ..write('gender: $gender, ')
          ..write('passportNo: $passportNo, ')
          ..write('nationality: $nationality, ')
          ..write('birthDay: $birthDay, ')
          ..write('permanentAddress: $permanentAddress, ')
          ..write('departmentRoomNo: $departmentRoomNo')
          ..write(')'))
        .toString();
  }
}

class $VisitorLogEntityTable extends VisitorLogEntity
    with TableInfo<$VisitorLogEntityTable, VisitorLogEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $VisitorLogEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => uuid.v1();
  }

  final VerificationMeta _visitorIdMeta = const VerificationMeta('visitorId');
  GeneratedTextColumn _visitorId;
  @override
  GeneratedTextColumn get visitorId => _visitorId ??= _constructVisitorId();
  GeneratedTextColumn _constructVisitorId() {
    return GeneratedTextColumn(
      'visitor_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _logIdMeta = const VerificationMeta('logId');
  GeneratedTextColumn _logId;
  @override
  GeneratedTextColumn get logId => _logId ??= _constructLogId();
  GeneratedTextColumn _constructLogId() {
    return GeneratedTextColumn(
      'log_id',
      $tableName,
      false,
    )..clientDefault = () => uuid.v1();
  }

  final VerificationMeta _signInMeta = const VerificationMeta('signIn');
  GeneratedDateTimeColumn _signIn;
  @override
  GeneratedDateTimeColumn get signIn => _signIn ??= _constructSignIn();
  GeneratedDateTimeColumn _constructSignIn() {
    return GeneratedDateTimeColumn(
      'sign_in',
      $tableName,
      true,
    );
  }

  final VerificationMeta _signOutMeta = const VerificationMeta('signOut');
  GeneratedDateTimeColumn _signOut;
  @override
  GeneratedDateTimeColumn get signOut => _signOut ??= _constructSignOut();
  GeneratedDateTimeColumn _constructSignOut() {
    return GeneratedDateTimeColumn(
      'sign_out',
      $tableName,
      true,
    );
  }

  final VerificationMeta _companyIdMeta = const VerificationMeta('companyId');
  GeneratedRealColumn _companyId;
  @override
  GeneratedRealColumn get companyId => _companyId ??= _constructCompanyId();
  GeneratedRealColumn _constructCompanyId() {
    return GeneratedRealColumn(
      'company_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _branchIdMeta = const VerificationMeta('branchId');
  GeneratedRealColumn _branchId;
  @override
  GeneratedRealColumn get branchId => _branchId ??= _constructBranchId();
  GeneratedRealColumn _constructBranchId() {
    return GeneratedRealColumn(
      'branch_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _signOutByMeta = const VerificationMeta('signOutBy');
  GeneratedIntColumn _signOutBy;
  @override
  GeneratedIntColumn get signOutBy => _signOutBy ??= _constructSignOutBy();
  GeneratedIntColumn _constructSignOutBy() {
    return GeneratedIntColumn(
      'sign_out_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _signOutTypeMeta =
      const VerificationMeta('signOutType');
  GeneratedTextColumn _signOutType;
  @override
  GeneratedTextColumn get signOutType =>
      _signOutType ??= _constructSignOutType();
  GeneratedTextColumn _constructSignOutType() {
    return GeneratedTextColumn(
      'sign_out_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _checkOutTimeExpectedMeta =
      const VerificationMeta('checkOutTimeExpected');
  GeneratedTextColumn _checkOutTimeExpected;
  @override
  GeneratedTextColumn get checkOutTimeExpected =>
      _checkOutTimeExpected ??= _constructCheckOutTimeExpected();
  GeneratedTextColumn _constructCheckOutTimeExpected() {
    return GeneratedTextColumn(
      'check_out_time_expected',
      $tableName,
      true,
    );
  }

  final VerificationMeta _customStepMeta = const VerificationMeta('customStep');
  GeneratedTextColumn _customStep;
  @override
  GeneratedTextColumn get customStep => _customStep ??= _constructCustomStep();
  GeneratedTextColumn _constructCustomStep() {
    return GeneratedTextColumn(
      'custom_step',
      $tableName,
      true,
    );
  }

  final VerificationMeta _feedBackMeta = const VerificationMeta('feedBack');
  GeneratedTextColumn _feedBack;
  @override
  GeneratedTextColumn get feedBack => _feedBack ??= _constructFeedBack();
  GeneratedTextColumn _constructFeedBack() {
    return GeneratedTextColumn(
      'feed_back',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  GeneratedRealColumn _rating;
  @override
  GeneratedRealColumn get rating => _rating ??= _constructRating();
  GeneratedRealColumn _constructRating() {
    return GeneratedRealColumn(
      'rating',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cardNoMeta = const VerificationMeta('cardNo');
  GeneratedTextColumn _cardNo;
  @override
  GeneratedTextColumn get cardNo => _cardNo ??= _constructCardNo();
  GeneratedTextColumn _constructCardNo() {
    return GeneratedTextColumn(
      'card_no',
      $tableName,
      true,
    );
  }

  final VerificationMeta _goodsMeta = const VerificationMeta('goods');
  GeneratedTextColumn _goods;
  @override
  GeneratedTextColumn get goods => _goods ??= _constructGoods();
  GeneratedTextColumn _constructGoods() {
    return GeneratedTextColumn(
      'goods',
      $tableName,
      true,
    );
  }

  final VerificationMeta _receiverMeta = const VerificationMeta('receiver');
  GeneratedTextColumn _receiver;
  @override
  GeneratedTextColumn get receiver => _receiver ??= _constructReceiver();
  GeneratedTextColumn _constructReceiver() {
    return GeneratedTextColumn(
      'receiver',
      $tableName,
      true,
    );
  }

  final VerificationMeta _visitorPositionMeta =
      const VerificationMeta('visitorPosition');
  GeneratedTextColumn _visitorPosition;
  @override
  GeneratedTextColumn get visitorPosition =>
      _visitorPosition ??= _constructVisitorPosition();
  GeneratedTextColumn _constructVisitorPosition() {
    return GeneratedTextColumn(
      'visitor_position',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageIdPathMeta =
      const VerificationMeta('imageIdPath');
  GeneratedTextColumn _imageIdPath;
  @override
  GeneratedTextColumn get imageIdPath =>
      _imageIdPath ??= _constructImageIdPath();
  GeneratedTextColumn _constructImageIdPath() {
    return GeneratedTextColumn(
      'image_id_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idCardRepoIdMeta =
      const VerificationMeta('idCardRepoId');
  GeneratedRealColumn _idCardRepoId;
  @override
  GeneratedRealColumn get idCardRepoId =>
      _idCardRepoId ??= _constructIdCardRepoId();
  GeneratedRealColumn _constructIdCardRepoId() {
    return GeneratedRealColumn(
      'id_card_repo_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _surveyIdMeta = const VerificationMeta('surveyId');
  GeneratedRealColumn _surveyId;
  @override
  GeneratedRealColumn get surveyId => _surveyId ??= _constructSurveyId();
  GeneratedRealColumn _constructSurveyId() {
    return GeneratedRealColumn(
      'survey_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idCardFileMeta = const VerificationMeta('idCardFile');
  GeneratedTextColumn _idCardFile;
  @override
  GeneratedTextColumn get idCardFile => _idCardFile ??= _constructIdCardFile();
  GeneratedTextColumn _constructIdCardFile() {
    return GeneratedTextColumn(
      'id_card_file',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedTextColumn _createdBy;
  @override
  GeneratedTextColumn get createdBy => _createdBy ??= _constructCreatedBy();
  GeneratedTextColumn _constructCreatedBy() {
    return GeneratedTextColumn(
      'created_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedByMeta = const VerificationMeta('updatedBy');
  GeneratedTextColumn _updatedBy;
  @override
  GeneratedTextColumn get updatedBy => _updatedBy ??= _constructUpdatedBy();
  GeneratedTextColumn _constructUpdatedBy() {
    return GeneratedTextColumn(
      'updated_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedByMeta = const VerificationMeta('deletedBy');
  GeneratedTextColumn _deletedBy;
  @override
  GeneratedTextColumn get deletedBy => _deletedBy ??= _constructDeletedBy();
  GeneratedTextColumn _constructDeletedBy() {
    return GeneratedTextColumn(
      'deleted_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedDateMeta =
      const VerificationMeta('deletedDate');
  GeneratedDateTimeColumn _deletedDate;
  @override
  GeneratedDateTimeColumn get deletedDate =>
      _deletedDate ??= _constructDeletedDate();
  GeneratedDateTimeColumn _constructDeletedDate() {
    return GeneratedDateTimeColumn(
      'deleted_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _surveyMeta = const VerificationMeta('survey');
  GeneratedTextColumn _survey;
  @override
  GeneratedTextColumn get survey => _survey ??= _constructSurvey();
  GeneratedTextColumn _constructSurvey() {
    return GeneratedTextColumn(
      'survey',
      $tableName,
      true,
    );
  }

  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  GeneratedIntColumn _gender;
  @override
  GeneratedIntColumn get gender => _gender ??= _constructGender();
  GeneratedIntColumn _constructGender() {
    return GeneratedIntColumn(
      'gender',
      $tableName,
      true,
    );
  }

  final VerificationMeta _passportNoMeta = const VerificationMeta('passportNo');
  GeneratedTextColumn _passportNo;
  @override
  GeneratedTextColumn get passportNo => _passportNo ??= _constructPassportNo();
  GeneratedTextColumn _constructPassportNo() {
    return GeneratedTextColumn(
      'passport_no',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nationalityMeta =
      const VerificationMeta('nationality');
  GeneratedTextColumn _nationality;
  @override
  GeneratedTextColumn get nationality =>
      _nationality ??= _constructNationality();
  GeneratedTextColumn _constructNationality() {
    return GeneratedTextColumn(
      'nationality',
      $tableName,
      true,
    );
  }

  final VerificationMeta _birthDayMeta = const VerificationMeta('birthDay');
  GeneratedTextColumn _birthDay;
  @override
  GeneratedTextColumn get birthDay => _birthDay ??= _constructBirthDay();
  GeneratedTextColumn _constructBirthDay() {
    return GeneratedTextColumn(
      'birth_day',
      $tableName,
      true,
    );
  }

  final VerificationMeta _permanentAddressMeta =
      const VerificationMeta('permanentAddress');
  GeneratedTextColumn _permanentAddress;
  @override
  GeneratedTextColumn get permanentAddress =>
      _permanentAddress ??= _constructPermanentAddress();
  GeneratedTextColumn _constructPermanentAddress() {
    return GeneratedTextColumn(
      'permanent_address',
      $tableName,
      true,
    );
  }

  final VerificationMeta _departmentRoomNoMeta =
      const VerificationMeta('departmentRoomNo');
  GeneratedTextColumn _departmentRoomNo;
  @override
  GeneratedTextColumn get departmentRoomNo =>
      _departmentRoomNo ??= _constructDepartmentRoomNo();
  GeneratedTextColumn _constructDepartmentRoomNo() {
    return GeneratedTextColumn(
      'department_room_no',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        visitorId,
        logId,
        signIn,
        signOut,
        companyId,
        branchId,
        signOutBy,
        signOutType,
        checkOutTimeExpected,
        customStep,
        feedBack,
        rating,
        cardNo,
        goods,
        receiver,
        visitorPosition,
        imageIdPath,
        idCardRepoId,
        surveyId,
        idCardFile,
        createdBy,
        createdDate,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate,
        survey,
        gender,
        passportNo,
        nationality,
        birthDay,
        permanentAddress,
        departmentRoomNo
      ];
  @override
  $VisitorLogEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_visitor_log';
  @override
  final String actualTableName = 'cip_visitor_log';
  @override
  VerificationContext validateIntegrity(Insertable<VisitorLogEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('visitor_id')) {
      context.handle(_visitorIdMeta,
          visitorId.isAcceptableOrUnknown(data['visitor_id'], _visitorIdMeta));
    } else if (isInserting) {
      context.missing(_visitorIdMeta);
    }
    if (data.containsKey('log_id')) {
      context.handle(
          _logIdMeta, logId.isAcceptableOrUnknown(data['log_id'], _logIdMeta));
    }
    if (data.containsKey('sign_in')) {
      context.handle(_signInMeta,
          signIn.isAcceptableOrUnknown(data['sign_in'], _signInMeta));
    }
    if (data.containsKey('sign_out')) {
      context.handle(_signOutMeta,
          signOut.isAcceptableOrUnknown(data['sign_out'], _signOutMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id'], _companyIdMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id'], _branchIdMeta));
    }
    if (data.containsKey('sign_out_by')) {
      context.handle(_signOutByMeta,
          signOutBy.isAcceptableOrUnknown(data['sign_out_by'], _signOutByMeta));
    }
    if (data.containsKey('sign_out_type')) {
      context.handle(
          _signOutTypeMeta,
          signOutType.isAcceptableOrUnknown(
              data['sign_out_type'], _signOutTypeMeta));
    }
    if (data.containsKey('check_out_time_expected')) {
      context.handle(
          _checkOutTimeExpectedMeta,
          checkOutTimeExpected.isAcceptableOrUnknown(
              data['check_out_time_expected'], _checkOutTimeExpectedMeta));
    }
    if (data.containsKey('custom_step')) {
      context.handle(
          _customStepMeta,
          customStep.isAcceptableOrUnknown(
              data['custom_step'], _customStepMeta));
    }
    if (data.containsKey('feed_back')) {
      context.handle(_feedBackMeta,
          feedBack.isAcceptableOrUnknown(data['feed_back'], _feedBackMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating'], _ratingMeta));
    }
    if (data.containsKey('card_no')) {
      context.handle(_cardNoMeta,
          cardNo.isAcceptableOrUnknown(data['card_no'], _cardNoMeta));
    }
    if (data.containsKey('goods')) {
      context.handle(
          _goodsMeta, goods.isAcceptableOrUnknown(data['goods'], _goodsMeta));
    }
    if (data.containsKey('receiver')) {
      context.handle(_receiverMeta,
          receiver.isAcceptableOrUnknown(data['receiver'], _receiverMeta));
    }
    if (data.containsKey('visitor_position')) {
      context.handle(
          _visitorPositionMeta,
          visitorPosition.isAcceptableOrUnknown(
              data['visitor_position'], _visitorPositionMeta));
    }
    if (data.containsKey('image_id_path')) {
      context.handle(
          _imageIdPathMeta,
          imageIdPath.isAcceptableOrUnknown(
              data['image_id_path'], _imageIdPathMeta));
    }
    if (data.containsKey('id_card_repo_id')) {
      context.handle(
          _idCardRepoIdMeta,
          idCardRepoId.isAcceptableOrUnknown(
              data['id_card_repo_id'], _idCardRepoIdMeta));
    }
    if (data.containsKey('survey_id')) {
      context.handle(_surveyIdMeta,
          surveyId.isAcceptableOrUnknown(data['survey_id'], _surveyIdMeta));
    }
    if (data.containsKey('id_card_file')) {
      context.handle(
          _idCardFileMeta,
          idCardFile.isAcceptableOrUnknown(
              data['id_card_file'], _idCardFileMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by'], _updatedByMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date'], _updatedDateMeta));
    }
    if (data.containsKey('deleted_by')) {
      context.handle(_deletedByMeta,
          deletedBy.isAcceptableOrUnknown(data['deleted_by'], _deletedByMeta));
    }
    if (data.containsKey('deleted_date')) {
      context.handle(
          _deletedDateMeta,
          deletedDate.isAcceptableOrUnknown(
              data['deleted_date'], _deletedDateMeta));
    }
    if (data.containsKey('survey')) {
      context.handle(_surveyMeta,
          survey.isAcceptableOrUnknown(data['survey'], _surveyMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender'], _genderMeta));
    }
    if (data.containsKey('passport_no')) {
      context.handle(
          _passportNoMeta,
          passportNo.isAcceptableOrUnknown(
              data['passport_no'], _passportNoMeta));
    }
    if (data.containsKey('nationality')) {
      context.handle(
          _nationalityMeta,
          nationality.isAcceptableOrUnknown(
              data['nationality'], _nationalityMeta));
    }
    if (data.containsKey('birth_day')) {
      context.handle(_birthDayMeta,
          birthDay.isAcceptableOrUnknown(data['birth_day'], _birthDayMeta));
    }
    if (data.containsKey('permanent_address')) {
      context.handle(
          _permanentAddressMeta,
          permanentAddress.isAcceptableOrUnknown(
              data['permanent_address'], _permanentAddressMeta));
    }
    if (data.containsKey('department_room_no')) {
      context.handle(
          _departmentRoomNoMeta,
          departmentRoomNo.isAcceptableOrUnknown(
              data['department_room_no'], _departmentRoomNoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitorLogEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return VisitorLogEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VisitorLogEntityTable createAlias(String alias) {
    return $VisitorLogEntityTable(_db, alias);
  }
}

class CompanyBuildingEntry extends DataClass
    implements Insertable<CompanyBuildingEntry> {
  final String idLocal;
  final double id;
  final String companyName;
  final String companyNameUnsigned;
  final String shortName;
  final String shortNameUnsigned;
  final String representativeName;
  final String representativeEmail;
  final double representativeId;
  final String floor;
  final String note;
  final int isActive;
  final double companyId;
  final String logoPath;
  final String logoPathLocal;
  final int logoRepoId;
  final int indexSort;
  final String createdBy;
  final DateTime createdDate;
  final String updatedBy;
  final DateTime updatedDate;
  final String deletedBy;
  final DateTime deletedDate;
  CompanyBuildingEntry(
      {@required this.idLocal,
      @required this.id,
      @required this.companyName,
      @required this.companyNameUnsigned,
      this.shortName,
      this.shortNameUnsigned,
      this.representativeName,
      this.representativeEmail,
      this.representativeId,
      this.floor,
      this.note,
      this.isActive,
      this.companyId,
      this.logoPath,
      this.logoPathLocal,
      this.logoRepoId,
      this.indexSort,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.deletedBy,
      this.deletedDate});
  factory CompanyBuildingEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CompanyBuildingEntry(
      idLocal: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_local']),
      id: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      companyName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_name']),
      companyNameUnsigned: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}company_name_unsigned']),
      shortName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}short_name']),
      shortNameUnsigned: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}short_name_unsigned']),
      representativeName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}representative_name']),
      representativeEmail: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}representative_email']),
      representativeId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}representative_id']),
      floor:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}floor']),
      note: stringType.mapFromDatabaseResponse(data['${effectivePrefix}note']),
      isActive:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}is_active']),
      companyId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_id']),
      logoPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}logo_path']),
      logoPathLocal: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}logo_path_local']),
      logoRepoId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}logo_repo_id']),
      indexSort:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}index_sort']),
      createdBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      updatedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_by']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
      deletedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_by']),
      deletedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || idLocal != null) {
      map['id_local'] = Variable<String>(idLocal);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<double>(id);
    }
    if (!nullToAbsent || companyName != null) {
      map['company_name'] = Variable<String>(companyName);
    }
    if (!nullToAbsent || companyNameUnsigned != null) {
      map['company_name_unsigned'] = Variable<String>(companyNameUnsigned);
    }
    if (!nullToAbsent || shortName != null) {
      map['short_name'] = Variable<String>(shortName);
    }
    if (!nullToAbsent || shortNameUnsigned != null) {
      map['short_name_unsigned'] = Variable<String>(shortNameUnsigned);
    }
    if (!nullToAbsent || representativeName != null) {
      map['representative_name'] = Variable<String>(representativeName);
    }
    if (!nullToAbsent || representativeEmail != null) {
      map['representative_email'] = Variable<String>(representativeEmail);
    }
    if (!nullToAbsent || representativeId != null) {
      map['representative_id'] = Variable<double>(representativeId);
    }
    if (!nullToAbsent || floor != null) {
      map['floor'] = Variable<String>(floor);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || isActive != null) {
      map['is_active'] = Variable<int>(isActive);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<double>(companyId);
    }
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    if (!nullToAbsent || logoPathLocal != null) {
      map['logo_path_local'] = Variable<String>(logoPathLocal);
    }
    if (!nullToAbsent || logoRepoId != null) {
      map['logo_repo_id'] = Variable<int>(logoRepoId);
    }
    if (!nullToAbsent || indexSort != null) {
      map['index_sort'] = Variable<int>(indexSort);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || updatedDate != null) {
      map['updated_date'] = Variable<DateTime>(updatedDate);
    }
    if (!nullToAbsent || deletedBy != null) {
      map['deleted_by'] = Variable<String>(deletedBy);
    }
    if (!nullToAbsent || deletedDate != null) {
      map['deleted_date'] = Variable<DateTime>(deletedDate);
    }
    return map;
  }

  CompanyBuildingEntityCompanion toCompanion(bool nullToAbsent) {
    return CompanyBuildingEntityCompanion(
      idLocal: idLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(idLocal),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      companyName: companyName == null && nullToAbsent
          ? const Value.absent()
          : Value(companyName),
      companyNameUnsigned: companyNameUnsigned == null && nullToAbsent
          ? const Value.absent()
          : Value(companyNameUnsigned),
      shortName: shortName == null && nullToAbsent
          ? const Value.absent()
          : Value(shortName),
      shortNameUnsigned: shortNameUnsigned == null && nullToAbsent
          ? const Value.absent()
          : Value(shortNameUnsigned),
      representativeName: representativeName == null && nullToAbsent
          ? const Value.absent()
          : Value(representativeName),
      representativeEmail: representativeEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(representativeEmail),
      representativeId: representativeId == null && nullToAbsent
          ? const Value.absent()
          : Value(representativeId),
      floor:
          floor == null && nullToAbsent ? const Value.absent() : Value(floor),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isActive: isActive == null && nullToAbsent
          ? const Value.absent()
          : Value(isActive),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      logoPathLocal: logoPathLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPathLocal),
      logoRepoId: logoRepoId == null && nullToAbsent
          ? const Value.absent()
          : Value(logoRepoId),
      indexSort: indexSort == null && nullToAbsent
          ? const Value.absent()
          : Value(indexSort),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
      deletedBy: deletedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedBy),
      deletedDate: deletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedDate),
    );
  }

  factory CompanyBuildingEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CompanyBuildingEntry(
      idLocal: serializer.fromJson<String>(json['idLocal']),
      id: serializer.fromJson<double>(json['id']),
      companyName: serializer.fromJson<String>(json['companyName']),
      companyNameUnsigned:
          serializer.fromJson<String>(json['companyNameUnsigned']),
      shortName: serializer.fromJson<String>(json['shortName']),
      shortNameUnsigned: serializer.fromJson<String>(json['shortNameUnsigned']),
      representativeName:
          serializer.fromJson<String>(json['representativeName']),
      representativeEmail:
          serializer.fromJson<String>(json['representativeEmail']),
      representativeId: serializer.fromJson<double>(json['representativeId']),
      floor: serializer.fromJson<String>(json['floor']),
      note: serializer.fromJson<String>(json['note']),
      isActive: serializer.fromJson<int>(json['isActive']),
      companyId: serializer.fromJson<double>(json['companyId']),
      logoPath: serializer.fromJson<String>(json['logoPath']),
      logoPathLocal: serializer.fromJson<String>(json['logoPathLocal']),
      logoRepoId: serializer.fromJson<int>(json['logoRepoId']),
      indexSort: serializer.fromJson<int>(json['indexSort']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      deletedBy: serializer.fromJson<String>(json['deletedBy']),
      deletedDate: serializer.fromJson<DateTime>(json['deletedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idLocal': serializer.toJson<String>(idLocal),
      'id': serializer.toJson<double>(id),
      'companyName': serializer.toJson<String>(companyName),
      'companyNameUnsigned': serializer.toJson<String>(companyNameUnsigned),
      'shortName': serializer.toJson<String>(shortName),
      'shortNameUnsigned': serializer.toJson<String>(shortNameUnsigned),
      'representativeName': serializer.toJson<String>(representativeName),
      'representativeEmail': serializer.toJson<String>(representativeEmail),
      'representativeId': serializer.toJson<double>(representativeId),
      'floor': serializer.toJson<String>(floor),
      'note': serializer.toJson<String>(note),
      'isActive': serializer.toJson<int>(isActive),
      'companyId': serializer.toJson<double>(companyId),
      'logoPath': serializer.toJson<String>(logoPath),
      'logoPathLocal': serializer.toJson<String>(logoPathLocal),
      'logoRepoId': serializer.toJson<int>(logoRepoId),
      'indexSort': serializer.toJson<int>(indexSort),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'deletedBy': serializer.toJson<String>(deletedBy),
      'deletedDate': serializer.toJson<DateTime>(deletedDate),
    };
  }

  CompanyBuildingEntry copyWith(
          {String idLocal,
          double id,
          String companyName,
          String companyNameUnsigned,
          String shortName,
          String shortNameUnsigned,
          String representativeName,
          String representativeEmail,
          double representativeId,
          String floor,
          String note,
          int isActive,
          double companyId,
          String logoPath,
          String logoPathLocal,
          int logoRepoId,
          int indexSort,
          String createdBy,
          DateTime createdDate,
          String updatedBy,
          DateTime updatedDate,
          String deletedBy,
          DateTime deletedDate}) =>
      CompanyBuildingEntry(
        idLocal: idLocal ?? this.idLocal,
        id: id ?? this.id,
        companyName: companyName ?? this.companyName,
        companyNameUnsigned: companyNameUnsigned ?? this.companyNameUnsigned,
        shortName: shortName ?? this.shortName,
        shortNameUnsigned: shortNameUnsigned ?? this.shortNameUnsigned,
        representativeName: representativeName ?? this.representativeName,
        representativeEmail: representativeEmail ?? this.representativeEmail,
        representativeId: representativeId ?? this.representativeId,
        floor: floor ?? this.floor,
        note: note ?? this.note,
        isActive: isActive ?? this.isActive,
        companyId: companyId ?? this.companyId,
        logoPath: logoPath ?? this.logoPath,
        logoPathLocal: logoPathLocal ?? this.logoPathLocal,
        logoRepoId: logoRepoId ?? this.logoRepoId,
        indexSort: indexSort ?? this.indexSort,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedDate: deletedDate ?? this.deletedDate,
      );
  @override
  String toString() {
    return (StringBuffer('CompanyBuildingEntry(')
          ..write('idLocal: $idLocal, ')
          ..write('id: $id, ')
          ..write('companyName: $companyName, ')
          ..write('companyNameUnsigned: $companyNameUnsigned, ')
          ..write('shortName: $shortName, ')
          ..write('shortNameUnsigned: $shortNameUnsigned, ')
          ..write('representativeName: $representativeName, ')
          ..write('representativeEmail: $representativeEmail, ')
          ..write('representativeId: $representativeId, ')
          ..write('floor: $floor, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('companyId: $companyId, ')
          ..write('logoPath: $logoPath, ')
          ..write('logoPathLocal: $logoPathLocal, ')
          ..write('logoRepoId: $logoRepoId, ')
          ..write('indexSort: $indexSort, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      idLocal.hashCode,
      $mrjc(
          id.hashCode,
          $mrjc(
              companyName.hashCode,
              $mrjc(
                  companyNameUnsigned.hashCode,
                  $mrjc(
                      shortName.hashCode,
                      $mrjc(
                          shortNameUnsigned.hashCode,
                          $mrjc(
                              representativeName.hashCode,
                              $mrjc(
                                  representativeEmail.hashCode,
                                  $mrjc(
                                      representativeId.hashCode,
                                      $mrjc(
                                          floor.hashCode,
                                          $mrjc(
                                              note.hashCode,
                                              $mrjc(
                                                  isActive.hashCode,
                                                  $mrjc(
                                                      companyId.hashCode,
                                                      $mrjc(
                                                          logoPath.hashCode,
                                                          $mrjc(
                                                              logoPathLocal
                                                                  .hashCode,
                                                              $mrjc(
                                                                  logoRepoId
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      indexSort
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          createdBy
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              createdDate.hashCode,
                                                                              $mrjc(updatedBy.hashCode, $mrjc(updatedDate.hashCode, $mrjc(deletedBy.hashCode, deletedDate.hashCode)))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CompanyBuildingEntry &&
          other.idLocal == this.idLocal &&
          other.id == this.id &&
          other.companyName == this.companyName &&
          other.companyNameUnsigned == this.companyNameUnsigned &&
          other.shortName == this.shortName &&
          other.shortNameUnsigned == this.shortNameUnsigned &&
          other.representativeName == this.representativeName &&
          other.representativeEmail == this.representativeEmail &&
          other.representativeId == this.representativeId &&
          other.floor == this.floor &&
          other.note == this.note &&
          other.isActive == this.isActive &&
          other.companyId == this.companyId &&
          other.logoPath == this.logoPath &&
          other.logoPathLocal == this.logoPathLocal &&
          other.logoRepoId == this.logoRepoId &&
          other.indexSort == this.indexSort &&
          other.createdBy == this.createdBy &&
          other.createdDate == this.createdDate &&
          other.updatedBy == this.updatedBy &&
          other.updatedDate == this.updatedDate &&
          other.deletedBy == this.deletedBy &&
          other.deletedDate == this.deletedDate);
}

class CompanyBuildingEntityCompanion
    extends UpdateCompanion<CompanyBuildingEntry> {
  final Value<String> idLocal;
  final Value<double> id;
  final Value<String> companyName;
  final Value<String> companyNameUnsigned;
  final Value<String> shortName;
  final Value<String> shortNameUnsigned;
  final Value<String> representativeName;
  final Value<String> representativeEmail;
  final Value<double> representativeId;
  final Value<String> floor;
  final Value<String> note;
  final Value<int> isActive;
  final Value<double> companyId;
  final Value<String> logoPath;
  final Value<String> logoPathLocal;
  final Value<int> logoRepoId;
  final Value<int> indexSort;
  final Value<String> createdBy;
  final Value<DateTime> createdDate;
  final Value<String> updatedBy;
  final Value<DateTime> updatedDate;
  final Value<String> deletedBy;
  final Value<DateTime> deletedDate;
  const CompanyBuildingEntityCompanion({
    this.idLocal = const Value.absent(),
    this.id = const Value.absent(),
    this.companyName = const Value.absent(),
    this.companyNameUnsigned = const Value.absent(),
    this.shortName = const Value.absent(),
    this.shortNameUnsigned = const Value.absent(),
    this.representativeName = const Value.absent(),
    this.representativeEmail = const Value.absent(),
    this.representativeId = const Value.absent(),
    this.floor = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.companyId = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.logoPathLocal = const Value.absent(),
    this.logoRepoId = const Value.absent(),
    this.indexSort = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  });
  CompanyBuildingEntityCompanion.insert({
    this.idLocal = const Value.absent(),
    @required double id,
    @required String companyName,
    this.companyNameUnsigned = const Value.absent(),
    this.shortName = const Value.absent(),
    this.shortNameUnsigned = const Value.absent(),
    this.representativeName = const Value.absent(),
    this.representativeEmail = const Value.absent(),
    this.representativeId = const Value.absent(),
    this.floor = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.companyId = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.logoPathLocal = const Value.absent(),
    this.logoRepoId = const Value.absent(),
    this.indexSort = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  })  : id = Value(id),
        companyName = Value(companyName);
  static Insertable<CompanyBuildingEntry> custom({
    Expression<String> idLocal,
    Expression<double> id,
    Expression<String> companyName,
    Expression<String> companyNameUnsigned,
    Expression<String> shortName,
    Expression<String> shortNameUnsigned,
    Expression<String> representativeName,
    Expression<String> representativeEmail,
    Expression<double> representativeId,
    Expression<String> floor,
    Expression<String> note,
    Expression<int> isActive,
    Expression<double> companyId,
    Expression<String> logoPath,
    Expression<String> logoPathLocal,
    Expression<int> logoRepoId,
    Expression<int> indexSort,
    Expression<String> createdBy,
    Expression<DateTime> createdDate,
    Expression<String> updatedBy,
    Expression<DateTime> updatedDate,
    Expression<String> deletedBy,
    Expression<DateTime> deletedDate,
  }) {
    return RawValuesInsertable({
      if (idLocal != null) 'id_local': idLocal,
      if (id != null) 'id': id,
      if (companyName != null) 'company_name': companyName,
      if (companyNameUnsigned != null)
        'company_name_unsigned': companyNameUnsigned,
      if (shortName != null) 'short_name': shortName,
      if (shortNameUnsigned != null) 'short_name_unsigned': shortNameUnsigned,
      if (representativeName != null) 'representative_name': representativeName,
      if (representativeEmail != null)
        'representative_email': representativeEmail,
      if (representativeId != null) 'representative_id': representativeId,
      if (floor != null) 'floor': floor,
      if (note != null) 'note': note,
      if (isActive != null) 'is_active': isActive,
      if (companyId != null) 'company_id': companyId,
      if (logoPath != null) 'logo_path': logoPath,
      if (logoPathLocal != null) 'logo_path_local': logoPathLocal,
      if (logoRepoId != null) 'logo_repo_id': logoRepoId,
      if (indexSort != null) 'index_sort': indexSort,
      if (createdBy != null) 'created_by': createdBy,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (deletedBy != null) 'deleted_by': deletedBy,
      if (deletedDate != null) 'deleted_date': deletedDate,
    });
  }

  CompanyBuildingEntityCompanion copyWith(
      {Value<String> idLocal,
      Value<double> id,
      Value<String> companyName,
      Value<String> companyNameUnsigned,
      Value<String> shortName,
      Value<String> shortNameUnsigned,
      Value<String> representativeName,
      Value<String> representativeEmail,
      Value<double> representativeId,
      Value<String> floor,
      Value<String> note,
      Value<int> isActive,
      Value<double> companyId,
      Value<String> logoPath,
      Value<String> logoPathLocal,
      Value<int> logoRepoId,
      Value<int> indexSort,
      Value<String> createdBy,
      Value<DateTime> createdDate,
      Value<String> updatedBy,
      Value<DateTime> updatedDate,
      Value<String> deletedBy,
      Value<DateTime> deletedDate}) {
    return CompanyBuildingEntityCompanion(
      idLocal: idLocal ?? this.idLocal,
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      companyNameUnsigned: companyNameUnsigned ?? this.companyNameUnsigned,
      shortName: shortName ?? this.shortName,
      shortNameUnsigned: shortNameUnsigned ?? this.shortNameUnsigned,
      representativeName: representativeName ?? this.representativeName,
      representativeEmail: representativeEmail ?? this.representativeEmail,
      representativeId: representativeId ?? this.representativeId,
      floor: floor ?? this.floor,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
      companyId: companyId ?? this.companyId,
      logoPath: logoPath ?? this.logoPath,
      logoPathLocal: logoPathLocal ?? this.logoPathLocal,
      logoRepoId: logoRepoId ?? this.logoRepoId,
      indexSort: indexSort ?? this.indexSort,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedDate: deletedDate ?? this.deletedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idLocal.present) {
      map['id_local'] = Variable<String>(idLocal.value);
    }
    if (id.present) {
      map['id'] = Variable<double>(id.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (companyNameUnsigned.present) {
      map['company_name_unsigned'] =
          Variable<String>(companyNameUnsigned.value);
    }
    if (shortName.present) {
      map['short_name'] = Variable<String>(shortName.value);
    }
    if (shortNameUnsigned.present) {
      map['short_name_unsigned'] = Variable<String>(shortNameUnsigned.value);
    }
    if (representativeName.present) {
      map['representative_name'] = Variable<String>(representativeName.value);
    }
    if (representativeEmail.present) {
      map['representative_email'] = Variable<String>(representativeEmail.value);
    }
    if (representativeId.present) {
      map['representative_id'] = Variable<double>(representativeId.value);
    }
    if (floor.present) {
      map['floor'] = Variable<String>(floor.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<double>(companyId.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (logoPathLocal.present) {
      map['logo_path_local'] = Variable<String>(logoPathLocal.value);
    }
    if (logoRepoId.present) {
      map['logo_repo_id'] = Variable<int>(logoRepoId.value);
    }
    if (indexSort.present) {
      map['index_sort'] = Variable<int>(indexSort.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (deletedBy.present) {
      map['deleted_by'] = Variable<String>(deletedBy.value);
    }
    if (deletedDate.present) {
      map['deleted_date'] = Variable<DateTime>(deletedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanyBuildingEntityCompanion(')
          ..write('idLocal: $idLocal, ')
          ..write('id: $id, ')
          ..write('companyName: $companyName, ')
          ..write('companyNameUnsigned: $companyNameUnsigned, ')
          ..write('shortName: $shortName, ')
          ..write('shortNameUnsigned: $shortNameUnsigned, ')
          ..write('representativeName: $representativeName, ')
          ..write('representativeEmail: $representativeEmail, ')
          ..write('representativeId: $representativeId, ')
          ..write('floor: $floor, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('companyId: $companyId, ')
          ..write('logoPath: $logoPath, ')
          ..write('logoPathLocal: $logoPathLocal, ')
          ..write('logoRepoId: $logoRepoId, ')
          ..write('indexSort: $indexSort, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }
}

class $CompanyBuildingEntityTable extends CompanyBuildingEntity
    with TableInfo<$CompanyBuildingEntityTable, CompanyBuildingEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $CompanyBuildingEntityTable(this._db, [this._alias]);
  final VerificationMeta _idLocalMeta = const VerificationMeta('idLocal');
  GeneratedTextColumn _idLocal;
  @override
  GeneratedTextColumn get idLocal => _idLocal ??= _constructIdLocal();
  GeneratedTextColumn _constructIdLocal() {
    return GeneratedTextColumn(
      'id_local',
      $tableName,
      false,
    )..clientDefault = () => uuid.v1();
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedRealColumn _id;
  @override
  GeneratedRealColumn get id => _id ??= _constructId();
  GeneratedRealColumn _constructId() {
    return GeneratedRealColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  GeneratedTextColumn _companyName;
  @override
  GeneratedTextColumn get companyName =>
      _companyName ??= _constructCompanyName();
  GeneratedTextColumn _constructCompanyName() {
    return GeneratedTextColumn(
      'company_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _companyNameUnsignedMeta =
      const VerificationMeta('companyNameUnsigned');
  GeneratedTextColumn _companyNameUnsigned;
  @override
  GeneratedTextColumn get companyNameUnsigned =>
      _companyNameUnsigned ??= _constructCompanyNameUnsigned();
  GeneratedTextColumn _constructCompanyNameUnsigned() {
    return GeneratedTextColumn('company_name_unsigned', $tableName, false,
        defaultValue: const Constant(''));
  }

  final VerificationMeta _shortNameMeta = const VerificationMeta('shortName');
  GeneratedTextColumn _shortName;
  @override
  GeneratedTextColumn get shortName => _shortName ??= _constructShortName();
  GeneratedTextColumn _constructShortName() {
    return GeneratedTextColumn(
      'short_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _shortNameUnsignedMeta =
      const VerificationMeta('shortNameUnsigned');
  GeneratedTextColumn _shortNameUnsigned;
  @override
  GeneratedTextColumn get shortNameUnsigned =>
      _shortNameUnsigned ??= _constructShortNameUnsigned();
  GeneratedTextColumn _constructShortNameUnsigned() {
    return GeneratedTextColumn(
      'short_name_unsigned',
      $tableName,
      true,
    );
  }

  final VerificationMeta _representativeNameMeta =
      const VerificationMeta('representativeName');
  GeneratedTextColumn _representativeName;
  @override
  GeneratedTextColumn get representativeName =>
      _representativeName ??= _constructRepresentativeName();
  GeneratedTextColumn _constructRepresentativeName() {
    return GeneratedTextColumn(
      'representative_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _representativeEmailMeta =
      const VerificationMeta('representativeEmail');
  GeneratedTextColumn _representativeEmail;
  @override
  GeneratedTextColumn get representativeEmail =>
      _representativeEmail ??= _constructRepresentativeEmail();
  GeneratedTextColumn _constructRepresentativeEmail() {
    return GeneratedTextColumn(
      'representative_email',
      $tableName,
      true,
    );
  }

  final VerificationMeta _representativeIdMeta =
      const VerificationMeta('representativeId');
  GeneratedRealColumn _representativeId;
  @override
  GeneratedRealColumn get representativeId =>
      _representativeId ??= _constructRepresentativeId();
  GeneratedRealColumn _constructRepresentativeId() {
    return GeneratedRealColumn(
      'representative_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _floorMeta = const VerificationMeta('floor');
  GeneratedTextColumn _floor;
  @override
  GeneratedTextColumn get floor => _floor ??= _constructFloor();
  GeneratedTextColumn _constructFloor() {
    return GeneratedTextColumn(
      'floor',
      $tableName,
      true,
    );
  }

  final VerificationMeta _noteMeta = const VerificationMeta('note');
  GeneratedTextColumn _note;
  @override
  GeneratedTextColumn get note => _note ??= _constructNote();
  GeneratedTextColumn _constructNote() {
    return GeneratedTextColumn(
      'note',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isActiveMeta = const VerificationMeta('isActive');
  GeneratedIntColumn _isActive;
  @override
  GeneratedIntColumn get isActive => _isActive ??= _constructIsActive();
  GeneratedIntColumn _constructIsActive() {
    return GeneratedIntColumn(
      'is_active',
      $tableName,
      true,
    );
  }

  final VerificationMeta _companyIdMeta = const VerificationMeta('companyId');
  GeneratedRealColumn _companyId;
  @override
  GeneratedRealColumn get companyId => _companyId ??= _constructCompanyId();
  GeneratedRealColumn _constructCompanyId() {
    return GeneratedRealColumn(
      'company_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _logoPathMeta = const VerificationMeta('logoPath');
  GeneratedTextColumn _logoPath;
  @override
  GeneratedTextColumn get logoPath => _logoPath ??= _constructLogoPath();
  GeneratedTextColumn _constructLogoPath() {
    return GeneratedTextColumn(
      'logo_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _logoPathLocalMeta =
      const VerificationMeta('logoPathLocal');
  GeneratedTextColumn _logoPathLocal;
  @override
  GeneratedTextColumn get logoPathLocal =>
      _logoPathLocal ??= _constructLogoPathLocal();
  GeneratedTextColumn _constructLogoPathLocal() {
    return GeneratedTextColumn(
      'logo_path_local',
      $tableName,
      true,
    );
  }

  final VerificationMeta _logoRepoIdMeta = const VerificationMeta('logoRepoId');
  GeneratedIntColumn _logoRepoId;
  @override
  GeneratedIntColumn get logoRepoId => _logoRepoId ??= _constructLogoRepoId();
  GeneratedIntColumn _constructLogoRepoId() {
    return GeneratedIntColumn(
      'logo_repo_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _indexSortMeta = const VerificationMeta('indexSort');
  GeneratedIntColumn _indexSort;
  @override
  GeneratedIntColumn get indexSort => _indexSort ??= _constructIndexSort();
  GeneratedIntColumn _constructIndexSort() {
    return GeneratedIntColumn(
      'index_sort',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedTextColumn _createdBy;
  @override
  GeneratedTextColumn get createdBy => _createdBy ??= _constructCreatedBy();
  GeneratedTextColumn _constructCreatedBy() {
    return GeneratedTextColumn(
      'created_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedByMeta = const VerificationMeta('updatedBy');
  GeneratedTextColumn _updatedBy;
  @override
  GeneratedTextColumn get updatedBy => _updatedBy ??= _constructUpdatedBy();
  GeneratedTextColumn _constructUpdatedBy() {
    return GeneratedTextColumn(
      'updated_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedByMeta = const VerificationMeta('deletedBy');
  GeneratedTextColumn _deletedBy;
  @override
  GeneratedTextColumn get deletedBy => _deletedBy ??= _constructDeletedBy();
  GeneratedTextColumn _constructDeletedBy() {
    return GeneratedTextColumn(
      'deleted_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedDateMeta =
      const VerificationMeta('deletedDate');
  GeneratedDateTimeColumn _deletedDate;
  @override
  GeneratedDateTimeColumn get deletedDate =>
      _deletedDate ??= _constructDeletedDate();
  GeneratedDateTimeColumn _constructDeletedDate() {
    return GeneratedDateTimeColumn(
      'deleted_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        idLocal,
        id,
        companyName,
        companyNameUnsigned,
        shortName,
        shortNameUnsigned,
        representativeName,
        representativeEmail,
        representativeId,
        floor,
        note,
        isActive,
        companyId,
        logoPath,
        logoPathLocal,
        logoRepoId,
        indexSort,
        createdBy,
        createdDate,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate
      ];
  @override
  $CompanyBuildingEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_company_building';
  @override
  final String actualTableName = 'cip_company_building';
  @override
  VerificationContext validateIntegrity(
      Insertable<CompanyBuildingEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_local')) {
      context.handle(_idLocalMeta,
          idLocal.isAcceptableOrUnknown(data['id_local'], _idLocalMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name'], _companyNameMeta));
    } else if (isInserting) {
      context.missing(_companyNameMeta);
    }
    if (data.containsKey('company_name_unsigned')) {
      context.handle(
          _companyNameUnsignedMeta,
          companyNameUnsigned.isAcceptableOrUnknown(
              data['company_name_unsigned'], _companyNameUnsignedMeta));
    }
    if (data.containsKey('short_name')) {
      context.handle(_shortNameMeta,
          shortName.isAcceptableOrUnknown(data['short_name'], _shortNameMeta));
    }
    if (data.containsKey('short_name_unsigned')) {
      context.handle(
          _shortNameUnsignedMeta,
          shortNameUnsigned.isAcceptableOrUnknown(
              data['short_name_unsigned'], _shortNameUnsignedMeta));
    }
    if (data.containsKey('representative_name')) {
      context.handle(
          _representativeNameMeta,
          representativeName.isAcceptableOrUnknown(
              data['representative_name'], _representativeNameMeta));
    }
    if (data.containsKey('representative_email')) {
      context.handle(
          _representativeEmailMeta,
          representativeEmail.isAcceptableOrUnknown(
              data['representative_email'], _representativeEmailMeta));
    }
    if (data.containsKey('representative_id')) {
      context.handle(
          _representativeIdMeta,
          representativeId.isAcceptableOrUnknown(
              data['representative_id'], _representativeIdMeta));
    }
    if (data.containsKey('floor')) {
      context.handle(
          _floorMeta, floor.isAcceptableOrUnknown(data['floor'], _floorMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note'], _noteMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active'], _isActiveMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id'], _companyIdMeta));
    }
    if (data.containsKey('logo_path')) {
      context.handle(_logoPathMeta,
          logoPath.isAcceptableOrUnknown(data['logo_path'], _logoPathMeta));
    }
    if (data.containsKey('logo_path_local')) {
      context.handle(
          _logoPathLocalMeta,
          logoPathLocal.isAcceptableOrUnknown(
              data['logo_path_local'], _logoPathLocalMeta));
    }
    if (data.containsKey('logo_repo_id')) {
      context.handle(
          _logoRepoIdMeta,
          logoRepoId.isAcceptableOrUnknown(
              data['logo_repo_id'], _logoRepoIdMeta));
    }
    if (data.containsKey('index_sort')) {
      context.handle(_indexSortMeta,
          indexSort.isAcceptableOrUnknown(data['index_sort'], _indexSortMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by'], _updatedByMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date'], _updatedDateMeta));
    }
    if (data.containsKey('deleted_by')) {
      context.handle(_deletedByMeta,
          deletedBy.isAcceptableOrUnknown(data['deleted_by'], _deletedByMeta));
    }
    if (data.containsKey('deleted_date')) {
      context.handle(
          _deletedDateMeta,
          deletedDate.isAcceptableOrUnknown(
              data['deleted_date'], _deletedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idLocal};
  @override
  CompanyBuildingEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CompanyBuildingEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CompanyBuildingEntityTable createAlias(String alias) {
    return $CompanyBuildingEntityTable(_db, alias);
  }
}

class VisitorCompanyEntry extends DataClass
    implements Insertable<VisitorCompanyEntry> {
  final String id;
  final String fromCompany;
  final String fromCompanyUnsigned;
  final String createdBy;
  final DateTime createdDate;
  final String updatedBy;
  final DateTime updatedDate;
  final String deletedBy;
  final DateTime deletedDate;
  VisitorCompanyEntry(
      {@required this.id,
      this.fromCompany,
      this.fromCompanyUnsigned,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.deletedBy,
      this.deletedDate});
  factory VisitorCompanyEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return VisitorCompanyEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      fromCompany: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}from_company']),
      fromCompanyUnsigned: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}from_company_unsigned']),
      createdBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      updatedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_by']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
      deletedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_by']),
      deletedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || fromCompany != null) {
      map['from_company'] = Variable<String>(fromCompany);
    }
    if (!nullToAbsent || fromCompanyUnsigned != null) {
      map['from_company_unsigned'] = Variable<String>(fromCompanyUnsigned);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || updatedDate != null) {
      map['updated_date'] = Variable<DateTime>(updatedDate);
    }
    if (!nullToAbsent || deletedBy != null) {
      map['deleted_by'] = Variable<String>(deletedBy);
    }
    if (!nullToAbsent || deletedDate != null) {
      map['deleted_date'] = Variable<DateTime>(deletedDate);
    }
    return map;
  }

  VisitorCompanyEntityCompanion toCompanion(bool nullToAbsent) {
    return VisitorCompanyEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      fromCompany: fromCompany == null && nullToAbsent
          ? const Value.absent()
          : Value(fromCompany),
      fromCompanyUnsigned: fromCompanyUnsigned == null && nullToAbsent
          ? const Value.absent()
          : Value(fromCompanyUnsigned),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
      deletedBy: deletedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedBy),
      deletedDate: deletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedDate),
    );
  }

  factory VisitorCompanyEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VisitorCompanyEntry(
      id: serializer.fromJson<String>(json['id']),
      fromCompany: serializer.fromJson<String>(json['fromCompany']),
      fromCompanyUnsigned:
          serializer.fromJson<String>(json['fromCompanyUnsigned']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      deletedBy: serializer.fromJson<String>(json['deletedBy']),
      deletedDate: serializer.fromJson<DateTime>(json['deletedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fromCompany': serializer.toJson<String>(fromCompany),
      'fromCompanyUnsigned': serializer.toJson<String>(fromCompanyUnsigned),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'deletedBy': serializer.toJson<String>(deletedBy),
      'deletedDate': serializer.toJson<DateTime>(deletedDate),
    };
  }

  VisitorCompanyEntry copyWith(
          {String id,
          String fromCompany,
          String fromCompanyUnsigned,
          String createdBy,
          DateTime createdDate,
          String updatedBy,
          DateTime updatedDate,
          String deletedBy,
          DateTime deletedDate}) =>
      VisitorCompanyEntry(
        id: id ?? this.id,
        fromCompany: fromCompany ?? this.fromCompany,
        fromCompanyUnsigned: fromCompanyUnsigned ?? this.fromCompanyUnsigned,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedDate: deletedDate ?? this.deletedDate,
      );
  @override
  String toString() {
    return (StringBuffer('VisitorCompanyEntry(')
          ..write('id: $id, ')
          ..write('fromCompany: $fromCompany, ')
          ..write('fromCompanyUnsigned: $fromCompanyUnsigned, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          fromCompany.hashCode,
          $mrjc(
              fromCompanyUnsigned.hashCode,
              $mrjc(
                  createdBy.hashCode,
                  $mrjc(
                      createdDate.hashCode,
                      $mrjc(
                          updatedBy.hashCode,
                          $mrjc(
                              updatedDate.hashCode,
                              $mrjc(deletedBy.hashCode,
                                  deletedDate.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is VisitorCompanyEntry &&
          other.id == this.id &&
          other.fromCompany == this.fromCompany &&
          other.fromCompanyUnsigned == this.fromCompanyUnsigned &&
          other.createdBy == this.createdBy &&
          other.createdDate == this.createdDate &&
          other.updatedBy == this.updatedBy &&
          other.updatedDate == this.updatedDate &&
          other.deletedBy == this.deletedBy &&
          other.deletedDate == this.deletedDate);
}

class VisitorCompanyEntityCompanion
    extends UpdateCompanion<VisitorCompanyEntry> {
  final Value<String> id;
  final Value<String> fromCompany;
  final Value<String> fromCompanyUnsigned;
  final Value<String> createdBy;
  final Value<DateTime> createdDate;
  final Value<String> updatedBy;
  final Value<DateTime> updatedDate;
  final Value<String> deletedBy;
  final Value<DateTime> deletedDate;
  const VisitorCompanyEntityCompanion({
    this.id = const Value.absent(),
    this.fromCompany = const Value.absent(),
    this.fromCompanyUnsigned = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  });
  VisitorCompanyEntityCompanion.insert({
    this.id = const Value.absent(),
    this.fromCompany = const Value.absent(),
    this.fromCompanyUnsigned = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  });
  static Insertable<VisitorCompanyEntry> custom({
    Expression<String> id,
    Expression<String> fromCompany,
    Expression<String> fromCompanyUnsigned,
    Expression<String> createdBy,
    Expression<DateTime> createdDate,
    Expression<String> updatedBy,
    Expression<DateTime> updatedDate,
    Expression<String> deletedBy,
    Expression<DateTime> deletedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromCompany != null) 'from_company': fromCompany,
      if (fromCompanyUnsigned != null)
        'from_company_unsigned': fromCompanyUnsigned,
      if (createdBy != null) 'created_by': createdBy,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (deletedBy != null) 'deleted_by': deletedBy,
      if (deletedDate != null) 'deleted_date': deletedDate,
    });
  }

  VisitorCompanyEntityCompanion copyWith(
      {Value<String> id,
      Value<String> fromCompany,
      Value<String> fromCompanyUnsigned,
      Value<String> createdBy,
      Value<DateTime> createdDate,
      Value<String> updatedBy,
      Value<DateTime> updatedDate,
      Value<String> deletedBy,
      Value<DateTime> deletedDate}) {
    return VisitorCompanyEntityCompanion(
      id: id ?? this.id,
      fromCompany: fromCompany ?? this.fromCompany,
      fromCompanyUnsigned: fromCompanyUnsigned ?? this.fromCompanyUnsigned,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedDate: deletedDate ?? this.deletedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fromCompany.present) {
      map['from_company'] = Variable<String>(fromCompany.value);
    }
    if (fromCompanyUnsigned.present) {
      map['from_company_unsigned'] =
          Variable<String>(fromCompanyUnsigned.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (deletedBy.present) {
      map['deleted_by'] = Variable<String>(deletedBy.value);
    }
    if (deletedDate.present) {
      map['deleted_date'] = Variable<DateTime>(deletedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitorCompanyEntityCompanion(')
          ..write('id: $id, ')
          ..write('fromCompany: $fromCompany, ')
          ..write('fromCompanyUnsigned: $fromCompanyUnsigned, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }
}

class $VisitorCompanyEntityTable extends VisitorCompanyEntity
    with TableInfo<$VisitorCompanyEntityTable, VisitorCompanyEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $VisitorCompanyEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => uuid.v1();
  }

  final VerificationMeta _fromCompanyMeta =
      const VerificationMeta('fromCompany');
  GeneratedTextColumn _fromCompany;
  @override
  GeneratedTextColumn get fromCompany =>
      _fromCompany ??= _constructFromCompany();
  GeneratedTextColumn _constructFromCompany() {
    return GeneratedTextColumn(
      'from_company',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fromCompanyUnsignedMeta =
      const VerificationMeta('fromCompanyUnsigned');
  GeneratedTextColumn _fromCompanyUnsigned;
  @override
  GeneratedTextColumn get fromCompanyUnsigned =>
      _fromCompanyUnsigned ??= _constructFromCompanyUnsigned();
  GeneratedTextColumn _constructFromCompanyUnsigned() {
    return GeneratedTextColumn(
      'from_company_unsigned',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedTextColumn _createdBy;
  @override
  GeneratedTextColumn get createdBy => _createdBy ??= _constructCreatedBy();
  GeneratedTextColumn _constructCreatedBy() {
    return GeneratedTextColumn(
      'created_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedByMeta = const VerificationMeta('updatedBy');
  GeneratedTextColumn _updatedBy;
  @override
  GeneratedTextColumn get updatedBy => _updatedBy ??= _constructUpdatedBy();
  GeneratedTextColumn _constructUpdatedBy() {
    return GeneratedTextColumn(
      'updated_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedByMeta = const VerificationMeta('deletedBy');
  GeneratedTextColumn _deletedBy;
  @override
  GeneratedTextColumn get deletedBy => _deletedBy ??= _constructDeletedBy();
  GeneratedTextColumn _constructDeletedBy() {
    return GeneratedTextColumn(
      'deleted_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedDateMeta =
      const VerificationMeta('deletedDate');
  GeneratedDateTimeColumn _deletedDate;
  @override
  GeneratedDateTimeColumn get deletedDate =>
      _deletedDate ??= _constructDeletedDate();
  GeneratedDateTimeColumn _constructDeletedDate() {
    return GeneratedDateTimeColumn(
      'deleted_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        fromCompany,
        fromCompanyUnsigned,
        createdBy,
        createdDate,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate
      ];
  @override
  $VisitorCompanyEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_visitor_company';
  @override
  final String actualTableName = 'cip_visitor_company';
  @override
  VerificationContext validateIntegrity(
      Insertable<VisitorCompanyEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('from_company')) {
      context.handle(
          _fromCompanyMeta,
          fromCompany.isAcceptableOrUnknown(
              data['from_company'], _fromCompanyMeta));
    }
    if (data.containsKey('from_company_unsigned')) {
      context.handle(
          _fromCompanyUnsignedMeta,
          fromCompanyUnsigned.isAcceptableOrUnknown(
              data['from_company_unsigned'], _fromCompanyUnsignedMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by'], _updatedByMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date'], _updatedDateMeta));
    }
    if (data.containsKey('deleted_by')) {
      context.handle(_deletedByMeta,
          deletedBy.isAcceptableOrUnknown(data['deleted_by'], _deletedByMeta));
    }
    if (data.containsKey('deleted_date')) {
      context.handle(
          _deletedDateMeta,
          deletedDate.isAcceptableOrUnknown(
              data['deleted_date'], _deletedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  VisitorCompanyEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return VisitorCompanyEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VisitorCompanyEntityTable createAlias(String alias) {
    return $VisitorCompanyEntityTable(_db, alias);
  }
}

class ContactPersonEntry extends DataClass
    implements Insertable<ContactPersonEntry> {
  final String id;
  final double idContactPerson;
  final String userName;
  final String email;
  final String phone;
  final String description;
  final String fullName;
  final String fullNameUnsigned;
  final String firstName;
  final String lastName;
  final String companyName;
  final String avatarFileName;
  final String gender;
  final String workPhoneExt;
  final String workPhoneNumber;
  final String jobTitle;
  final String createdBy;
  final DateTime createdDate;
  final String updatedBy;
  final DateTime updatedDate;
  final String deletedBy;
  final DateTime deletedDate;
  final String logoPathLocal;
  final int index;
  final String department;
  ContactPersonEntry(
      {@required this.id,
      @required this.idContactPerson,
      this.userName,
      this.email,
      this.phone,
      this.description,
      this.fullName,
      this.fullNameUnsigned,
      this.firstName,
      this.lastName,
      this.companyName,
      this.avatarFileName,
      this.gender,
      this.workPhoneExt,
      this.workPhoneNumber,
      this.jobTitle,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.deletedBy,
      this.deletedDate,
      this.logoPathLocal,
      this.index,
      this.department});
  factory ContactPersonEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final intType = db.typeSystem.forDartType<int>();
    return ContactPersonEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      idContactPerson: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_contact_person']),
      userName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_name']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      phone:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}phone']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      fullName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name']),
      fullNameUnsigned: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}full_name_unsigned']),
      firstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      companyName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_name']),
      avatarFileName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}avatar_file_name']),
      gender:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}gender']),
      workPhoneExt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}work_phone_ext']),
      workPhoneNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}work_phone_number']),
      jobTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}job_title']),
      createdBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      updatedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_by']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
      deletedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_by']),
      deletedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_date']),
      logoPathLocal: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}logo_path_local']),
      index: intType.mapFromDatabaseResponse(data['${effectivePrefix}index']),
      department: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}department']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || idContactPerson != null) {
      map['id_contact_person'] = Variable<double>(idContactPerson);
    }
    if (!nullToAbsent || userName != null) {
      map['user_name'] = Variable<String>(userName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || fullNameUnsigned != null) {
      map['full_name_unsigned'] = Variable<String>(fullNameUnsigned);
    }
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || companyName != null) {
      map['company_name'] = Variable<String>(companyName);
    }
    if (!nullToAbsent || avatarFileName != null) {
      map['avatar_file_name'] = Variable<String>(avatarFileName);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || workPhoneExt != null) {
      map['work_phone_ext'] = Variable<String>(workPhoneExt);
    }
    if (!nullToAbsent || workPhoneNumber != null) {
      map['work_phone_number'] = Variable<String>(workPhoneNumber);
    }
    if (!nullToAbsent || jobTitle != null) {
      map['job_title'] = Variable<String>(jobTitle);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || updatedDate != null) {
      map['updated_date'] = Variable<DateTime>(updatedDate);
    }
    if (!nullToAbsent || deletedBy != null) {
      map['deleted_by'] = Variable<String>(deletedBy);
    }
    if (!nullToAbsent || deletedDate != null) {
      map['deleted_date'] = Variable<DateTime>(deletedDate);
    }
    if (!nullToAbsent || logoPathLocal != null) {
      map['logo_path_local'] = Variable<String>(logoPathLocal);
    }
    if (!nullToAbsent || index != null) {
      map['index'] = Variable<int>(index);
    }
    if (!nullToAbsent || department != null) {
      map['department'] = Variable<String>(department);
    }
    return map;
  }

  ContactPersonEntityCompanion toCompanion(bool nullToAbsent) {
    return ContactPersonEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idContactPerson: idContactPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(idContactPerson),
      userName: userName == null && nullToAbsent
          ? const Value.absent()
          : Value(userName),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      fullNameUnsigned: fullNameUnsigned == null && nullToAbsent
          ? const Value.absent()
          : Value(fullNameUnsigned),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      companyName: companyName == null && nullToAbsent
          ? const Value.absent()
          : Value(companyName),
      avatarFileName: avatarFileName == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarFileName),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      workPhoneExt: workPhoneExt == null && nullToAbsent
          ? const Value.absent()
          : Value(workPhoneExt),
      workPhoneNumber: workPhoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(workPhoneNumber),
      jobTitle: jobTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(jobTitle),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
      deletedBy: deletedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedBy),
      deletedDate: deletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedDate),
      logoPathLocal: logoPathLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPathLocal),
      index:
          index == null && nullToAbsent ? const Value.absent() : Value(index),
      department: department == null && nullToAbsent
          ? const Value.absent()
          : Value(department),
    );
  }

  factory ContactPersonEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ContactPersonEntry(
      id: serializer.fromJson<String>(json['id']),
      idContactPerson: serializer.fromJson<double>(json['idContactPerson']),
      userName: serializer.fromJson<String>(json['userName']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      description: serializer.fromJson<String>(json['description']),
      fullName: serializer.fromJson<String>(json['fullName']),
      fullNameUnsigned: serializer.fromJson<String>(json['fullNameUnsigned']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      companyName: serializer.fromJson<String>(json['companyName']),
      avatarFileName: serializer.fromJson<String>(json['avatarFileName']),
      gender: serializer.fromJson<String>(json['gender']),
      workPhoneExt: serializer.fromJson<String>(json['workPhoneExt']),
      workPhoneNumber: serializer.fromJson<String>(json['workPhoneNumber']),
      jobTitle: serializer.fromJson<String>(json['jobTitle']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      deletedBy: serializer.fromJson<String>(json['deletedBy']),
      deletedDate: serializer.fromJson<DateTime>(json['deletedDate']),
      logoPathLocal: serializer.fromJson<String>(json['logoPathLocal']),
      index: serializer.fromJson<int>(json['index']),
      department: serializer.fromJson<String>(json['department']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'idContactPerson': serializer.toJson<double>(idContactPerson),
      'userName': serializer.toJson<String>(userName),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'description': serializer.toJson<String>(description),
      'fullName': serializer.toJson<String>(fullName),
      'fullNameUnsigned': serializer.toJson<String>(fullNameUnsigned),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'companyName': serializer.toJson<String>(companyName),
      'avatarFileName': serializer.toJson<String>(avatarFileName),
      'gender': serializer.toJson<String>(gender),
      'workPhoneExt': serializer.toJson<String>(workPhoneExt),
      'workPhoneNumber': serializer.toJson<String>(workPhoneNumber),
      'jobTitle': serializer.toJson<String>(jobTitle),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'deletedBy': serializer.toJson<String>(deletedBy),
      'deletedDate': serializer.toJson<DateTime>(deletedDate),
      'logoPathLocal': serializer.toJson<String>(logoPathLocal),
      'index': serializer.toJson<int>(index),
      'department': serializer.toJson<String>(department),
    };
  }

  ContactPersonEntry copyWith(
          {String id,
          double idContactPerson,
          String userName,
          String email,
          String phone,
          String description,
          String fullName,
          String fullNameUnsigned,
          String firstName,
          String lastName,
          String companyName,
          String avatarFileName,
          String gender,
          String workPhoneExt,
          String workPhoneNumber,
          String jobTitle,
          String createdBy,
          DateTime createdDate,
          String updatedBy,
          DateTime updatedDate,
          String deletedBy,
          DateTime deletedDate,
          String logoPathLocal,
          int index,
          String department}) =>
      ContactPersonEntry(
        id: id ?? this.id,
        idContactPerson: idContactPerson ?? this.idContactPerson,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        description: description ?? this.description,
        fullName: fullName ?? this.fullName,
        fullNameUnsigned: fullNameUnsigned ?? this.fullNameUnsigned,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        companyName: companyName ?? this.companyName,
        avatarFileName: avatarFileName ?? this.avatarFileName,
        gender: gender ?? this.gender,
        workPhoneExt: workPhoneExt ?? this.workPhoneExt,
        workPhoneNumber: workPhoneNumber ?? this.workPhoneNumber,
        jobTitle: jobTitle ?? this.jobTitle,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedDate: deletedDate ?? this.deletedDate,
        logoPathLocal: logoPathLocal ?? this.logoPathLocal,
        index: index ?? this.index,
        department: department ?? this.department,
      );
  @override
  String toString() {
    return (StringBuffer('ContactPersonEntry(')
          ..write('id: $id, ')
          ..write('idContactPerson: $idContactPerson, ')
          ..write('userName: $userName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('description: $description, ')
          ..write('fullName: $fullName, ')
          ..write('fullNameUnsigned: $fullNameUnsigned, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('companyName: $companyName, ')
          ..write('avatarFileName: $avatarFileName, ')
          ..write('gender: $gender, ')
          ..write('workPhoneExt: $workPhoneExt, ')
          ..write('workPhoneNumber: $workPhoneNumber, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate, ')
          ..write('logoPathLocal: $logoPathLocal, ')
          ..write('index: $index, ')
          ..write('department: $department')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          idContactPerson.hashCode,
          $mrjc(
              userName.hashCode,
              $mrjc(
                  email.hashCode,
                  $mrjc(
                      phone.hashCode,
                      $mrjc(
                          description.hashCode,
                          $mrjc(
                              fullName.hashCode,
                              $mrjc(
                                  fullNameUnsigned.hashCode,
                                  $mrjc(
                                      firstName.hashCode,
                                      $mrjc(
                                          lastName.hashCode,
                                          $mrjc(
                                              companyName.hashCode,
                                              $mrjc(
                                                  avatarFileName.hashCode,
                                                  $mrjc(
                                                      gender.hashCode,
                                                      $mrjc(
                                                          workPhoneExt.hashCode,
                                                          $mrjc(
                                                              workPhoneNumber
                                                                  .hashCode,
                                                              $mrjc(
                                                                  jobTitle
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      createdBy
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          createdDate
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              updatedBy.hashCode,
                                                                              $mrjc(updatedDate.hashCode, $mrjc(deletedBy.hashCode, $mrjc(deletedDate.hashCode, $mrjc(logoPathLocal.hashCode, $mrjc(index.hashCode, department.hashCode)))))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ContactPersonEntry &&
          other.id == this.id &&
          other.idContactPerson == this.idContactPerson &&
          other.userName == this.userName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.description == this.description &&
          other.fullName == this.fullName &&
          other.fullNameUnsigned == this.fullNameUnsigned &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.companyName == this.companyName &&
          other.avatarFileName == this.avatarFileName &&
          other.gender == this.gender &&
          other.workPhoneExt == this.workPhoneExt &&
          other.workPhoneNumber == this.workPhoneNumber &&
          other.jobTitle == this.jobTitle &&
          other.createdBy == this.createdBy &&
          other.createdDate == this.createdDate &&
          other.updatedBy == this.updatedBy &&
          other.updatedDate == this.updatedDate &&
          other.deletedBy == this.deletedBy &&
          other.deletedDate == this.deletedDate &&
          other.logoPathLocal == this.logoPathLocal &&
          other.index == this.index &&
          other.department == this.department);
}

class ContactPersonEntityCompanion extends UpdateCompanion<ContactPersonEntry> {
  final Value<String> id;
  final Value<double> idContactPerson;
  final Value<String> userName;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> description;
  final Value<String> fullName;
  final Value<String> fullNameUnsigned;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> companyName;
  final Value<String> avatarFileName;
  final Value<String> gender;
  final Value<String> workPhoneExt;
  final Value<String> workPhoneNumber;
  final Value<String> jobTitle;
  final Value<String> createdBy;
  final Value<DateTime> createdDate;
  final Value<String> updatedBy;
  final Value<DateTime> updatedDate;
  final Value<String> deletedBy;
  final Value<DateTime> deletedDate;
  final Value<String> logoPathLocal;
  final Value<int> index;
  final Value<String> department;
  const ContactPersonEntityCompanion({
    this.id = const Value.absent(),
    this.idContactPerson = const Value.absent(),
    this.userName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.description = const Value.absent(),
    this.fullName = const Value.absent(),
    this.fullNameUnsigned = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.companyName = const Value.absent(),
    this.avatarFileName = const Value.absent(),
    this.gender = const Value.absent(),
    this.workPhoneExt = const Value.absent(),
    this.workPhoneNumber = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
    this.logoPathLocal = const Value.absent(),
    this.index = const Value.absent(),
    this.department = const Value.absent(),
  });
  ContactPersonEntityCompanion.insert({
    this.id = const Value.absent(),
    @required double idContactPerson,
    this.userName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.description = const Value.absent(),
    this.fullName = const Value.absent(),
    this.fullNameUnsigned = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.companyName = const Value.absent(),
    this.avatarFileName = const Value.absent(),
    this.gender = const Value.absent(),
    this.workPhoneExt = const Value.absent(),
    this.workPhoneNumber = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
    this.logoPathLocal = const Value.absent(),
    this.index = const Value.absent(),
    this.department = const Value.absent(),
  }) : idContactPerson = Value(idContactPerson);
  static Insertable<ContactPersonEntry> custom({
    Expression<String> id,
    Expression<double> idContactPerson,
    Expression<String> userName,
    Expression<String> email,
    Expression<String> phone,
    Expression<String> description,
    Expression<String> fullName,
    Expression<String> fullNameUnsigned,
    Expression<String> firstName,
    Expression<String> lastName,
    Expression<String> companyName,
    Expression<String> avatarFileName,
    Expression<String> gender,
    Expression<String> workPhoneExt,
    Expression<String> workPhoneNumber,
    Expression<String> jobTitle,
    Expression<String> createdBy,
    Expression<DateTime> createdDate,
    Expression<String> updatedBy,
    Expression<DateTime> updatedDate,
    Expression<String> deletedBy,
    Expression<DateTime> deletedDate,
    Expression<String> logoPathLocal,
    Expression<int> index,
    Expression<String> department,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idContactPerson != null) 'id_contact_person': idContactPerson,
      if (userName != null) 'user_name': userName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (description != null) 'description': description,
      if (fullName != null) 'full_name': fullName,
      if (fullNameUnsigned != null) 'full_name_unsigned': fullNameUnsigned,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (companyName != null) 'company_name': companyName,
      if (avatarFileName != null) 'avatar_file_name': avatarFileName,
      if (gender != null) 'gender': gender,
      if (workPhoneExt != null) 'work_phone_ext': workPhoneExt,
      if (workPhoneNumber != null) 'work_phone_number': workPhoneNumber,
      if (jobTitle != null) 'job_title': jobTitle,
      if (createdBy != null) 'created_by': createdBy,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (deletedBy != null) 'deleted_by': deletedBy,
      if (deletedDate != null) 'deleted_date': deletedDate,
      if (logoPathLocal != null) 'logo_path_local': logoPathLocal,
      if (index != null) 'index': index,
      if (department != null) 'department': department,
    });
  }

  ContactPersonEntityCompanion copyWith(
      {Value<String> id,
      Value<double> idContactPerson,
      Value<String> userName,
      Value<String> email,
      Value<String> phone,
      Value<String> description,
      Value<String> fullName,
      Value<String> fullNameUnsigned,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> companyName,
      Value<String> avatarFileName,
      Value<String> gender,
      Value<String> workPhoneExt,
      Value<String> workPhoneNumber,
      Value<String> jobTitle,
      Value<String> createdBy,
      Value<DateTime> createdDate,
      Value<String> updatedBy,
      Value<DateTime> updatedDate,
      Value<String> deletedBy,
      Value<DateTime> deletedDate,
      Value<String> logoPathLocal,
      Value<int> index,
      Value<String> department}) {
    return ContactPersonEntityCompanion(
      id: id ?? this.id,
      idContactPerson: idContactPerson ?? this.idContactPerson,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      fullName: fullName ?? this.fullName,
      fullNameUnsigned: fullNameUnsigned ?? this.fullNameUnsigned,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      companyName: companyName ?? this.companyName,
      avatarFileName: avatarFileName ?? this.avatarFileName,
      gender: gender ?? this.gender,
      workPhoneExt: workPhoneExt ?? this.workPhoneExt,
      workPhoneNumber: workPhoneNumber ?? this.workPhoneNumber,
      jobTitle: jobTitle ?? this.jobTitle,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedDate: deletedDate ?? this.deletedDate,
      logoPathLocal: logoPathLocal ?? this.logoPathLocal,
      index: index ?? this.index,
      department: department ?? this.department,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (idContactPerson.present) {
      map['id_contact_person'] = Variable<double>(idContactPerson.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (fullNameUnsigned.present) {
      map['full_name_unsigned'] = Variable<String>(fullNameUnsigned.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (avatarFileName.present) {
      map['avatar_file_name'] = Variable<String>(avatarFileName.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (workPhoneExt.present) {
      map['work_phone_ext'] = Variable<String>(workPhoneExt.value);
    }
    if (workPhoneNumber.present) {
      map['work_phone_number'] = Variable<String>(workPhoneNumber.value);
    }
    if (jobTitle.present) {
      map['job_title'] = Variable<String>(jobTitle.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (deletedBy.present) {
      map['deleted_by'] = Variable<String>(deletedBy.value);
    }
    if (deletedDate.present) {
      map['deleted_date'] = Variable<DateTime>(deletedDate.value);
    }
    if (logoPathLocal.present) {
      map['logo_path_local'] = Variable<String>(logoPathLocal.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactPersonEntityCompanion(')
          ..write('id: $id, ')
          ..write('idContactPerson: $idContactPerson, ')
          ..write('userName: $userName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('description: $description, ')
          ..write('fullName: $fullName, ')
          ..write('fullNameUnsigned: $fullNameUnsigned, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('companyName: $companyName, ')
          ..write('avatarFileName: $avatarFileName, ')
          ..write('gender: $gender, ')
          ..write('workPhoneExt: $workPhoneExt, ')
          ..write('workPhoneNumber: $workPhoneNumber, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate, ')
          ..write('logoPathLocal: $logoPathLocal, ')
          ..write('index: $index, ')
          ..write('department: $department')
          ..write(')'))
        .toString();
  }
}

class $ContactPersonEntityTable extends ContactPersonEntity
    with TableInfo<$ContactPersonEntityTable, ContactPersonEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ContactPersonEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => uuid.v1();
  }

  final VerificationMeta _idContactPersonMeta =
      const VerificationMeta('idContactPerson');
  GeneratedRealColumn _idContactPerson;
  @override
  GeneratedRealColumn get idContactPerson =>
      _idContactPerson ??= _constructIdContactPerson();
  GeneratedRealColumn _constructIdContactPerson() {
    return GeneratedRealColumn(
      'id_contact_person',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userNameMeta = const VerificationMeta('userName');
  GeneratedTextColumn _userName;
  @override
  GeneratedTextColumn get userName => _userName ??= _constructUserName();
  GeneratedTextColumn _constructUserName() {
    return GeneratedTextColumn(
      'user_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      true,
    );
  }

  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  GeneratedTextColumn _phone;
  @override
  GeneratedTextColumn get phone => _phone ??= _constructPhone();
  GeneratedTextColumn _constructPhone() {
    return GeneratedTextColumn(
      'phone',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fullNameMeta = const VerificationMeta('fullName');
  GeneratedTextColumn _fullName;
  @override
  GeneratedTextColumn get fullName => _fullName ??= _constructFullName();
  GeneratedTextColumn _constructFullName() {
    return GeneratedTextColumn(
      'full_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fullNameUnsignedMeta =
      const VerificationMeta('fullNameUnsigned');
  GeneratedTextColumn _fullNameUnsigned;
  @override
  GeneratedTextColumn get fullNameUnsigned =>
      _fullNameUnsigned ??= _constructFullNameUnsigned();
  GeneratedTextColumn _constructFullNameUnsigned() {
    return GeneratedTextColumn(
      'full_name_unsigned',
      $tableName,
      true,
    );
  }

  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  GeneratedTextColumn _firstName;
  @override
  GeneratedTextColumn get firstName => _firstName ??= _constructFirstName();
  GeneratedTextColumn _constructFirstName() {
    return GeneratedTextColumn(
      'first_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  GeneratedTextColumn _lastName;
  @override
  GeneratedTextColumn get lastName => _lastName ??= _constructLastName();
  GeneratedTextColumn _constructLastName() {
    return GeneratedTextColumn(
      'last_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  GeneratedTextColumn _companyName;
  @override
  GeneratedTextColumn get companyName =>
      _companyName ??= _constructCompanyName();
  GeneratedTextColumn _constructCompanyName() {
    return GeneratedTextColumn(
      'company_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _avatarFileNameMeta =
      const VerificationMeta('avatarFileName');
  GeneratedTextColumn _avatarFileName;
  @override
  GeneratedTextColumn get avatarFileName =>
      _avatarFileName ??= _constructAvatarFileName();
  GeneratedTextColumn _constructAvatarFileName() {
    return GeneratedTextColumn(
      'avatar_file_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  GeneratedTextColumn _gender;
  @override
  GeneratedTextColumn get gender => _gender ??= _constructGender();
  GeneratedTextColumn _constructGender() {
    return GeneratedTextColumn(
      'gender',
      $tableName,
      true,
    );
  }

  final VerificationMeta _workPhoneExtMeta =
      const VerificationMeta('workPhoneExt');
  GeneratedTextColumn _workPhoneExt;
  @override
  GeneratedTextColumn get workPhoneExt =>
      _workPhoneExt ??= _constructWorkPhoneExt();
  GeneratedTextColumn _constructWorkPhoneExt() {
    return GeneratedTextColumn(
      'work_phone_ext',
      $tableName,
      true,
    );
  }

  final VerificationMeta _workPhoneNumberMeta =
      const VerificationMeta('workPhoneNumber');
  GeneratedTextColumn _workPhoneNumber;
  @override
  GeneratedTextColumn get workPhoneNumber =>
      _workPhoneNumber ??= _constructWorkPhoneNumber();
  GeneratedTextColumn _constructWorkPhoneNumber() {
    return GeneratedTextColumn(
      'work_phone_number',
      $tableName,
      true,
    );
  }

  final VerificationMeta _jobTitleMeta = const VerificationMeta('jobTitle');
  GeneratedTextColumn _jobTitle;
  @override
  GeneratedTextColumn get jobTitle => _jobTitle ??= _constructJobTitle();
  GeneratedTextColumn _constructJobTitle() {
    return GeneratedTextColumn(
      'job_title',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedTextColumn _createdBy;
  @override
  GeneratedTextColumn get createdBy => _createdBy ??= _constructCreatedBy();
  GeneratedTextColumn _constructCreatedBy() {
    return GeneratedTextColumn(
      'created_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedByMeta = const VerificationMeta('updatedBy');
  GeneratedTextColumn _updatedBy;
  @override
  GeneratedTextColumn get updatedBy => _updatedBy ??= _constructUpdatedBy();
  GeneratedTextColumn _constructUpdatedBy() {
    return GeneratedTextColumn(
      'updated_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedByMeta = const VerificationMeta('deletedBy');
  GeneratedTextColumn _deletedBy;
  @override
  GeneratedTextColumn get deletedBy => _deletedBy ??= _constructDeletedBy();
  GeneratedTextColumn _constructDeletedBy() {
    return GeneratedTextColumn(
      'deleted_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedDateMeta =
      const VerificationMeta('deletedDate');
  GeneratedDateTimeColumn _deletedDate;
  @override
  GeneratedDateTimeColumn get deletedDate =>
      _deletedDate ??= _constructDeletedDate();
  GeneratedDateTimeColumn _constructDeletedDate() {
    return GeneratedDateTimeColumn(
      'deleted_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _logoPathLocalMeta =
      const VerificationMeta('logoPathLocal');
  GeneratedTextColumn _logoPathLocal;
  @override
  GeneratedTextColumn get logoPathLocal =>
      _logoPathLocal ??= _constructLogoPathLocal();
  GeneratedTextColumn _constructLogoPathLocal() {
    return GeneratedTextColumn(
      'logo_path_local',
      $tableName,
      true,
    );
  }

  final VerificationMeta _indexMeta = const VerificationMeta('index');
  GeneratedIntColumn _index;
  @override
  GeneratedIntColumn get index => _index ??= _constructIndex();
  GeneratedIntColumn _constructIndex() {
    return GeneratedIntColumn(
      'index',
      $tableName,
      true,
    );
  }

  final VerificationMeta _departmentMeta = const VerificationMeta('department');
  GeneratedTextColumn _department;
  @override
  GeneratedTextColumn get department => _department ??= _constructDepartment();
  GeneratedTextColumn _constructDepartment() {
    return GeneratedTextColumn(
      'department',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        idContactPerson,
        userName,
        email,
        phone,
        description,
        fullName,
        fullNameUnsigned,
        firstName,
        lastName,
        companyName,
        avatarFileName,
        gender,
        workPhoneExt,
        workPhoneNumber,
        jobTitle,
        createdBy,
        createdDate,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate,
        logoPathLocal,
        index,
        department
      ];
  @override
  $ContactPersonEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_contact_person';
  @override
  final String actualTableName = 'cip_contact_person';
  @override
  VerificationContext validateIntegrity(Insertable<ContactPersonEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('id_contact_person')) {
      context.handle(
          _idContactPersonMeta,
          idContactPerson.isAcceptableOrUnknown(
              data['id_contact_person'], _idContactPersonMeta));
    } else if (isInserting) {
      context.missing(_idContactPersonMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name'], _userNameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone'], _phoneMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name'], _fullNameMeta));
    }
    if (data.containsKey('full_name_unsigned')) {
      context.handle(
          _fullNameUnsignedMeta,
          fullNameUnsigned.isAcceptableOrUnknown(
              data['full_name_unsigned'], _fullNameUnsignedMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name'], _firstNameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name'], _lastNameMeta));
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name'], _companyNameMeta));
    }
    if (data.containsKey('avatar_file_name')) {
      context.handle(
          _avatarFileNameMeta,
          avatarFileName.isAcceptableOrUnknown(
              data['avatar_file_name'], _avatarFileNameMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender'], _genderMeta));
    }
    if (data.containsKey('work_phone_ext')) {
      context.handle(
          _workPhoneExtMeta,
          workPhoneExt.isAcceptableOrUnknown(
              data['work_phone_ext'], _workPhoneExtMeta));
    }
    if (data.containsKey('work_phone_number')) {
      context.handle(
          _workPhoneNumberMeta,
          workPhoneNumber.isAcceptableOrUnknown(
              data['work_phone_number'], _workPhoneNumberMeta));
    }
    if (data.containsKey('job_title')) {
      context.handle(_jobTitleMeta,
          jobTitle.isAcceptableOrUnknown(data['job_title'], _jobTitleMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by'], _updatedByMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date'], _updatedDateMeta));
    }
    if (data.containsKey('deleted_by')) {
      context.handle(_deletedByMeta,
          deletedBy.isAcceptableOrUnknown(data['deleted_by'], _deletedByMeta));
    }
    if (data.containsKey('deleted_date')) {
      context.handle(
          _deletedDateMeta,
          deletedDate.isAcceptableOrUnknown(
              data['deleted_date'], _deletedDateMeta));
    }
    if (data.containsKey('logo_path_local')) {
      context.handle(
          _logoPathLocalMeta,
          logoPathLocal.isAcceptableOrUnknown(
              data['logo_path_local'], _logoPathLocalMeta));
    }
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index'], _indexMeta));
    }
    if (data.containsKey('department')) {
      context.handle(
          _departmentMeta,
          department.isAcceptableOrUnknown(
              data['department'], _departmentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactPersonEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ContactPersonEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ContactPersonEntityTable createAlias(String alias) {
    return $ContactPersonEntityTable(_db, alias);
  }
}

class VisitorValueEntry extends DataClass
    implements Insertable<VisitorValueEntry> {
  final String settingKey;
  final String vi;
  final String en;
  final String createdBy;
  final DateTime createdDate;
  final String updatedBy;
  final DateTime updatedDate;
  final String deletedBy;
  final DateTime deletedDate;
  VisitorValueEntry(
      {this.settingKey,
      this.vi,
      this.en,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.deletedBy,
      this.deletedDate});
  factory VisitorValueEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return VisitorValueEntry(
      settingKey: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}setting_key']),
      vi: stringType.mapFromDatabaseResponse(data['${effectivePrefix}vi']),
      en: stringType.mapFromDatabaseResponse(data['${effectivePrefix}en']),
      createdBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      updatedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_by']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
      deletedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_by']),
      deletedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || settingKey != null) {
      map['setting_key'] = Variable<String>(settingKey);
    }
    if (!nullToAbsent || vi != null) {
      map['vi'] = Variable<String>(vi);
    }
    if (!nullToAbsent || en != null) {
      map['en'] = Variable<String>(en);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || updatedDate != null) {
      map['updated_date'] = Variable<DateTime>(updatedDate);
    }
    if (!nullToAbsent || deletedBy != null) {
      map['deleted_by'] = Variable<String>(deletedBy);
    }
    if (!nullToAbsent || deletedDate != null) {
      map['deleted_date'] = Variable<DateTime>(deletedDate);
    }
    return map;
  }

  VisitorValueEntityCompanion toCompanion(bool nullToAbsent) {
    return VisitorValueEntityCompanion(
      settingKey: settingKey == null && nullToAbsent
          ? const Value.absent()
          : Value(settingKey),
      vi: vi == null && nullToAbsent ? const Value.absent() : Value(vi),
      en: en == null && nullToAbsent ? const Value.absent() : Value(en),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
      deletedBy: deletedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedBy),
      deletedDate: deletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedDate),
    );
  }

  factory VisitorValueEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VisitorValueEntry(
      settingKey: serializer.fromJson<String>(json['settingKey']),
      vi: serializer.fromJson<String>(json['vi']),
      en: serializer.fromJson<String>(json['en']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      deletedBy: serializer.fromJson<String>(json['deletedBy']),
      deletedDate: serializer.fromJson<DateTime>(json['deletedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'settingKey': serializer.toJson<String>(settingKey),
      'vi': serializer.toJson<String>(vi),
      'en': serializer.toJson<String>(en),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'deletedBy': serializer.toJson<String>(deletedBy),
      'deletedDate': serializer.toJson<DateTime>(deletedDate),
    };
  }

  VisitorValueEntry copyWith(
          {String settingKey,
          String vi,
          String en,
          String createdBy,
          DateTime createdDate,
          String updatedBy,
          DateTime updatedDate,
          String deletedBy,
          DateTime deletedDate}) =>
      VisitorValueEntry(
        settingKey: settingKey ?? this.settingKey,
        vi: vi ?? this.vi,
        en: en ?? this.en,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedDate: deletedDate ?? this.deletedDate,
      );
  @override
  String toString() {
    return (StringBuffer('VisitorValueEntry(')
          ..write('settingKey: $settingKey, ')
          ..write('vi: $vi, ')
          ..write('en: $en, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      settingKey.hashCode,
      $mrjc(
          vi.hashCode,
          $mrjc(
              en.hashCode,
              $mrjc(
                  createdBy.hashCode,
                  $mrjc(
                      createdDate.hashCode,
                      $mrjc(
                          updatedBy.hashCode,
                          $mrjc(
                              updatedDate.hashCode,
                              $mrjc(deletedBy.hashCode,
                                  deletedDate.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is VisitorValueEntry &&
          other.settingKey == this.settingKey &&
          other.vi == this.vi &&
          other.en == this.en &&
          other.createdBy == this.createdBy &&
          other.createdDate == this.createdDate &&
          other.updatedBy == this.updatedBy &&
          other.updatedDate == this.updatedDate &&
          other.deletedBy == this.deletedBy &&
          other.deletedDate == this.deletedDate);
}

class VisitorValueEntityCompanion extends UpdateCompanion<VisitorValueEntry> {
  final Value<String> settingKey;
  final Value<String> vi;
  final Value<String> en;
  final Value<String> createdBy;
  final Value<DateTime> createdDate;
  final Value<String> updatedBy;
  final Value<DateTime> updatedDate;
  final Value<String> deletedBy;
  final Value<DateTime> deletedDate;
  const VisitorValueEntityCompanion({
    this.settingKey = const Value.absent(),
    this.vi = const Value.absent(),
    this.en = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  });
  VisitorValueEntityCompanion.insert({
    this.settingKey = const Value.absent(),
    this.vi = const Value.absent(),
    this.en = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.deletedBy = const Value.absent(),
    this.deletedDate = const Value.absent(),
  });
  static Insertable<VisitorValueEntry> custom({
    Expression<String> settingKey,
    Expression<String> vi,
    Expression<String> en,
    Expression<String> createdBy,
    Expression<DateTime> createdDate,
    Expression<String> updatedBy,
    Expression<DateTime> updatedDate,
    Expression<String> deletedBy,
    Expression<DateTime> deletedDate,
  }) {
    return RawValuesInsertable({
      if (settingKey != null) 'setting_key': settingKey,
      if (vi != null) 'vi': vi,
      if (en != null) 'en': en,
      if (createdBy != null) 'created_by': createdBy,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (deletedBy != null) 'deleted_by': deletedBy,
      if (deletedDate != null) 'deleted_date': deletedDate,
    });
  }

  VisitorValueEntityCompanion copyWith(
      {Value<String> settingKey,
      Value<String> vi,
      Value<String> en,
      Value<String> createdBy,
      Value<DateTime> createdDate,
      Value<String> updatedBy,
      Value<DateTime> updatedDate,
      Value<String> deletedBy,
      Value<DateTime> deletedDate}) {
    return VisitorValueEntityCompanion(
      settingKey: settingKey ?? this.settingKey,
      vi: vi ?? this.vi,
      en: en ?? this.en,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedDate: deletedDate ?? this.deletedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (settingKey.present) {
      map['setting_key'] = Variable<String>(settingKey.value);
    }
    if (vi.present) {
      map['vi'] = Variable<String>(vi.value);
    }
    if (en.present) {
      map['en'] = Variable<String>(en.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (deletedBy.present) {
      map['deleted_by'] = Variable<String>(deletedBy.value);
    }
    if (deletedDate.present) {
      map['deleted_date'] = Variable<DateTime>(deletedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitorValueEntityCompanion(')
          ..write('settingKey: $settingKey, ')
          ..write('vi: $vi, ')
          ..write('en: $en, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('deletedBy: $deletedBy, ')
          ..write('deletedDate: $deletedDate')
          ..write(')'))
        .toString();
  }
}

class $VisitorValueEntityTable extends VisitorValueEntity
    with TableInfo<$VisitorValueEntityTable, VisitorValueEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $VisitorValueEntityTable(this._db, [this._alias]);
  final VerificationMeta _settingKeyMeta = const VerificationMeta('settingKey');
  GeneratedTextColumn _settingKey;
  @override
  GeneratedTextColumn get settingKey => _settingKey ??= _constructSettingKey();
  GeneratedTextColumn _constructSettingKey() {
    return GeneratedTextColumn(
      'setting_key',
      $tableName,
      true,
    );
  }

  final VerificationMeta _viMeta = const VerificationMeta('vi');
  GeneratedTextColumn _vi;
  @override
  GeneratedTextColumn get vi => _vi ??= _constructVi();
  GeneratedTextColumn _constructVi() {
    return GeneratedTextColumn(
      'vi',
      $tableName,
      true,
    );
  }

  final VerificationMeta _enMeta = const VerificationMeta('en');
  GeneratedTextColumn _en;
  @override
  GeneratedTextColumn get en => _en ??= _constructEn();
  GeneratedTextColumn _constructEn() {
    return GeneratedTextColumn(
      'en',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedTextColumn _createdBy;
  @override
  GeneratedTextColumn get createdBy => _createdBy ??= _constructCreatedBy();
  GeneratedTextColumn _constructCreatedBy() {
    return GeneratedTextColumn(
      'created_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedByMeta = const VerificationMeta('updatedBy');
  GeneratedTextColumn _updatedBy;
  @override
  GeneratedTextColumn get updatedBy => _updatedBy ??= _constructUpdatedBy();
  GeneratedTextColumn _constructUpdatedBy() {
    return GeneratedTextColumn(
      'updated_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedByMeta = const VerificationMeta('deletedBy');
  GeneratedTextColumn _deletedBy;
  @override
  GeneratedTextColumn get deletedBy => _deletedBy ??= _constructDeletedBy();
  GeneratedTextColumn _constructDeletedBy() {
    return GeneratedTextColumn(
      'deleted_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deletedDateMeta =
      const VerificationMeta('deletedDate');
  GeneratedDateTimeColumn _deletedDate;
  @override
  GeneratedDateTimeColumn get deletedDate =>
      _deletedDate ??= _constructDeletedDate();
  GeneratedDateTimeColumn _constructDeletedDate() {
    return GeneratedDateTimeColumn(
      'deleted_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        settingKey,
        vi,
        en,
        createdBy,
        createdDate,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate
      ];
  @override
  $VisitorValueEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_visitor_value';
  @override
  final String actualTableName = 'cip_visitor_value';
  @override
  VerificationContext validateIntegrity(Insertable<VisitorValueEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('setting_key')) {
      context.handle(
          _settingKeyMeta,
          settingKey.isAcceptableOrUnknown(
              data['setting_key'], _settingKeyMeta));
    }
    if (data.containsKey('vi')) {
      context.handle(_viMeta, vi.isAcceptableOrUnknown(data['vi'], _viMeta));
    }
    if (data.containsKey('en')) {
      context.handle(_enMeta, en.isAcceptableOrUnknown(data['en'], _enMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by'], _updatedByMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date'], _updatedDateMeta));
    }
    if (data.containsKey('deleted_by')) {
      context.handle(_deletedByMeta,
          deletedBy.isAcceptableOrUnknown(data['deleted_by'], _deletedByMeta));
    }
    if (data.containsKey('deleted_date')) {
      context.handle(
          _deletedDateMeta,
          deletedDate.isAcceptableOrUnknown(
              data['deleted_date'], _deletedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  VisitorValueEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return VisitorValueEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VisitorValueEntityTable createAlias(String alias) {
    return $VisitorValueEntityTable(_db, alias);
  }
}

class EventLogEntry extends DataClass implements Insertable<EventLogEntry> {
  final String id;
  final double guestId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String inviteCode;
  final String timeZone;
  final String idCard;
  final String signInType;
  final String signOutType;
  final int signInBy;
  final String imagePath;
  final String imageIdPath;
  final double eventId;
  final int signIn;
  final int signOut;
  final String feedback;
  final String status;
  final String visitorType;
  final int branchId;
  final int rating;
  final bool syncFail;
  final bool isNew;
  final String faceCaptureFile;
  EventLogEntry(
      {@required this.id,
      this.guestId,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.inviteCode,
      this.timeZone,
      this.idCard,
      this.signInType,
      this.signOutType,
      this.signInBy,
      this.imagePath,
      this.imageIdPath,
      this.eventId,
      this.signIn,
      this.signOut,
      this.feedback,
      this.status,
      this.visitorType,
      this.branchId,
      this.rating,
      this.syncFail,
      this.isNew,
      this.faceCaptureFile});
  factory EventLogEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return EventLogEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      guestId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}guest_id']),
      fullName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      phoneNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number']),
      inviteCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}invite_code']),
      timeZone: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}time_zone']),
      idCard:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}id_card']),
      signInType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sign_in_type']),
      signOutType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sign_out_type']),
      signInBy:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sign_in_by']),
      imagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
      imageIdPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_id_path']),
      eventId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}event_id']),
      signIn:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sign_in']),
      signOut:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sign_out']),
      feedback: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}feedback']),
      status:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      visitorType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visitor_type']),
      branchId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}branch_id']),
      rating: intType.mapFromDatabaseResponse(data['${effectivePrefix}rating']),
      syncFail:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}sync_fail']),
      isNew: boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_new']),
      faceCaptureFile: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}face_capture_file']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || guestId != null) {
      map['guest_id'] = Variable<double>(guestId);
    }
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || inviteCode != null) {
      map['invite_code'] = Variable<String>(inviteCode);
    }
    if (!nullToAbsent || timeZone != null) {
      map['time_zone'] = Variable<String>(timeZone);
    }
    if (!nullToAbsent || idCard != null) {
      map['id_card'] = Variable<String>(idCard);
    }
    if (!nullToAbsent || signInType != null) {
      map['sign_in_type'] = Variable<String>(signInType);
    }
    if (!nullToAbsent || signOutType != null) {
      map['sign_out_type'] = Variable<String>(signOutType);
    }
    if (!nullToAbsent || signInBy != null) {
      map['sign_in_by'] = Variable<int>(signInBy);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || imageIdPath != null) {
      map['image_id_path'] = Variable<String>(imageIdPath);
    }
    if (!nullToAbsent || eventId != null) {
      map['event_id'] = Variable<double>(eventId);
    }
    if (!nullToAbsent || signIn != null) {
      map['sign_in'] = Variable<int>(signIn);
    }
    if (!nullToAbsent || signOut != null) {
      map['sign_out'] = Variable<int>(signOut);
    }
    if (!nullToAbsent || feedback != null) {
      map['feedback'] = Variable<String>(feedback);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || visitorType != null) {
      map['visitor_type'] = Variable<String>(visitorType);
    }
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<int>(branchId);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    if (!nullToAbsent || syncFail != null) {
      map['sync_fail'] = Variable<bool>(syncFail);
    }
    if (!nullToAbsent || isNew != null) {
      map['is_new'] = Variable<bool>(isNew);
    }
    if (!nullToAbsent || faceCaptureFile != null) {
      map['face_capture_file'] = Variable<String>(faceCaptureFile);
    }
    return map;
  }

  EventLogEntityCompanion toCompanion(bool nullToAbsent) {
    return EventLogEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      guestId: guestId == null && nullToAbsent
          ? const Value.absent()
          : Value(guestId),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      inviteCode: inviteCode == null && nullToAbsent
          ? const Value.absent()
          : Value(inviteCode),
      timeZone: timeZone == null && nullToAbsent
          ? const Value.absent()
          : Value(timeZone),
      idCard:
          idCard == null && nullToAbsent ? const Value.absent() : Value(idCard),
      signInType: signInType == null && nullToAbsent
          ? const Value.absent()
          : Value(signInType),
      signOutType: signOutType == null && nullToAbsent
          ? const Value.absent()
          : Value(signOutType),
      signInBy: signInBy == null && nullToAbsent
          ? const Value.absent()
          : Value(signInBy),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      imageIdPath: imageIdPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imageIdPath),
      eventId: eventId == null && nullToAbsent
          ? const Value.absent()
          : Value(eventId),
      signIn:
          signIn == null && nullToAbsent ? const Value.absent() : Value(signIn),
      signOut: signOut == null && nullToAbsent
          ? const Value.absent()
          : Value(signOut),
      feedback: feedback == null && nullToAbsent
          ? const Value.absent()
          : Value(feedback),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      visitorType: visitorType == null && nullToAbsent
          ? const Value.absent()
          : Value(visitorType),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      syncFail: syncFail == null && nullToAbsent
          ? const Value.absent()
          : Value(syncFail),
      isNew:
          isNew == null && nullToAbsent ? const Value.absent() : Value(isNew),
      faceCaptureFile: faceCaptureFile == null && nullToAbsent
          ? const Value.absent()
          : Value(faceCaptureFile),
    );
  }

  factory EventLogEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EventLogEntry(
      id: serializer.fromJson<String>(json['id']),
      guestId: serializer.fromJson<double>(json['guestId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      email: serializer.fromJson<String>(json['email']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      inviteCode: serializer.fromJson<String>(json['inviteCode']),
      timeZone: serializer.fromJson<String>(json['timeZone']),
      idCard: serializer.fromJson<String>(json['idCard']),
      signInType: serializer.fromJson<String>(json['signInType']),
      signOutType: serializer.fromJson<String>(json['signOutType']),
      signInBy: serializer.fromJson<int>(json['signInBy']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      imageIdPath: serializer.fromJson<String>(json['imageIdPath']),
      eventId: serializer.fromJson<double>(json['eventId']),
      signIn: serializer.fromJson<int>(json['signIn']),
      signOut: serializer.fromJson<int>(json['signOut']),
      feedback: serializer.fromJson<String>(json['feedback']),
      status: serializer.fromJson<String>(json['status']),
      visitorType: serializer.fromJson<String>(json['visitorType']),
      branchId: serializer.fromJson<int>(json['branchId']),
      rating: serializer.fromJson<int>(json['rating']),
      syncFail: serializer.fromJson<bool>(json['syncFail']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      faceCaptureFile: serializer.fromJson<String>(json['faceCaptureFile']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'guestId': serializer.toJson<double>(guestId),
      'fullName': serializer.toJson<String>(fullName),
      'email': serializer.toJson<String>(email),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'inviteCode': serializer.toJson<String>(inviteCode),
      'timeZone': serializer.toJson<String>(timeZone),
      'idCard': serializer.toJson<String>(idCard),
      'signInType': serializer.toJson<String>(signInType),
      'signOutType': serializer.toJson<String>(signOutType),
      'signInBy': serializer.toJson<int>(signInBy),
      'imagePath': serializer.toJson<String>(imagePath),
      'imageIdPath': serializer.toJson<String>(imageIdPath),
      'eventId': serializer.toJson<double>(eventId),
      'signIn': serializer.toJson<int>(signIn),
      'signOut': serializer.toJson<int>(signOut),
      'feedback': serializer.toJson<String>(feedback),
      'status': serializer.toJson<String>(status),
      'visitorType': serializer.toJson<String>(visitorType),
      'branchId': serializer.toJson<int>(branchId),
      'rating': serializer.toJson<int>(rating),
      'syncFail': serializer.toJson<bool>(syncFail),
      'isNew': serializer.toJson<bool>(isNew),
      'faceCaptureFile': serializer.toJson<String>(faceCaptureFile),
    };
  }

  EventLogEntry copyWith(
          {String id,
          double guestId,
          String fullName,
          String email,
          String phoneNumber,
          String inviteCode,
          String timeZone,
          String idCard,
          String signInType,
          String signOutType,
          int signInBy,
          String imagePath,
          String imageIdPath,
          double eventId,
          int signIn,
          int signOut,
          String feedback,
          String status,
          String visitorType,
          int branchId,
          int rating,
          bool syncFail,
          bool isNew,
          String faceCaptureFile}) =>
      EventLogEntry(
        id: id ?? this.id,
        guestId: guestId ?? this.guestId,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        inviteCode: inviteCode ?? this.inviteCode,
        timeZone: timeZone ?? this.timeZone,
        idCard: idCard ?? this.idCard,
        signInType: signInType ?? this.signInType,
        signOutType: signOutType ?? this.signOutType,
        signInBy: signInBy ?? this.signInBy,
        imagePath: imagePath ?? this.imagePath,
        imageIdPath: imageIdPath ?? this.imageIdPath,
        eventId: eventId ?? this.eventId,
        signIn: signIn ?? this.signIn,
        signOut: signOut ?? this.signOut,
        feedback: feedback ?? this.feedback,
        status: status ?? this.status,
        visitorType: visitorType ?? this.visitorType,
        branchId: branchId ?? this.branchId,
        rating: rating ?? this.rating,
        syncFail: syncFail ?? this.syncFail,
        isNew: isNew ?? this.isNew,
        faceCaptureFile: faceCaptureFile ?? this.faceCaptureFile,
      );
  @override
  String toString() {
    return (StringBuffer('EventLogEntry(')
          ..write('id: $id, ')
          ..write('guestId: $guestId, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('timeZone: $timeZone, ')
          ..write('idCard: $idCard, ')
          ..write('signInType: $signInType, ')
          ..write('signOutType: $signOutType, ')
          ..write('signInBy: $signInBy, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageIdPath: $imageIdPath, ')
          ..write('eventId: $eventId, ')
          ..write('signIn: $signIn, ')
          ..write('signOut: $signOut, ')
          ..write('feedback: $feedback, ')
          ..write('status: $status, ')
          ..write('visitorType: $visitorType, ')
          ..write('branchId: $branchId, ')
          ..write('rating: $rating, ')
          ..write('syncFail: $syncFail, ')
          ..write('isNew: $isNew, ')
          ..write('faceCaptureFile: $faceCaptureFile')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          guestId.hashCode,
          $mrjc(
              fullName.hashCode,
              $mrjc(
                  email.hashCode,
                  $mrjc(
                      phoneNumber.hashCode,
                      $mrjc(
                          inviteCode.hashCode,
                          $mrjc(
                              timeZone.hashCode,
                              $mrjc(
                                  idCard.hashCode,
                                  $mrjc(
                                      signInType.hashCode,
                                      $mrjc(
                                          signOutType.hashCode,
                                          $mrjc(
                                              signInBy.hashCode,
                                              $mrjc(
                                                  imagePath.hashCode,
                                                  $mrjc(
                                                      imageIdPath.hashCode,
                                                      $mrjc(
                                                          eventId.hashCode,
                                                          $mrjc(
                                                              signIn.hashCode,
                                                              $mrjc(
                                                                  signOut
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      feedback
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          status
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              visitorType.hashCode,
                                                                              $mrjc(branchId.hashCode, $mrjc(rating.hashCode, $mrjc(syncFail.hashCode, $mrjc(isNew.hashCode, faceCaptureFile.hashCode))))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is EventLogEntry &&
          other.id == this.id &&
          other.guestId == this.guestId &&
          other.fullName == this.fullName &&
          other.email == this.email &&
          other.phoneNumber == this.phoneNumber &&
          other.inviteCode == this.inviteCode &&
          other.timeZone == this.timeZone &&
          other.idCard == this.idCard &&
          other.signInType == this.signInType &&
          other.signOutType == this.signOutType &&
          other.signInBy == this.signInBy &&
          other.imagePath == this.imagePath &&
          other.imageIdPath == this.imageIdPath &&
          other.eventId == this.eventId &&
          other.signIn == this.signIn &&
          other.signOut == this.signOut &&
          other.feedback == this.feedback &&
          other.status == this.status &&
          other.visitorType == this.visitorType &&
          other.branchId == this.branchId &&
          other.rating == this.rating &&
          other.syncFail == this.syncFail &&
          other.isNew == this.isNew &&
          other.faceCaptureFile == this.faceCaptureFile);
}

class EventLogEntityCompanion extends UpdateCompanion<EventLogEntry> {
  final Value<String> id;
  final Value<double> guestId;
  final Value<String> fullName;
  final Value<String> email;
  final Value<String> phoneNumber;
  final Value<String> inviteCode;
  final Value<String> timeZone;
  final Value<String> idCard;
  final Value<String> signInType;
  final Value<String> signOutType;
  final Value<int> signInBy;
  final Value<String> imagePath;
  final Value<String> imageIdPath;
  final Value<double> eventId;
  final Value<int> signIn;
  final Value<int> signOut;
  final Value<String> feedback;
  final Value<String> status;
  final Value<String> visitorType;
  final Value<int> branchId;
  final Value<int> rating;
  final Value<bool> syncFail;
  final Value<bool> isNew;
  final Value<String> faceCaptureFile;
  const EventLogEntityCompanion({
    this.id = const Value.absent(),
    this.guestId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.idCard = const Value.absent(),
    this.signInType = const Value.absent(),
    this.signOutType = const Value.absent(),
    this.signInBy = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.imageIdPath = const Value.absent(),
    this.eventId = const Value.absent(),
    this.signIn = const Value.absent(),
    this.signOut = const Value.absent(),
    this.feedback = const Value.absent(),
    this.status = const Value.absent(),
    this.visitorType = const Value.absent(),
    this.branchId = const Value.absent(),
    this.rating = const Value.absent(),
    this.syncFail = const Value.absent(),
    this.isNew = const Value.absent(),
    this.faceCaptureFile = const Value.absent(),
  });
  EventLogEntityCompanion.insert({
    this.id = const Value.absent(),
    this.guestId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.idCard = const Value.absent(),
    this.signInType = const Value.absent(),
    this.signOutType = const Value.absent(),
    this.signInBy = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.imageIdPath = const Value.absent(),
    this.eventId = const Value.absent(),
    this.signIn = const Value.absent(),
    this.signOut = const Value.absent(),
    this.feedback = const Value.absent(),
    this.status = const Value.absent(),
    this.visitorType = const Value.absent(),
    this.branchId = const Value.absent(),
    this.rating = const Value.absent(),
    this.syncFail = const Value.absent(),
    this.isNew = const Value.absent(),
    this.faceCaptureFile = const Value.absent(),
  });
  static Insertable<EventLogEntry> custom({
    Expression<String> id,
    Expression<double> guestId,
    Expression<String> fullName,
    Expression<String> email,
    Expression<String> phoneNumber,
    Expression<String> inviteCode,
    Expression<String> timeZone,
    Expression<String> idCard,
    Expression<String> signInType,
    Expression<String> signOutType,
    Expression<int> signInBy,
    Expression<String> imagePath,
    Expression<String> imageIdPath,
    Expression<double> eventId,
    Expression<int> signIn,
    Expression<int> signOut,
    Expression<String> feedback,
    Expression<String> status,
    Expression<String> visitorType,
    Expression<int> branchId,
    Expression<int> rating,
    Expression<bool> syncFail,
    Expression<bool> isNew,
    Expression<String> faceCaptureFile,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (guestId != null) 'guest_id': guestId,
      if (fullName != null) 'full_name': fullName,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (inviteCode != null) 'invite_code': inviteCode,
      if (timeZone != null) 'time_zone': timeZone,
      if (idCard != null) 'id_card': idCard,
      if (signInType != null) 'sign_in_type': signInType,
      if (signOutType != null) 'sign_out_type': signOutType,
      if (signInBy != null) 'sign_in_by': signInBy,
      if (imagePath != null) 'image_path': imagePath,
      if (imageIdPath != null) 'image_id_path': imageIdPath,
      if (eventId != null) 'event_id': eventId,
      if (signIn != null) 'sign_in': signIn,
      if (signOut != null) 'sign_out': signOut,
      if (feedback != null) 'feedback': feedback,
      if (status != null) 'status': status,
      if (visitorType != null) 'visitor_type': visitorType,
      if (branchId != null) 'branch_id': branchId,
      if (rating != null) 'rating': rating,
      if (syncFail != null) 'sync_fail': syncFail,
      if (isNew != null) 'is_new': isNew,
      if (faceCaptureFile != null) 'face_capture_file': faceCaptureFile,
    });
  }

  EventLogEntityCompanion copyWith(
      {Value<String> id,
      Value<double> guestId,
      Value<String> fullName,
      Value<String> email,
      Value<String> phoneNumber,
      Value<String> inviteCode,
      Value<String> timeZone,
      Value<String> idCard,
      Value<String> signInType,
      Value<String> signOutType,
      Value<int> signInBy,
      Value<String> imagePath,
      Value<String> imageIdPath,
      Value<double> eventId,
      Value<int> signIn,
      Value<int> signOut,
      Value<String> feedback,
      Value<String> status,
      Value<String> visitorType,
      Value<int> branchId,
      Value<int> rating,
      Value<bool> syncFail,
      Value<bool> isNew,
      Value<String> faceCaptureFile}) {
    return EventLogEntityCompanion(
      id: id ?? this.id,
      guestId: guestId ?? this.guestId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      inviteCode: inviteCode ?? this.inviteCode,
      timeZone: timeZone ?? this.timeZone,
      idCard: idCard ?? this.idCard,
      signInType: signInType ?? this.signInType,
      signOutType: signOutType ?? this.signOutType,
      signInBy: signInBy ?? this.signInBy,
      imagePath: imagePath ?? this.imagePath,
      imageIdPath: imageIdPath ?? this.imageIdPath,
      eventId: eventId ?? this.eventId,
      signIn: signIn ?? this.signIn,
      signOut: signOut ?? this.signOut,
      feedback: feedback ?? this.feedback,
      status: status ?? this.status,
      visitorType: visitorType ?? this.visitorType,
      branchId: branchId ?? this.branchId,
      rating: rating ?? this.rating,
      syncFail: syncFail ?? this.syncFail,
      isNew: isNew ?? this.isNew,
      faceCaptureFile: faceCaptureFile ?? this.faceCaptureFile,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (guestId.present) {
      map['guest_id'] = Variable<double>(guestId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (inviteCode.present) {
      map['invite_code'] = Variable<String>(inviteCode.value);
    }
    if (timeZone.present) {
      map['time_zone'] = Variable<String>(timeZone.value);
    }
    if (idCard.present) {
      map['id_card'] = Variable<String>(idCard.value);
    }
    if (signInType.present) {
      map['sign_in_type'] = Variable<String>(signInType.value);
    }
    if (signOutType.present) {
      map['sign_out_type'] = Variable<String>(signOutType.value);
    }
    if (signInBy.present) {
      map['sign_in_by'] = Variable<int>(signInBy.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (imageIdPath.present) {
      map['image_id_path'] = Variable<String>(imageIdPath.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<double>(eventId.value);
    }
    if (signIn.present) {
      map['sign_in'] = Variable<int>(signIn.value);
    }
    if (signOut.present) {
      map['sign_out'] = Variable<int>(signOut.value);
    }
    if (feedback.present) {
      map['feedback'] = Variable<String>(feedback.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (visitorType.present) {
      map['visitor_type'] = Variable<String>(visitorType.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<int>(branchId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (syncFail.present) {
      map['sync_fail'] = Variable<bool>(syncFail.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (faceCaptureFile.present) {
      map['face_capture_file'] = Variable<String>(faceCaptureFile.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventLogEntityCompanion(')
          ..write('id: $id, ')
          ..write('guestId: $guestId, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('timeZone: $timeZone, ')
          ..write('idCard: $idCard, ')
          ..write('signInType: $signInType, ')
          ..write('signOutType: $signOutType, ')
          ..write('signInBy: $signInBy, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageIdPath: $imageIdPath, ')
          ..write('eventId: $eventId, ')
          ..write('signIn: $signIn, ')
          ..write('signOut: $signOut, ')
          ..write('feedback: $feedback, ')
          ..write('status: $status, ')
          ..write('visitorType: $visitorType, ')
          ..write('branchId: $branchId, ')
          ..write('rating: $rating, ')
          ..write('syncFail: $syncFail, ')
          ..write('isNew: $isNew, ')
          ..write('faceCaptureFile: $faceCaptureFile')
          ..write(')'))
        .toString();
  }
}

class $EventLogEntityTable extends EventLogEntity
    with TableInfo<$EventLogEntityTable, EventLogEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventLogEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => uuid.v1();
  }

  final VerificationMeta _guestIdMeta = const VerificationMeta('guestId');
  GeneratedRealColumn _guestId;
  @override
  GeneratedRealColumn get guestId => _guestId ??= _constructGuestId();
  GeneratedRealColumn _constructGuestId() {
    return GeneratedRealColumn(
      'guest_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fullNameMeta = const VerificationMeta('fullName');
  GeneratedTextColumn _fullName;
  @override
  GeneratedTextColumn get fullName => _fullName ??= _constructFullName();
  GeneratedTextColumn _constructFullName() {
    return GeneratedTextColumn(
      'full_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      true,
    );
  }

  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  GeneratedTextColumn _phoneNumber;
  @override
  GeneratedTextColumn get phoneNumber =>
      _phoneNumber ??= _constructPhoneNumber();
  GeneratedTextColumn _constructPhoneNumber() {
    return GeneratedTextColumn(
      'phone_number',
      $tableName,
      true,
    );
  }

  final VerificationMeta _inviteCodeMeta = const VerificationMeta('inviteCode');
  GeneratedTextColumn _inviteCode;
  @override
  GeneratedTextColumn get inviteCode => _inviteCode ??= _constructInviteCode();
  GeneratedTextColumn _constructInviteCode() {
    return GeneratedTextColumn(
      'invite_code',
      $tableName,
      true,
    );
  }

  final VerificationMeta _timeZoneMeta = const VerificationMeta('timeZone');
  GeneratedTextColumn _timeZone;
  @override
  GeneratedTextColumn get timeZone => _timeZone ??= _constructTimeZone();
  GeneratedTextColumn _constructTimeZone() {
    return GeneratedTextColumn(
      'time_zone',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idCardMeta = const VerificationMeta('idCard');
  GeneratedTextColumn _idCard;
  @override
  GeneratedTextColumn get idCard => _idCard ??= _constructIdCard();
  GeneratedTextColumn _constructIdCard() {
    return GeneratedTextColumn(
      'id_card',
      $tableName,
      true,
    );
  }

  final VerificationMeta _signInTypeMeta = const VerificationMeta('signInType');
  GeneratedTextColumn _signInType;
  @override
  GeneratedTextColumn get signInType => _signInType ??= _constructSignInType();
  GeneratedTextColumn _constructSignInType() {
    return GeneratedTextColumn(
      'sign_in_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _signOutTypeMeta =
      const VerificationMeta('signOutType');
  GeneratedTextColumn _signOutType;
  @override
  GeneratedTextColumn get signOutType =>
      _signOutType ??= _constructSignOutType();
  GeneratedTextColumn _constructSignOutType() {
    return GeneratedTextColumn(
      'sign_out_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _signInByMeta = const VerificationMeta('signInBy');
  GeneratedIntColumn _signInBy;
  @override
  GeneratedIntColumn get signInBy => _signInBy ??= _constructSignInBy();
  GeneratedIntColumn _constructSignInBy() {
    return GeneratedIntColumn(
      'sign_in_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  GeneratedTextColumn _imagePath;
  @override
  GeneratedTextColumn get imagePath => _imagePath ??= _constructImagePath();
  GeneratedTextColumn _constructImagePath() {
    return GeneratedTextColumn(
      'image_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageIdPathMeta =
      const VerificationMeta('imageIdPath');
  GeneratedTextColumn _imageIdPath;
  @override
  GeneratedTextColumn get imageIdPath =>
      _imageIdPath ??= _constructImageIdPath();
  GeneratedTextColumn _constructImageIdPath() {
    return GeneratedTextColumn(
      'image_id_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _eventIdMeta = const VerificationMeta('eventId');
  GeneratedRealColumn _eventId;
  @override
  GeneratedRealColumn get eventId => _eventId ??= _constructEventId();
  GeneratedRealColumn _constructEventId() {
    return GeneratedRealColumn(
      'event_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _signInMeta = const VerificationMeta('signIn');
  GeneratedIntColumn _signIn;
  @override
  GeneratedIntColumn get signIn => _signIn ??= _constructSignIn();
  GeneratedIntColumn _constructSignIn() {
    return GeneratedIntColumn(
      'sign_in',
      $tableName,
      true,
    );
  }

  final VerificationMeta _signOutMeta = const VerificationMeta('signOut');
  GeneratedIntColumn _signOut;
  @override
  GeneratedIntColumn get signOut => _signOut ??= _constructSignOut();
  GeneratedIntColumn _constructSignOut() {
    return GeneratedIntColumn(
      'sign_out',
      $tableName,
      true,
    );
  }

  final VerificationMeta _feedbackMeta = const VerificationMeta('feedback');
  GeneratedTextColumn _feedback;
  @override
  GeneratedTextColumn get feedback => _feedback ??= _constructFeedback();
  GeneratedTextColumn _constructFeedback() {
    return GeneratedTextColumn(
      'feedback',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedTextColumn _status;
  @override
  GeneratedTextColumn get status => _status ??= _constructStatus();
  GeneratedTextColumn _constructStatus() {
    return GeneratedTextColumn(
      'status',
      $tableName,
      true,
    );
  }

  final VerificationMeta _visitorTypeMeta =
      const VerificationMeta('visitorType');
  GeneratedTextColumn _visitorType;
  @override
  GeneratedTextColumn get visitorType =>
      _visitorType ??= _constructVisitorType();
  GeneratedTextColumn _constructVisitorType() {
    return GeneratedTextColumn(
      'visitor_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _branchIdMeta = const VerificationMeta('branchId');
  GeneratedIntColumn _branchId;
  @override
  GeneratedIntColumn get branchId => _branchId ??= _constructBranchId();
  GeneratedIntColumn _constructBranchId() {
    return GeneratedIntColumn(
      'branch_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  GeneratedIntColumn _rating;
  @override
  GeneratedIntColumn get rating => _rating ??= _constructRating();
  GeneratedIntColumn _constructRating() {
    return GeneratedIntColumn(
      'rating',
      $tableName,
      true,
    );
  }

  final VerificationMeta _syncFailMeta = const VerificationMeta('syncFail');
  GeneratedBoolColumn _syncFail;
  @override
  GeneratedBoolColumn get syncFail => _syncFail ??= _constructSyncFail();
  GeneratedBoolColumn _constructSyncFail() {
    return GeneratedBoolColumn(
      'sync_fail',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  GeneratedBoolColumn _isNew;
  @override
  GeneratedBoolColumn get isNew => _isNew ??= _constructIsNew();
  GeneratedBoolColumn _constructIsNew() {
    return GeneratedBoolColumn(
      'is_new',
      $tableName,
      true,
    );
  }

  final VerificationMeta _faceCaptureFileMeta =
      const VerificationMeta('faceCaptureFile');
  GeneratedTextColumn _faceCaptureFile;
  @override
  GeneratedTextColumn get faceCaptureFile =>
      _faceCaptureFile ??= _constructFaceCaptureFile();
  GeneratedTextColumn _constructFaceCaptureFile() {
    return GeneratedTextColumn(
      'face_capture_file',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        guestId,
        fullName,
        email,
        phoneNumber,
        inviteCode,
        timeZone,
        idCard,
        signInType,
        signOutType,
        signInBy,
        imagePath,
        imageIdPath,
        eventId,
        signIn,
        signOut,
        feedback,
        status,
        visitorType,
        branchId,
        rating,
        syncFail,
        isNew,
        faceCaptureFile
      ];
  @override
  $EventLogEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_event_log';
  @override
  final String actualTableName = 'cip_event_log';
  @override
  VerificationContext validateIntegrity(Insertable<EventLogEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('guest_id')) {
      context.handle(_guestIdMeta,
          guestId.isAcceptableOrUnknown(data['guest_id'], _guestIdMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name'], _fullNameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number'], _phoneNumberMeta));
    }
    if (data.containsKey('invite_code')) {
      context.handle(
          _inviteCodeMeta,
          inviteCode.isAcceptableOrUnknown(
              data['invite_code'], _inviteCodeMeta));
    }
    if (data.containsKey('time_zone')) {
      context.handle(_timeZoneMeta,
          timeZone.isAcceptableOrUnknown(data['time_zone'], _timeZoneMeta));
    }
    if (data.containsKey('id_card')) {
      context.handle(_idCardMeta,
          idCard.isAcceptableOrUnknown(data['id_card'], _idCardMeta));
    }
    if (data.containsKey('sign_in_type')) {
      context.handle(
          _signInTypeMeta,
          signInType.isAcceptableOrUnknown(
              data['sign_in_type'], _signInTypeMeta));
    }
    if (data.containsKey('sign_out_type')) {
      context.handle(
          _signOutTypeMeta,
          signOutType.isAcceptableOrUnknown(
              data['sign_out_type'], _signOutTypeMeta));
    }
    if (data.containsKey('sign_in_by')) {
      context.handle(_signInByMeta,
          signInBy.isAcceptableOrUnknown(data['sign_in_by'], _signInByMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path'], _imagePathMeta));
    }
    if (data.containsKey('image_id_path')) {
      context.handle(
          _imageIdPathMeta,
          imageIdPath.isAcceptableOrUnknown(
              data['image_id_path'], _imageIdPathMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id'], _eventIdMeta));
    }
    if (data.containsKey('sign_in')) {
      context.handle(_signInMeta,
          signIn.isAcceptableOrUnknown(data['sign_in'], _signInMeta));
    }
    if (data.containsKey('sign_out')) {
      context.handle(_signOutMeta,
          signOut.isAcceptableOrUnknown(data['sign_out'], _signOutMeta));
    }
    if (data.containsKey('feedback')) {
      context.handle(_feedbackMeta,
          feedback.isAcceptableOrUnknown(data['feedback'], _feedbackMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    }
    if (data.containsKey('visitor_type')) {
      context.handle(
          _visitorTypeMeta,
          visitorType.isAcceptableOrUnknown(
              data['visitor_type'], _visitorTypeMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id'], _branchIdMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating'], _ratingMeta));
    }
    if (data.containsKey('sync_fail')) {
      context.handle(_syncFailMeta,
          syncFail.isAcceptableOrUnknown(data['sync_fail'], _syncFailMeta));
    }
    if (data.containsKey('is_new')) {
      context.handle(
          _isNewMeta, isNew.isAcceptableOrUnknown(data['is_new'], _isNewMeta));
    }
    if (data.containsKey('face_capture_file')) {
      context.handle(
          _faceCaptureFileMeta,
          faceCaptureFile.isAcceptableOrUnknown(
              data['face_capture_file'], _faceCaptureFileMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventLogEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return EventLogEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EventLogEntityTable createAlias(String alias) {
    return $EventLogEntityTable(_db, alias);
  }
}

class EventDetailEntry extends DataClass
    implements Insertable<EventDetailEntry> {
  final double id;
  final String eventName;
  final int startDate;
  final int endDate;
  final String badgeTemplate;
  EventDetailEntry(
      {this.id,
      this.eventName,
      this.startDate,
      this.endDate,
      this.badgeTemplate});
  factory EventDetailEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return EventDetailEntry(
      id: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      eventName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}event_name']),
      startDate:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}start_date']),
      endDate:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}end_date']),
      badgeTemplate: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}badge_template']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<double>(id);
    }
    if (!nullToAbsent || eventName != null) {
      map['event_name'] = Variable<String>(eventName);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<int>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<int>(endDate);
    }
    if (!nullToAbsent || badgeTemplate != null) {
      map['badge_template'] = Variable<String>(badgeTemplate);
    }
    return map;
  }

  EventDetailEntityCompanion toCompanion(bool nullToAbsent) {
    return EventDetailEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      eventName: eventName == null && nullToAbsent
          ? const Value.absent()
          : Value(eventName),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      badgeTemplate: badgeTemplate == null && nullToAbsent
          ? const Value.absent()
          : Value(badgeTemplate),
    );
  }

  factory EventDetailEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EventDetailEntry(
      id: serializer.fromJson<double>(json['id']),
      eventName: serializer.fromJson<String>(json['eventName']),
      startDate: serializer.fromJson<int>(json['startDate']),
      endDate: serializer.fromJson<int>(json['endDate']),
      badgeTemplate: serializer.fromJson<String>(json['badgeTemplate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<double>(id),
      'eventName': serializer.toJson<String>(eventName),
      'startDate': serializer.toJson<int>(startDate),
      'endDate': serializer.toJson<int>(endDate),
      'badgeTemplate': serializer.toJson<String>(badgeTemplate),
    };
  }

  EventDetailEntry copyWith(
          {double id,
          String eventName,
          int startDate,
          int endDate,
          String badgeTemplate}) =>
      EventDetailEntry(
        id: id ?? this.id,
        eventName: eventName ?? this.eventName,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        badgeTemplate: badgeTemplate ?? this.badgeTemplate,
      );
  @override
  String toString() {
    return (StringBuffer('EventDetailEntry(')
          ..write('id: $id, ')
          ..write('eventName: $eventName, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('badgeTemplate: $badgeTemplate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          eventName.hashCode,
          $mrjc(startDate.hashCode,
              $mrjc(endDate.hashCode, badgeTemplate.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is EventDetailEntry &&
          other.id == this.id &&
          other.eventName == this.eventName &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.badgeTemplate == this.badgeTemplate);
}

class EventDetailEntityCompanion extends UpdateCompanion<EventDetailEntry> {
  final Value<double> id;
  final Value<String> eventName;
  final Value<int> startDate;
  final Value<int> endDate;
  final Value<String> badgeTemplate;
  const EventDetailEntityCompanion({
    this.id = const Value.absent(),
    this.eventName = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.badgeTemplate = const Value.absent(),
  });
  EventDetailEntityCompanion.insert({
    this.id = const Value.absent(),
    this.eventName = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.badgeTemplate = const Value.absent(),
  });
  static Insertable<EventDetailEntry> custom({
    Expression<double> id,
    Expression<String> eventName,
    Expression<int> startDate,
    Expression<int> endDate,
    Expression<String> badgeTemplate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventName != null) 'event_name': eventName,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (badgeTemplate != null) 'badge_template': badgeTemplate,
    });
  }

  EventDetailEntityCompanion copyWith(
      {Value<double> id,
      Value<String> eventName,
      Value<int> startDate,
      Value<int> endDate,
      Value<String> badgeTemplate}) {
    return EventDetailEntityCompanion(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      badgeTemplate: badgeTemplate ?? this.badgeTemplate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<double>(id.value);
    }
    if (eventName.present) {
      map['event_name'] = Variable<String>(eventName.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<int>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<int>(endDate.value);
    }
    if (badgeTemplate.present) {
      map['badge_template'] = Variable<String>(badgeTemplate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventDetailEntityCompanion(')
          ..write('id: $id, ')
          ..write('eventName: $eventName, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('badgeTemplate: $badgeTemplate')
          ..write(')'))
        .toString();
  }
}

class $EventDetailEntityTable extends EventDetailEntity
    with TableInfo<$EventDetailEntityTable, EventDetailEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventDetailEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedRealColumn _id;
  @override
  GeneratedRealColumn get id => _id ??= _constructId();
  GeneratedRealColumn _constructId() {
    return GeneratedRealColumn(
      'id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _eventNameMeta = const VerificationMeta('eventName');
  GeneratedTextColumn _eventName;
  @override
  GeneratedTextColumn get eventName => _eventName ??= _constructEventName();
  GeneratedTextColumn _constructEventName() {
    return GeneratedTextColumn(
      'event_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  GeneratedIntColumn _startDate;
  @override
  GeneratedIntColumn get startDate => _startDate ??= _constructStartDate();
  GeneratedIntColumn _constructStartDate() {
    return GeneratedIntColumn(
      'start_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _endDateMeta = const VerificationMeta('endDate');
  GeneratedIntColumn _endDate;
  @override
  GeneratedIntColumn get endDate => _endDate ??= _constructEndDate();
  GeneratedIntColumn _constructEndDate() {
    return GeneratedIntColumn(
      'end_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _badgeTemplateMeta =
      const VerificationMeta('badgeTemplate');
  GeneratedTextColumn _badgeTemplate;
  @override
  GeneratedTextColumn get badgeTemplate =>
      _badgeTemplate ??= _constructBadgeTemplate();
  GeneratedTextColumn _constructBadgeTemplate() {
    return GeneratedTextColumn(
      'badge_template',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, eventName, startDate, endDate, badgeTemplate];
  @override
  $EventDetailEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_event_detail';
  @override
  final String actualTableName = 'cip_event_detail';
  @override
  VerificationContext validateIntegrity(Insertable<EventDetailEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('event_name')) {
      context.handle(_eventNameMeta,
          eventName.isAcceptableOrUnknown(data['event_name'], _eventNameMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date'], _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date'], _endDateMeta));
    }
    if (data.containsKey('badge_template')) {
      context.handle(
          _badgeTemplateMeta,
          badgeTemplate.isAcceptableOrUnknown(
              data['badge_template'], _badgeTemplateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventDetailEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return EventDetailEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EventDetailEntityTable createAlias(String alias) {
    return $EventDetailEntityTable(_db, alias);
  }
}

class ImageDownloadedEntry extends DataClass
    implements Insertable<ImageDownloadedEntry> {
  final String linkDownload;
  final String localPath;
  ImageDownloadedEntry({this.linkDownload, this.localPath});
  factory ImageDownloadedEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ImageDownloadedEntry(
      linkDownload: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}link_download']),
      localPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}local_path']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || linkDownload != null) {
      map['link_download'] = Variable<String>(linkDownload);
    }
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    return map;
  }

  ImageDownloadedEntityCompanion toCompanion(bool nullToAbsent) {
    return ImageDownloadedEntityCompanion(
      linkDownload: linkDownload == null && nullToAbsent
          ? const Value.absent()
          : Value(linkDownload),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
    );
  }

  factory ImageDownloadedEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ImageDownloadedEntry(
      linkDownload: serializer.fromJson<String>(json['linkDownload']),
      localPath: serializer.fromJson<String>(json['localPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'linkDownload': serializer.toJson<String>(linkDownload),
      'localPath': serializer.toJson<String>(localPath),
    };
  }

  ImageDownloadedEntry copyWith({String linkDownload, String localPath}) =>
      ImageDownloadedEntry(
        linkDownload: linkDownload ?? this.linkDownload,
        localPath: localPath ?? this.localPath,
      );
  @override
  String toString() {
    return (StringBuffer('ImageDownloadedEntry(')
          ..write('linkDownload: $linkDownload, ')
          ..write('localPath: $localPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(linkDownload.hashCode, localPath.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ImageDownloadedEntry &&
          other.linkDownload == this.linkDownload &&
          other.localPath == this.localPath);
}

class ImageDownloadedEntityCompanion
    extends UpdateCompanion<ImageDownloadedEntry> {
  final Value<String> linkDownload;
  final Value<String> localPath;
  const ImageDownloadedEntityCompanion({
    this.linkDownload = const Value.absent(),
    this.localPath = const Value.absent(),
  });
  ImageDownloadedEntityCompanion.insert({
    this.linkDownload = const Value.absent(),
    this.localPath = const Value.absent(),
  });
  static Insertable<ImageDownloadedEntry> custom({
    Expression<String> linkDownload,
    Expression<String> localPath,
  }) {
    return RawValuesInsertable({
      if (linkDownload != null) 'link_download': linkDownload,
      if (localPath != null) 'local_path': localPath,
    });
  }

  ImageDownloadedEntityCompanion copyWith(
      {Value<String> linkDownload, Value<String> localPath}) {
    return ImageDownloadedEntityCompanion(
      linkDownload: linkDownload ?? this.linkDownload,
      localPath: localPath ?? this.localPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (linkDownload.present) {
      map['link_download'] = Variable<String>(linkDownload.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageDownloadedEntityCompanion(')
          ..write('linkDownload: $linkDownload, ')
          ..write('localPath: $localPath')
          ..write(')'))
        .toString();
  }
}

class $ImageDownloadedEntityTable extends ImageDownloadedEntity
    with TableInfo<$ImageDownloadedEntityTable, ImageDownloadedEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ImageDownloadedEntityTable(this._db, [this._alias]);
  final VerificationMeta _linkDownloadMeta =
      const VerificationMeta('linkDownload');
  GeneratedTextColumn _linkDownload;
  @override
  GeneratedTextColumn get linkDownload =>
      _linkDownload ??= _constructLinkDownload();
  GeneratedTextColumn _constructLinkDownload() {
    return GeneratedTextColumn(
      'link_download',
      $tableName,
      true,
    );
  }

  final VerificationMeta _localPathMeta = const VerificationMeta('localPath');
  GeneratedTextColumn _localPath;
  @override
  GeneratedTextColumn get localPath => _localPath ??= _constructLocalPath();
  GeneratedTextColumn _constructLocalPath() {
    return GeneratedTextColumn(
      'local_path',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [linkDownload, localPath];
  @override
  $ImageDownloadedEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_image_downloaded';
  @override
  final String actualTableName = 'cip_image_downloaded';
  @override
  VerificationContext validateIntegrity(
      Insertable<ImageDownloadedEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('link_download')) {
      context.handle(
          _linkDownloadMeta,
          linkDownload.isAcceptableOrUnknown(
              data['link_download'], _linkDownloadMeta));
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path'], _localPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ImageDownloadedEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ImageDownloadedEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ImageDownloadedEntityTable createAlias(String alias) {
    return $ImageDownloadedEntityTable(_db, alias);
  }
}

class ETOderDetailInfoEntry extends DataClass
    implements Insertable<ETOderDetailInfoEntry> {
  final double id;
  final double orderId;
  final double eventId;
  final double ticketId;
  final double quantity;
  final double amount;
  final double discountId;
  final String inviteCode;
  final String status;
  ETOderDetailInfoEntry(
      {this.id,
      this.orderId,
      this.eventId,
      this.ticketId,
      this.quantity,
      this.amount,
      this.discountId,
      this.inviteCode,
      this.status});
  factory ETOderDetailInfoEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    return ETOderDetailInfoEntry(
      id: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      orderId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id']),
      eventId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}event_id']),
      ticketId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}ticket_id']),
      quantity: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
      amount:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      discountId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}discount_id']),
      inviteCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}invite_code']),
      status:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<double>(id);
    }
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<double>(orderId);
    }
    if (!nullToAbsent || eventId != null) {
      map['event_id'] = Variable<double>(eventId);
    }
    if (!nullToAbsent || ticketId != null) {
      map['ticket_id'] = Variable<double>(ticketId);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<double>(quantity);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || discountId != null) {
      map['discount_id'] = Variable<double>(discountId);
    }
    if (!nullToAbsent || inviteCode != null) {
      map['invite_code'] = Variable<String>(inviteCode);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    return map;
  }

  ETOrderDetailInfoEntityCompanion toCompanion(bool nullToAbsent) {
    return ETOrderDetailInfoEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      orderId: orderId == null && nullToAbsent
          ? const Value.absent()
          : Value(orderId),
      eventId: eventId == null && nullToAbsent
          ? const Value.absent()
          : Value(eventId),
      ticketId: ticketId == null && nullToAbsent
          ? const Value.absent()
          : Value(ticketId),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      discountId: discountId == null && nullToAbsent
          ? const Value.absent()
          : Value(discountId),
      inviteCode: inviteCode == null && nullToAbsent
          ? const Value.absent()
          : Value(inviteCode),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    );
  }

  factory ETOderDetailInfoEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ETOderDetailInfoEntry(
      id: serializer.fromJson<double>(json['id']),
      orderId: serializer.fromJson<double>(json['orderId']),
      eventId: serializer.fromJson<double>(json['eventId']),
      ticketId: serializer.fromJson<double>(json['ticketId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      amount: serializer.fromJson<double>(json['amount']),
      discountId: serializer.fromJson<double>(json['discountId']),
      inviteCode: serializer.fromJson<String>(json['inviteCode']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<double>(id),
      'orderId': serializer.toJson<double>(orderId),
      'eventId': serializer.toJson<double>(eventId),
      'ticketId': serializer.toJson<double>(ticketId),
      'quantity': serializer.toJson<double>(quantity),
      'amount': serializer.toJson<double>(amount),
      'discountId': serializer.toJson<double>(discountId),
      'inviteCode': serializer.toJson<String>(inviteCode),
      'status': serializer.toJson<String>(status),
    };
  }

  ETOderDetailInfoEntry copyWith(
          {double id,
          double orderId,
          double eventId,
          double ticketId,
          double quantity,
          double amount,
          double discountId,
          String inviteCode,
          String status}) =>
      ETOderDetailInfoEntry(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        eventId: eventId ?? this.eventId,
        ticketId: ticketId ?? this.ticketId,
        quantity: quantity ?? this.quantity,
        amount: amount ?? this.amount,
        discountId: discountId ?? this.discountId,
        inviteCode: inviteCode ?? this.inviteCode,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('ETOderDetailInfoEntry(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('eventId: $eventId, ')
          ..write('ticketId: $ticketId, ')
          ..write('quantity: $quantity, ')
          ..write('amount: $amount, ')
          ..write('discountId: $discountId, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          orderId.hashCode,
          $mrjc(
              eventId.hashCode,
              $mrjc(
                  ticketId.hashCode,
                  $mrjc(
                      quantity.hashCode,
                      $mrjc(
                          amount.hashCode,
                          $mrjc(
                              discountId.hashCode,
                              $mrjc(
                                  inviteCode.hashCode, status.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ETOderDetailInfoEntry &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.eventId == this.eventId &&
          other.ticketId == this.ticketId &&
          other.quantity == this.quantity &&
          other.amount == this.amount &&
          other.discountId == this.discountId &&
          other.inviteCode == this.inviteCode &&
          other.status == this.status);
}

class ETOrderDetailInfoEntityCompanion
    extends UpdateCompanion<ETOderDetailInfoEntry> {
  final Value<double> id;
  final Value<double> orderId;
  final Value<double> eventId;
  final Value<double> ticketId;
  final Value<double> quantity;
  final Value<double> amount;
  final Value<double> discountId;
  final Value<String> inviteCode;
  final Value<String> status;
  const ETOrderDetailInfoEntityCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.eventId = const Value.absent(),
    this.ticketId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.amount = const Value.absent(),
    this.discountId = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.status = const Value.absent(),
  });
  ETOrderDetailInfoEntityCompanion.insert({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.eventId = const Value.absent(),
    this.ticketId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.amount = const Value.absent(),
    this.discountId = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.status = const Value.absent(),
  });
  static Insertable<ETOderDetailInfoEntry> custom({
    Expression<double> id,
    Expression<double> orderId,
    Expression<double> eventId,
    Expression<double> ticketId,
    Expression<double> quantity,
    Expression<double> amount,
    Expression<double> discountId,
    Expression<String> inviteCode,
    Expression<String> status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (eventId != null) 'event_id': eventId,
      if (ticketId != null) 'ticket_id': ticketId,
      if (quantity != null) 'quantity': quantity,
      if (amount != null) 'amount': amount,
      if (discountId != null) 'discount_id': discountId,
      if (inviteCode != null) 'invite_code': inviteCode,
      if (status != null) 'status': status,
    });
  }

  ETOrderDetailInfoEntityCompanion copyWith(
      {Value<double> id,
      Value<double> orderId,
      Value<double> eventId,
      Value<double> ticketId,
      Value<double> quantity,
      Value<double> amount,
      Value<double> discountId,
      Value<String> inviteCode,
      Value<String> status}) {
    return ETOrderDetailInfoEntityCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      eventId: eventId ?? this.eventId,
      ticketId: ticketId ?? this.ticketId,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      discountId: discountId ?? this.discountId,
      inviteCode: inviteCode ?? this.inviteCode,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<double>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<double>(orderId.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<double>(eventId.value);
    }
    if (ticketId.present) {
      map['ticket_id'] = Variable<double>(ticketId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (discountId.present) {
      map['discount_id'] = Variable<double>(discountId.value);
    }
    if (inviteCode.present) {
      map['invite_code'] = Variable<String>(inviteCode.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ETOrderDetailInfoEntityCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('eventId: $eventId, ')
          ..write('ticketId: $ticketId, ')
          ..write('quantity: $quantity, ')
          ..write('amount: $amount, ')
          ..write('discountId: $discountId, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $ETOrderDetailInfoEntityTable extends ETOrderDetailInfoEntity
    with TableInfo<$ETOrderDetailInfoEntityTable, ETOderDetailInfoEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ETOrderDetailInfoEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedRealColumn _id;
  @override
  GeneratedRealColumn get id => _id ??= _constructId();
  GeneratedRealColumn _constructId() {
    return GeneratedRealColumn(
      'id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  GeneratedRealColumn _orderId;
  @override
  GeneratedRealColumn get orderId => _orderId ??= _constructOrderId();
  GeneratedRealColumn _constructOrderId() {
    return GeneratedRealColumn(
      'order_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _eventIdMeta = const VerificationMeta('eventId');
  GeneratedRealColumn _eventId;
  @override
  GeneratedRealColumn get eventId => _eventId ??= _constructEventId();
  GeneratedRealColumn _constructEventId() {
    return GeneratedRealColumn(
      'event_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ticketIdMeta = const VerificationMeta('ticketId');
  GeneratedRealColumn _ticketId;
  @override
  GeneratedRealColumn get ticketId => _ticketId ??= _constructTicketId();
  GeneratedRealColumn _constructTicketId() {
    return GeneratedRealColumn(
      'ticket_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  GeneratedRealColumn _quantity;
  @override
  GeneratedRealColumn get quantity => _quantity ??= _constructQuantity();
  GeneratedRealColumn _constructQuantity() {
    return GeneratedRealColumn(
      'quantity',
      $tableName,
      true,
    );
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedRealColumn _amount;
  @override
  GeneratedRealColumn get amount => _amount ??= _constructAmount();
  GeneratedRealColumn _constructAmount() {
    return GeneratedRealColumn(
      'amount',
      $tableName,
      true,
    );
  }

  final VerificationMeta _discountIdMeta = const VerificationMeta('discountId');
  GeneratedRealColumn _discountId;
  @override
  GeneratedRealColumn get discountId => _discountId ??= _constructDiscountId();
  GeneratedRealColumn _constructDiscountId() {
    return GeneratedRealColumn(
      'discount_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _inviteCodeMeta = const VerificationMeta('inviteCode');
  GeneratedTextColumn _inviteCode;
  @override
  GeneratedTextColumn get inviteCode => _inviteCode ??= _constructInviteCode();
  GeneratedTextColumn _constructInviteCode() {
    return GeneratedTextColumn(
      'invite_code',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedTextColumn _status;
  @override
  GeneratedTextColumn get status => _status ??= _constructStatus();
  GeneratedTextColumn _constructStatus() {
    return GeneratedTextColumn(
      'status',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        orderId,
        eventId,
        ticketId,
        quantity,
        amount,
        discountId,
        inviteCode,
        status
      ];
  @override
  $ETOrderDetailInfoEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_et_order_detail';
  @override
  final String actualTableName = 'cip_et_order_detail';
  @override
  VerificationContext validateIntegrity(
      Insertable<ETOderDetailInfoEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id'], _orderIdMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id'], _eventIdMeta));
    }
    if (data.containsKey('ticket_id')) {
      context.handle(_ticketIdMeta,
          ticketId.isAcceptableOrUnknown(data['ticket_id'], _ticketIdMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity'], _quantityMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount'], _amountMeta));
    }
    if (data.containsKey('discount_id')) {
      context.handle(
          _discountIdMeta,
          discountId.isAcceptableOrUnknown(
              data['discount_id'], _discountIdMeta));
    }
    if (data.containsKey('invite_code')) {
      context.handle(
          _inviteCodeMeta,
          inviteCode.isAcceptableOrUnknown(
              data['invite_code'], _inviteCodeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ETOderDetailInfoEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ETOderDetailInfoEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ETOrderDetailInfoEntityTable createAlias(String alias) {
    return $ETOrderDetailInfoEntityTable(_db, alias);
  }
}

class ETOderInfoEntry extends DataClass implements Insertable<ETOderInfoEntry> {
  final double id;
  final String orderNo;
  final double guestId;
  final double eventId;
  final String paymentType;
  final double totalAmount;
  final String status;
  final double quantity;
  final String guestName;
  final String guestPhone;
  final String guestEmail;
  ETOderInfoEntry(
      {this.id,
      this.orderNo,
      this.guestId,
      this.eventId,
      this.paymentType,
      this.totalAmount,
      this.status,
      this.quantity,
      this.guestName,
      this.guestPhone,
      this.guestEmail});
  factory ETOderInfoEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    return ETOderInfoEntry(
      id: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      orderNo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}order_no']),
      guestId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}guest_id']),
      eventId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}event_id']),
      paymentType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_type']),
      totalAmount: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_amount']),
      status:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      quantity: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
      guestName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}guest_name']),
      guestPhone: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}guest_phone']),
      guestEmail: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}guest_email']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<double>(id);
    }
    if (!nullToAbsent || orderNo != null) {
      map['order_no'] = Variable<String>(orderNo);
    }
    if (!nullToAbsent || guestId != null) {
      map['guest_id'] = Variable<double>(guestId);
    }
    if (!nullToAbsent || eventId != null) {
      map['event_id'] = Variable<double>(eventId);
    }
    if (!nullToAbsent || paymentType != null) {
      map['payment_type'] = Variable<String>(paymentType);
    }
    if (!nullToAbsent || totalAmount != null) {
      map['total_amount'] = Variable<double>(totalAmount);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<double>(quantity);
    }
    if (!nullToAbsent || guestName != null) {
      map['guest_name'] = Variable<String>(guestName);
    }
    if (!nullToAbsent || guestPhone != null) {
      map['guest_phone'] = Variable<String>(guestPhone);
    }
    if (!nullToAbsent || guestEmail != null) {
      map['guest_email'] = Variable<String>(guestEmail);
    }
    return map;
  }

  ETOrderInfoEntityCompanion toCompanion(bool nullToAbsent) {
    return ETOrderInfoEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      orderNo: orderNo == null && nullToAbsent
          ? const Value.absent()
          : Value(orderNo),
      guestId: guestId == null && nullToAbsent
          ? const Value.absent()
          : Value(guestId),
      eventId: eventId == null && nullToAbsent
          ? const Value.absent()
          : Value(eventId),
      paymentType: paymentType == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentType),
      totalAmount: totalAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(totalAmount),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      guestName: guestName == null && nullToAbsent
          ? const Value.absent()
          : Value(guestName),
      guestPhone: guestPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(guestPhone),
      guestEmail: guestEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(guestEmail),
    );
  }

  factory ETOderInfoEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ETOderInfoEntry(
      id: serializer.fromJson<double>(json['id']),
      orderNo: serializer.fromJson<String>(json['orderNo']),
      guestId: serializer.fromJson<double>(json['guestId']),
      eventId: serializer.fromJson<double>(json['eventId']),
      paymentType: serializer.fromJson<String>(json['paymentType']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      status: serializer.fromJson<String>(json['status']),
      quantity: serializer.fromJson<double>(json['quantity']),
      guestName: serializer.fromJson<String>(json['guestName']),
      guestPhone: serializer.fromJson<String>(json['guestPhone']),
      guestEmail: serializer.fromJson<String>(json['guestEmail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<double>(id),
      'orderNo': serializer.toJson<String>(orderNo),
      'guestId': serializer.toJson<double>(guestId),
      'eventId': serializer.toJson<double>(eventId),
      'paymentType': serializer.toJson<String>(paymentType),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'status': serializer.toJson<String>(status),
      'quantity': serializer.toJson<double>(quantity),
      'guestName': serializer.toJson<String>(guestName),
      'guestPhone': serializer.toJson<String>(guestPhone),
      'guestEmail': serializer.toJson<String>(guestEmail),
    };
  }

  ETOderInfoEntry copyWith(
          {double id,
          String orderNo,
          double guestId,
          double eventId,
          String paymentType,
          double totalAmount,
          String status,
          double quantity,
          String guestName,
          String guestPhone,
          String guestEmail}) =>
      ETOderInfoEntry(
        id: id ?? this.id,
        orderNo: orderNo ?? this.orderNo,
        guestId: guestId ?? this.guestId,
        eventId: eventId ?? this.eventId,
        paymentType: paymentType ?? this.paymentType,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status,
        quantity: quantity ?? this.quantity,
        guestName: guestName ?? this.guestName,
        guestPhone: guestPhone ?? this.guestPhone,
        guestEmail: guestEmail ?? this.guestEmail,
      );
  @override
  String toString() {
    return (StringBuffer('ETOderInfoEntry(')
          ..write('id: $id, ')
          ..write('orderNo: $orderNo, ')
          ..write('guestId: $guestId, ')
          ..write('eventId: $eventId, ')
          ..write('paymentType: $paymentType, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('quantity: $quantity, ')
          ..write('guestName: $guestName, ')
          ..write('guestPhone: $guestPhone, ')
          ..write('guestEmail: $guestEmail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          orderNo.hashCode,
          $mrjc(
              guestId.hashCode,
              $mrjc(
                  eventId.hashCode,
                  $mrjc(
                      paymentType.hashCode,
                      $mrjc(
                          totalAmount.hashCode,
                          $mrjc(
                              status.hashCode,
                              $mrjc(
                                  quantity.hashCode,
                                  $mrjc(
                                      guestName.hashCode,
                                      $mrjc(guestPhone.hashCode,
                                          guestEmail.hashCode)))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ETOderInfoEntry &&
          other.id == this.id &&
          other.orderNo == this.orderNo &&
          other.guestId == this.guestId &&
          other.eventId == this.eventId &&
          other.paymentType == this.paymentType &&
          other.totalAmount == this.totalAmount &&
          other.status == this.status &&
          other.quantity == this.quantity &&
          other.guestName == this.guestName &&
          other.guestPhone == this.guestPhone &&
          other.guestEmail == this.guestEmail);
}

class ETOrderInfoEntityCompanion extends UpdateCompanion<ETOderInfoEntry> {
  final Value<double> id;
  final Value<String> orderNo;
  final Value<double> guestId;
  final Value<double> eventId;
  final Value<String> paymentType;
  final Value<double> totalAmount;
  final Value<String> status;
  final Value<double> quantity;
  final Value<String> guestName;
  final Value<String> guestPhone;
  final Value<String> guestEmail;
  const ETOrderInfoEntityCompanion({
    this.id = const Value.absent(),
    this.orderNo = const Value.absent(),
    this.guestId = const Value.absent(),
    this.eventId = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.quantity = const Value.absent(),
    this.guestName = const Value.absent(),
    this.guestPhone = const Value.absent(),
    this.guestEmail = const Value.absent(),
  });
  ETOrderInfoEntityCompanion.insert({
    this.id = const Value.absent(),
    this.orderNo = const Value.absent(),
    this.guestId = const Value.absent(),
    this.eventId = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.quantity = const Value.absent(),
    this.guestName = const Value.absent(),
    this.guestPhone = const Value.absent(),
    this.guestEmail = const Value.absent(),
  });
  static Insertable<ETOderInfoEntry> custom({
    Expression<double> id,
    Expression<String> orderNo,
    Expression<double> guestId,
    Expression<double> eventId,
    Expression<String> paymentType,
    Expression<double> totalAmount,
    Expression<String> status,
    Expression<double> quantity,
    Expression<String> guestName,
    Expression<String> guestPhone,
    Expression<String> guestEmail,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderNo != null) 'order_no': orderNo,
      if (guestId != null) 'guest_id': guestId,
      if (eventId != null) 'event_id': eventId,
      if (paymentType != null) 'payment_type': paymentType,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (status != null) 'status': status,
      if (quantity != null) 'quantity': quantity,
      if (guestName != null) 'guest_name': guestName,
      if (guestPhone != null) 'guest_phone': guestPhone,
      if (guestEmail != null) 'guest_email': guestEmail,
    });
  }

  ETOrderInfoEntityCompanion copyWith(
      {Value<double> id,
      Value<String> orderNo,
      Value<double> guestId,
      Value<double> eventId,
      Value<String> paymentType,
      Value<double> totalAmount,
      Value<String> status,
      Value<double> quantity,
      Value<String> guestName,
      Value<String> guestPhone,
      Value<String> guestEmail}) {
    return ETOrderInfoEntityCompanion(
      id: id ?? this.id,
      orderNo: orderNo ?? this.orderNo,
      guestId: guestId ?? this.guestId,
      eventId: eventId ?? this.eventId,
      paymentType: paymentType ?? this.paymentType,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      guestName: guestName ?? this.guestName,
      guestPhone: guestPhone ?? this.guestPhone,
      guestEmail: guestEmail ?? this.guestEmail,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<double>(id.value);
    }
    if (orderNo.present) {
      map['order_no'] = Variable<String>(orderNo.value);
    }
    if (guestId.present) {
      map['guest_id'] = Variable<double>(guestId.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<double>(eventId.value);
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<String>(paymentType.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (guestName.present) {
      map['guest_name'] = Variable<String>(guestName.value);
    }
    if (guestPhone.present) {
      map['guest_phone'] = Variable<String>(guestPhone.value);
    }
    if (guestEmail.present) {
      map['guest_email'] = Variable<String>(guestEmail.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ETOrderInfoEntityCompanion(')
          ..write('id: $id, ')
          ..write('orderNo: $orderNo, ')
          ..write('guestId: $guestId, ')
          ..write('eventId: $eventId, ')
          ..write('paymentType: $paymentType, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('quantity: $quantity, ')
          ..write('guestName: $guestName, ')
          ..write('guestPhone: $guestPhone, ')
          ..write('guestEmail: $guestEmail')
          ..write(')'))
        .toString();
  }
}

class $ETOrderInfoEntityTable extends ETOrderInfoEntity
    with TableInfo<$ETOrderInfoEntityTable, ETOderInfoEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ETOrderInfoEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedRealColumn _id;
  @override
  GeneratedRealColumn get id => _id ??= _constructId();
  GeneratedRealColumn _constructId() {
    return GeneratedRealColumn(
      'id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _orderNoMeta = const VerificationMeta('orderNo');
  GeneratedTextColumn _orderNo;
  @override
  GeneratedTextColumn get orderNo => _orderNo ??= _constructOrderNo();
  GeneratedTextColumn _constructOrderNo() {
    return GeneratedTextColumn(
      'order_no',
      $tableName,
      true,
    );
  }

  final VerificationMeta _guestIdMeta = const VerificationMeta('guestId');
  GeneratedRealColumn _guestId;
  @override
  GeneratedRealColumn get guestId => _guestId ??= _constructGuestId();
  GeneratedRealColumn _constructGuestId() {
    return GeneratedRealColumn(
      'guest_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _eventIdMeta = const VerificationMeta('eventId');
  GeneratedRealColumn _eventId;
  @override
  GeneratedRealColumn get eventId => _eventId ??= _constructEventId();
  GeneratedRealColumn _constructEventId() {
    return GeneratedRealColumn(
      'event_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  GeneratedTextColumn _paymentType;
  @override
  GeneratedTextColumn get paymentType =>
      _paymentType ??= _constructPaymentType();
  GeneratedTextColumn _constructPaymentType() {
    return GeneratedTextColumn(
      'payment_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  GeneratedRealColumn _totalAmount;
  @override
  GeneratedRealColumn get totalAmount =>
      _totalAmount ??= _constructTotalAmount();
  GeneratedRealColumn _constructTotalAmount() {
    return GeneratedRealColumn(
      'total_amount',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedTextColumn _status;
  @override
  GeneratedTextColumn get status => _status ??= _constructStatus();
  GeneratedTextColumn _constructStatus() {
    return GeneratedTextColumn(
      'status',
      $tableName,
      true,
    );
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  GeneratedRealColumn _quantity;
  @override
  GeneratedRealColumn get quantity => _quantity ??= _constructQuantity();
  GeneratedRealColumn _constructQuantity() {
    return GeneratedRealColumn(
      'quantity',
      $tableName,
      true,
    );
  }

  final VerificationMeta _guestNameMeta = const VerificationMeta('guestName');
  GeneratedTextColumn _guestName;
  @override
  GeneratedTextColumn get guestName => _guestName ??= _constructGuestName();
  GeneratedTextColumn _constructGuestName() {
    return GeneratedTextColumn(
      'guest_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _guestPhoneMeta = const VerificationMeta('guestPhone');
  GeneratedTextColumn _guestPhone;
  @override
  GeneratedTextColumn get guestPhone => _guestPhone ??= _constructGuestPhone();
  GeneratedTextColumn _constructGuestPhone() {
    return GeneratedTextColumn(
      'guest_phone',
      $tableName,
      true,
    );
  }

  final VerificationMeta _guestEmailMeta = const VerificationMeta('guestEmail');
  GeneratedTextColumn _guestEmail;
  @override
  GeneratedTextColumn get guestEmail => _guestEmail ??= _constructGuestEmail();
  GeneratedTextColumn _constructGuestEmail() {
    return GeneratedTextColumn(
      'guest_email',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        orderNo,
        guestId,
        eventId,
        paymentType,
        totalAmount,
        status,
        quantity,
        guestName,
        guestPhone,
        guestEmail
      ];
  @override
  $ETOrderInfoEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_et_oder';
  @override
  final String actualTableName = 'cip_et_oder';
  @override
  VerificationContext validateIntegrity(Insertable<ETOderInfoEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('order_no')) {
      context.handle(_orderNoMeta,
          orderNo.isAcceptableOrUnknown(data['order_no'], _orderNoMeta));
    }
    if (data.containsKey('guest_id')) {
      context.handle(_guestIdMeta,
          guestId.isAcceptableOrUnknown(data['guest_id'], _guestIdMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id'], _eventIdMeta));
    }
    if (data.containsKey('payment_type')) {
      context.handle(
          _paymentTypeMeta,
          paymentType.isAcceptableOrUnknown(
              data['payment_type'], _paymentTypeMeta));
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount'], _totalAmountMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity'], _quantityMeta));
    }
    if (data.containsKey('guest_name')) {
      context.handle(_guestNameMeta,
          guestName.isAcceptableOrUnknown(data['guest_name'], _guestNameMeta));
    }
    if (data.containsKey('guest_phone')) {
      context.handle(
          _guestPhoneMeta,
          guestPhone.isAcceptableOrUnknown(
              data['guest_phone'], _guestPhoneMeta));
    }
    if (data.containsKey('guest_email')) {
      context.handle(
          _guestEmailMeta,
          guestEmail.isAcceptableOrUnknown(
              data['guest_email'], _guestEmailMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ETOderInfoEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ETOderInfoEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ETOrderInfoEntityTable createAlias(String alias) {
    return $ETOrderInfoEntityTable(_db, alias);
  }
}

class EventTicketEntry extends DataClass
    implements Insertable<EventTicketEntry> {
  final double id;
  final String eventName;
  final String siteName;
  final String siteAddress;
  final String eventType;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String coverPathFile;
  final double coverRepoId;
  final String contactPhone;
  final String contactEmail;
  final String organizersName;
  final String organizersInfo;
  final String sendReminder;
  final String reminderDays;
  final double branchId;
  final double companyId;
  final bool startedState;
  final bool orderedState;
  EventTicketEntry(
      {this.id,
      this.eventName,
      this.siteName,
      this.siteAddress,
      this.eventType,
      this.startDate,
      this.endDate,
      this.description,
      this.coverPathFile,
      this.coverRepoId,
      this.contactPhone,
      this.contactEmail,
      this.organizersName,
      this.organizersInfo,
      this.sendReminder,
      this.reminderDays,
      this.branchId,
      this.companyId,
      this.startedState,
      this.orderedState});
  factory EventTicketEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return EventTicketEntry(
      id: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      eventName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}event_name']),
      siteName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}site_name']),
      siteAddress: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}site_address']),
      eventType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}event_type']),
      startDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}start_date']),
      endDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}end_date']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      coverPathFile: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_path_file']),
      coverRepoId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_repo_id']),
      contactPhone: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}contact_phone']),
      contactEmail: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}contact_email']),
      organizersName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}organizers_name']),
      organizersInfo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}organizers_info']),
      sendReminder: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}send_reminder']),
      reminderDays: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}reminder_days']),
      branchId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}branch_id']),
      companyId: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_id']),
      startedState: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}started_state']),
      orderedState: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}ordered_state']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<double>(id);
    }
    if (!nullToAbsent || eventName != null) {
      map['event_name'] = Variable<String>(eventName);
    }
    if (!nullToAbsent || siteName != null) {
      map['site_name'] = Variable<String>(siteName);
    }
    if (!nullToAbsent || siteAddress != null) {
      map['site_address'] = Variable<String>(siteAddress);
    }
    if (!nullToAbsent || eventType != null) {
      map['event_type'] = Variable<String>(eventType);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || coverPathFile != null) {
      map['cover_path_file'] = Variable<String>(coverPathFile);
    }
    if (!nullToAbsent || coverRepoId != null) {
      map['cover_repo_id'] = Variable<double>(coverRepoId);
    }
    if (!nullToAbsent || contactPhone != null) {
      map['contact_phone'] = Variable<String>(contactPhone);
    }
    if (!nullToAbsent || contactEmail != null) {
      map['contact_email'] = Variable<String>(contactEmail);
    }
    if (!nullToAbsent || organizersName != null) {
      map['organizers_name'] = Variable<String>(organizersName);
    }
    if (!nullToAbsent || organizersInfo != null) {
      map['organizers_info'] = Variable<String>(organizersInfo);
    }
    if (!nullToAbsent || sendReminder != null) {
      map['send_reminder'] = Variable<String>(sendReminder);
    }
    if (!nullToAbsent || reminderDays != null) {
      map['reminder_days'] = Variable<String>(reminderDays);
    }
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<double>(branchId);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<double>(companyId);
    }
    if (!nullToAbsent || startedState != null) {
      map['started_state'] = Variable<bool>(startedState);
    }
    if (!nullToAbsent || orderedState != null) {
      map['ordered_state'] = Variable<bool>(orderedState);
    }
    return map;
  }

  EventTicketEntityCompanion toCompanion(bool nullToAbsent) {
    return EventTicketEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      eventName: eventName == null && nullToAbsent
          ? const Value.absent()
          : Value(eventName),
      siteName: siteName == null && nullToAbsent
          ? const Value.absent()
          : Value(siteName),
      siteAddress: siteAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(siteAddress),
      eventType: eventType == null && nullToAbsent
          ? const Value.absent()
          : Value(eventType),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      coverPathFile: coverPathFile == null && nullToAbsent
          ? const Value.absent()
          : Value(coverPathFile),
      coverRepoId: coverRepoId == null && nullToAbsent
          ? const Value.absent()
          : Value(coverRepoId),
      contactPhone: contactPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPhone),
      contactEmail: contactEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(contactEmail),
      organizersName: organizersName == null && nullToAbsent
          ? const Value.absent()
          : Value(organizersName),
      organizersInfo: organizersInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(organizersInfo),
      sendReminder: sendReminder == null && nullToAbsent
          ? const Value.absent()
          : Value(sendReminder),
      reminderDays: reminderDays == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderDays),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      startedState: startedState == null && nullToAbsent
          ? const Value.absent()
          : Value(startedState),
      orderedState: orderedState == null && nullToAbsent
          ? const Value.absent()
          : Value(orderedState),
    );
  }

  factory EventTicketEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EventTicketEntry(
      id: serializer.fromJson<double>(json['id']),
      eventName: serializer.fromJson<String>(json['eventName']),
      siteName: serializer.fromJson<String>(json['siteName']),
      siteAddress: serializer.fromJson<String>(json['siteAddress']),
      eventType: serializer.fromJson<String>(json['eventType']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      description: serializer.fromJson<String>(json['description']),
      coverPathFile: serializer.fromJson<String>(json['coverPathFile']),
      coverRepoId: serializer.fromJson<double>(json['coverRepoId']),
      contactPhone: serializer.fromJson<String>(json['contactPhone']),
      contactEmail: serializer.fromJson<String>(json['contactEmail']),
      organizersName: serializer.fromJson<String>(json['organizersName']),
      organizersInfo: serializer.fromJson<String>(json['organizersInfo']),
      sendReminder: serializer.fromJson<String>(json['sendReminder']),
      reminderDays: serializer.fromJson<String>(json['reminderDays']),
      branchId: serializer.fromJson<double>(json['branchId']),
      companyId: serializer.fromJson<double>(json['companyId']),
      startedState: serializer.fromJson<bool>(json['startedState']),
      orderedState: serializer.fromJson<bool>(json['orderedState']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<double>(id),
      'eventName': serializer.toJson<String>(eventName),
      'siteName': serializer.toJson<String>(siteName),
      'siteAddress': serializer.toJson<String>(siteAddress),
      'eventType': serializer.toJson<String>(eventType),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'description': serializer.toJson<String>(description),
      'coverPathFile': serializer.toJson<String>(coverPathFile),
      'coverRepoId': serializer.toJson<double>(coverRepoId),
      'contactPhone': serializer.toJson<String>(contactPhone),
      'contactEmail': serializer.toJson<String>(contactEmail),
      'organizersName': serializer.toJson<String>(organizersName),
      'organizersInfo': serializer.toJson<String>(organizersInfo),
      'sendReminder': serializer.toJson<String>(sendReminder),
      'reminderDays': serializer.toJson<String>(reminderDays),
      'branchId': serializer.toJson<double>(branchId),
      'companyId': serializer.toJson<double>(companyId),
      'startedState': serializer.toJson<bool>(startedState),
      'orderedState': serializer.toJson<bool>(orderedState),
    };
  }

  EventTicketEntry copyWith(
          {double id,
          String eventName,
          String siteName,
          String siteAddress,
          String eventType,
          DateTime startDate,
          DateTime endDate,
          String description,
          String coverPathFile,
          double coverRepoId,
          String contactPhone,
          String contactEmail,
          String organizersName,
          String organizersInfo,
          String sendReminder,
          String reminderDays,
          double branchId,
          double companyId,
          bool startedState,
          bool orderedState}) =>
      EventTicketEntry(
        id: id ?? this.id,
        eventName: eventName ?? this.eventName,
        siteName: siteName ?? this.siteName,
        siteAddress: siteAddress ?? this.siteAddress,
        eventType: eventType ?? this.eventType,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        description: description ?? this.description,
        coverPathFile: coverPathFile ?? this.coverPathFile,
        coverRepoId: coverRepoId ?? this.coverRepoId,
        contactPhone: contactPhone ?? this.contactPhone,
        contactEmail: contactEmail ?? this.contactEmail,
        organizersName: organizersName ?? this.organizersName,
        organizersInfo: organizersInfo ?? this.organizersInfo,
        sendReminder: sendReminder ?? this.sendReminder,
        reminderDays: reminderDays ?? this.reminderDays,
        branchId: branchId ?? this.branchId,
        companyId: companyId ?? this.companyId,
        startedState: startedState ?? this.startedState,
        orderedState: orderedState ?? this.orderedState,
      );
  @override
  String toString() {
    return (StringBuffer('EventTicketEntry(')
          ..write('id: $id, ')
          ..write('eventName: $eventName, ')
          ..write('siteName: $siteName, ')
          ..write('siteAddress: $siteAddress, ')
          ..write('eventType: $eventType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('description: $description, ')
          ..write('coverPathFile: $coverPathFile, ')
          ..write('coverRepoId: $coverRepoId, ')
          ..write('contactPhone: $contactPhone, ')
          ..write('contactEmail: $contactEmail, ')
          ..write('organizersName: $organizersName, ')
          ..write('organizersInfo: $organizersInfo, ')
          ..write('sendReminder: $sendReminder, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('branchId: $branchId, ')
          ..write('companyId: $companyId, ')
          ..write('startedState: $startedState, ')
          ..write('orderedState: $orderedState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          eventName.hashCode,
          $mrjc(
              siteName.hashCode,
              $mrjc(
                  siteAddress.hashCode,
                  $mrjc(
                      eventType.hashCode,
                      $mrjc(
                          startDate.hashCode,
                          $mrjc(
                              endDate.hashCode,
                              $mrjc(
                                  description.hashCode,
                                  $mrjc(
                                      coverPathFile.hashCode,
                                      $mrjc(
                                          coverRepoId.hashCode,
                                          $mrjc(
                                              contactPhone.hashCode,
                                              $mrjc(
                                                  contactEmail.hashCode,
                                                  $mrjc(
                                                      organizersName.hashCode,
                                                      $mrjc(
                                                          organizersInfo
                                                              .hashCode,
                                                          $mrjc(
                                                              sendReminder
                                                                  .hashCode,
                                                              $mrjc(
                                                                  reminderDays
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      branchId
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          companyId
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              startedState.hashCode,
                                                                              orderedState.hashCode))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is EventTicketEntry &&
          other.id == this.id &&
          other.eventName == this.eventName &&
          other.siteName == this.siteName &&
          other.siteAddress == this.siteAddress &&
          other.eventType == this.eventType &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.description == this.description &&
          other.coverPathFile == this.coverPathFile &&
          other.coverRepoId == this.coverRepoId &&
          other.contactPhone == this.contactPhone &&
          other.contactEmail == this.contactEmail &&
          other.organizersName == this.organizersName &&
          other.organizersInfo == this.organizersInfo &&
          other.sendReminder == this.sendReminder &&
          other.reminderDays == this.reminderDays &&
          other.branchId == this.branchId &&
          other.companyId == this.companyId &&
          other.startedState == this.startedState &&
          other.orderedState == this.orderedState);
}

class EventTicketEntityCompanion extends UpdateCompanion<EventTicketEntry> {
  final Value<double> id;
  final Value<String> eventName;
  final Value<String> siteName;
  final Value<String> siteAddress;
  final Value<String> eventType;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String> description;
  final Value<String> coverPathFile;
  final Value<double> coverRepoId;
  final Value<String> contactPhone;
  final Value<String> contactEmail;
  final Value<String> organizersName;
  final Value<String> organizersInfo;
  final Value<String> sendReminder;
  final Value<String> reminderDays;
  final Value<double> branchId;
  final Value<double> companyId;
  final Value<bool> startedState;
  final Value<bool> orderedState;
  const EventTicketEntityCompanion({
    this.id = const Value.absent(),
    this.eventName = const Value.absent(),
    this.siteName = const Value.absent(),
    this.siteAddress = const Value.absent(),
    this.eventType = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.description = const Value.absent(),
    this.coverPathFile = const Value.absent(),
    this.coverRepoId = const Value.absent(),
    this.contactPhone = const Value.absent(),
    this.contactEmail = const Value.absent(),
    this.organizersName = const Value.absent(),
    this.organizersInfo = const Value.absent(),
    this.sendReminder = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.branchId = const Value.absent(),
    this.companyId = const Value.absent(),
    this.startedState = const Value.absent(),
    this.orderedState = const Value.absent(),
  });
  EventTicketEntityCompanion.insert({
    this.id = const Value.absent(),
    this.eventName = const Value.absent(),
    this.siteName = const Value.absent(),
    this.siteAddress = const Value.absent(),
    this.eventType = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.description = const Value.absent(),
    this.coverPathFile = const Value.absent(),
    this.coverRepoId = const Value.absent(),
    this.contactPhone = const Value.absent(),
    this.contactEmail = const Value.absent(),
    this.organizersName = const Value.absent(),
    this.organizersInfo = const Value.absent(),
    this.sendReminder = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.branchId = const Value.absent(),
    this.companyId = const Value.absent(),
    this.startedState = const Value.absent(),
    this.orderedState = const Value.absent(),
  });
  static Insertable<EventTicketEntry> custom({
    Expression<double> id,
    Expression<String> eventName,
    Expression<String> siteName,
    Expression<String> siteAddress,
    Expression<String> eventType,
    Expression<DateTime> startDate,
    Expression<DateTime> endDate,
    Expression<String> description,
    Expression<String> coverPathFile,
    Expression<double> coverRepoId,
    Expression<String> contactPhone,
    Expression<String> contactEmail,
    Expression<String> organizersName,
    Expression<String> organizersInfo,
    Expression<String> sendReminder,
    Expression<String> reminderDays,
    Expression<double> branchId,
    Expression<double> companyId,
    Expression<bool> startedState,
    Expression<bool> orderedState,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventName != null) 'event_name': eventName,
      if (siteName != null) 'site_name': siteName,
      if (siteAddress != null) 'site_address': siteAddress,
      if (eventType != null) 'event_type': eventType,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (description != null) 'description': description,
      if (coverPathFile != null) 'cover_path_file': coverPathFile,
      if (coverRepoId != null) 'cover_repo_id': coverRepoId,
      if (contactPhone != null) 'contact_phone': contactPhone,
      if (contactEmail != null) 'contact_email': contactEmail,
      if (organizersName != null) 'organizers_name': organizersName,
      if (organizersInfo != null) 'organizers_info': organizersInfo,
      if (sendReminder != null) 'send_reminder': sendReminder,
      if (reminderDays != null) 'reminder_days': reminderDays,
      if (branchId != null) 'branch_id': branchId,
      if (companyId != null) 'company_id': companyId,
      if (startedState != null) 'started_state': startedState,
      if (orderedState != null) 'ordered_state': orderedState,
    });
  }

  EventTicketEntityCompanion copyWith(
      {Value<double> id,
      Value<String> eventName,
      Value<String> siteName,
      Value<String> siteAddress,
      Value<String> eventType,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<String> description,
      Value<String> coverPathFile,
      Value<double> coverRepoId,
      Value<String> contactPhone,
      Value<String> contactEmail,
      Value<String> organizersName,
      Value<String> organizersInfo,
      Value<String> sendReminder,
      Value<String> reminderDays,
      Value<double> branchId,
      Value<double> companyId,
      Value<bool> startedState,
      Value<bool> orderedState}) {
    return EventTicketEntityCompanion(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      siteName: siteName ?? this.siteName,
      siteAddress: siteAddress ?? this.siteAddress,
      eventType: eventType ?? this.eventType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      coverPathFile: coverPathFile ?? this.coverPathFile,
      coverRepoId: coverRepoId ?? this.coverRepoId,
      contactPhone: contactPhone ?? this.contactPhone,
      contactEmail: contactEmail ?? this.contactEmail,
      organizersName: organizersName ?? this.organizersName,
      organizersInfo: organizersInfo ?? this.organizersInfo,
      sendReminder: sendReminder ?? this.sendReminder,
      reminderDays: reminderDays ?? this.reminderDays,
      branchId: branchId ?? this.branchId,
      companyId: companyId ?? this.companyId,
      startedState: startedState ?? this.startedState,
      orderedState: orderedState ?? this.orderedState,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<double>(id.value);
    }
    if (eventName.present) {
      map['event_name'] = Variable<String>(eventName.value);
    }
    if (siteName.present) {
      map['site_name'] = Variable<String>(siteName.value);
    }
    if (siteAddress.present) {
      map['site_address'] = Variable<String>(siteAddress.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (coverPathFile.present) {
      map['cover_path_file'] = Variable<String>(coverPathFile.value);
    }
    if (coverRepoId.present) {
      map['cover_repo_id'] = Variable<double>(coverRepoId.value);
    }
    if (contactPhone.present) {
      map['contact_phone'] = Variable<String>(contactPhone.value);
    }
    if (contactEmail.present) {
      map['contact_email'] = Variable<String>(contactEmail.value);
    }
    if (organizersName.present) {
      map['organizers_name'] = Variable<String>(organizersName.value);
    }
    if (organizersInfo.present) {
      map['organizers_info'] = Variable<String>(organizersInfo.value);
    }
    if (sendReminder.present) {
      map['send_reminder'] = Variable<String>(sendReminder.value);
    }
    if (reminderDays.present) {
      map['reminder_days'] = Variable<String>(reminderDays.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<double>(branchId.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<double>(companyId.value);
    }
    if (startedState.present) {
      map['started_state'] = Variable<bool>(startedState.value);
    }
    if (orderedState.present) {
      map['ordered_state'] = Variable<bool>(orderedState.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventTicketEntityCompanion(')
          ..write('id: $id, ')
          ..write('eventName: $eventName, ')
          ..write('siteName: $siteName, ')
          ..write('siteAddress: $siteAddress, ')
          ..write('eventType: $eventType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('description: $description, ')
          ..write('coverPathFile: $coverPathFile, ')
          ..write('coverRepoId: $coverRepoId, ')
          ..write('contactPhone: $contactPhone, ')
          ..write('contactEmail: $contactEmail, ')
          ..write('organizersName: $organizersName, ')
          ..write('organizersInfo: $organizersInfo, ')
          ..write('sendReminder: $sendReminder, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('branchId: $branchId, ')
          ..write('companyId: $companyId, ')
          ..write('startedState: $startedState, ')
          ..write('orderedState: $orderedState')
          ..write(')'))
        .toString();
  }
}

class $EventTicketEntityTable extends EventTicketEntity
    with TableInfo<$EventTicketEntityTable, EventTicketEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventTicketEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedRealColumn _id;
  @override
  GeneratedRealColumn get id => _id ??= _constructId();
  GeneratedRealColumn _constructId() {
    return GeneratedRealColumn(
      'id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _eventNameMeta = const VerificationMeta('eventName');
  GeneratedTextColumn _eventName;
  @override
  GeneratedTextColumn get eventName => _eventName ??= _constructEventName();
  GeneratedTextColumn _constructEventName() {
    return GeneratedTextColumn(
      'event_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _siteNameMeta = const VerificationMeta('siteName');
  GeneratedTextColumn _siteName;
  @override
  GeneratedTextColumn get siteName => _siteName ??= _constructSiteName();
  GeneratedTextColumn _constructSiteName() {
    return GeneratedTextColumn(
      'site_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _siteAddressMeta =
      const VerificationMeta('siteAddress');
  GeneratedTextColumn _siteAddress;
  @override
  GeneratedTextColumn get siteAddress =>
      _siteAddress ??= _constructSiteAddress();
  GeneratedTextColumn _constructSiteAddress() {
    return GeneratedTextColumn(
      'site_address',
      $tableName,
      true,
    );
  }

  final VerificationMeta _eventTypeMeta = const VerificationMeta('eventType');
  GeneratedTextColumn _eventType;
  @override
  GeneratedTextColumn get eventType => _eventType ??= _constructEventType();
  GeneratedTextColumn _constructEventType() {
    return GeneratedTextColumn(
      'event_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  GeneratedDateTimeColumn _startDate;
  @override
  GeneratedDateTimeColumn get startDate => _startDate ??= _constructStartDate();
  GeneratedDateTimeColumn _constructStartDate() {
    return GeneratedDateTimeColumn(
      'start_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _endDateMeta = const VerificationMeta('endDate');
  GeneratedDateTimeColumn _endDate;
  @override
  GeneratedDateTimeColumn get endDate => _endDate ??= _constructEndDate();
  GeneratedDateTimeColumn _constructEndDate() {
    return GeneratedDateTimeColumn(
      'end_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _coverPathFileMeta =
      const VerificationMeta('coverPathFile');
  GeneratedTextColumn _coverPathFile;
  @override
  GeneratedTextColumn get coverPathFile =>
      _coverPathFile ??= _constructCoverPathFile();
  GeneratedTextColumn _constructCoverPathFile() {
    return GeneratedTextColumn(
      'cover_path_file',
      $tableName,
      true,
    );
  }

  final VerificationMeta _coverRepoIdMeta =
      const VerificationMeta('coverRepoId');
  GeneratedRealColumn _coverRepoId;
  @override
  GeneratedRealColumn get coverRepoId =>
      _coverRepoId ??= _constructCoverRepoId();
  GeneratedRealColumn _constructCoverRepoId() {
    return GeneratedRealColumn(
      'cover_repo_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _contactPhoneMeta =
      const VerificationMeta('contactPhone');
  GeneratedTextColumn _contactPhone;
  @override
  GeneratedTextColumn get contactPhone =>
      _contactPhone ??= _constructContactPhone();
  GeneratedTextColumn _constructContactPhone() {
    return GeneratedTextColumn(
      'contact_phone',
      $tableName,
      true,
    );
  }

  final VerificationMeta _contactEmailMeta =
      const VerificationMeta('contactEmail');
  GeneratedTextColumn _contactEmail;
  @override
  GeneratedTextColumn get contactEmail =>
      _contactEmail ??= _constructContactEmail();
  GeneratedTextColumn _constructContactEmail() {
    return GeneratedTextColumn(
      'contact_email',
      $tableName,
      true,
    );
  }

  final VerificationMeta _organizersNameMeta =
      const VerificationMeta('organizersName');
  GeneratedTextColumn _organizersName;
  @override
  GeneratedTextColumn get organizersName =>
      _organizersName ??= _constructOrganizersName();
  GeneratedTextColumn _constructOrganizersName() {
    return GeneratedTextColumn(
      'organizers_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _organizersInfoMeta =
      const VerificationMeta('organizersInfo');
  GeneratedTextColumn _organizersInfo;
  @override
  GeneratedTextColumn get organizersInfo =>
      _organizersInfo ??= _constructOrganizersInfo();
  GeneratedTextColumn _constructOrganizersInfo() {
    return GeneratedTextColumn(
      'organizers_info',
      $tableName,
      true,
    );
  }

  final VerificationMeta _sendReminderMeta =
      const VerificationMeta('sendReminder');
  GeneratedTextColumn _sendReminder;
  @override
  GeneratedTextColumn get sendReminder =>
      _sendReminder ??= _constructSendReminder();
  GeneratedTextColumn _constructSendReminder() {
    return GeneratedTextColumn(
      'send_reminder',
      $tableName,
      true,
    );
  }

  final VerificationMeta _reminderDaysMeta =
      const VerificationMeta('reminderDays');
  GeneratedTextColumn _reminderDays;
  @override
  GeneratedTextColumn get reminderDays =>
      _reminderDays ??= _constructReminderDays();
  GeneratedTextColumn _constructReminderDays() {
    return GeneratedTextColumn(
      'reminder_days',
      $tableName,
      true,
    );
  }

  final VerificationMeta _branchIdMeta = const VerificationMeta('branchId');
  GeneratedRealColumn _branchId;
  @override
  GeneratedRealColumn get branchId => _branchId ??= _constructBranchId();
  GeneratedRealColumn _constructBranchId() {
    return GeneratedRealColumn(
      'branch_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _companyIdMeta = const VerificationMeta('companyId');
  GeneratedRealColumn _companyId;
  @override
  GeneratedRealColumn get companyId => _companyId ??= _constructCompanyId();
  GeneratedRealColumn _constructCompanyId() {
    return GeneratedRealColumn(
      'company_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _startedStateMeta =
      const VerificationMeta('startedState');
  GeneratedBoolColumn _startedState;
  @override
  GeneratedBoolColumn get startedState =>
      _startedState ??= _constructStartedState();
  GeneratedBoolColumn _constructStartedState() {
    return GeneratedBoolColumn(
      'started_state',
      $tableName,
      true,
    );
  }

  final VerificationMeta _orderedStateMeta =
      const VerificationMeta('orderedState');
  GeneratedBoolColumn _orderedState;
  @override
  GeneratedBoolColumn get orderedState =>
      _orderedState ??= _constructOrderedState();
  GeneratedBoolColumn _constructOrderedState() {
    return GeneratedBoolColumn(
      'ordered_state',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        eventName,
        siteName,
        siteAddress,
        eventType,
        startDate,
        endDate,
        description,
        coverPathFile,
        coverRepoId,
        contactPhone,
        contactEmail,
        organizersName,
        organizersInfo,
        sendReminder,
        reminderDays,
        branchId,
        companyId,
        startedState,
        orderedState
      ];
  @override
  $EventTicketEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_event_ticket';
  @override
  final String actualTableName = 'cip_event_ticket';
  @override
  VerificationContext validateIntegrity(Insertable<EventTicketEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('event_name')) {
      context.handle(_eventNameMeta,
          eventName.isAcceptableOrUnknown(data['event_name'], _eventNameMeta));
    }
    if (data.containsKey('site_name')) {
      context.handle(_siteNameMeta,
          siteName.isAcceptableOrUnknown(data['site_name'], _siteNameMeta));
    }
    if (data.containsKey('site_address')) {
      context.handle(
          _siteAddressMeta,
          siteAddress.isAcceptableOrUnknown(
              data['site_address'], _siteAddressMeta));
    }
    if (data.containsKey('event_type')) {
      context.handle(_eventTypeMeta,
          eventType.isAcceptableOrUnknown(data['event_type'], _eventTypeMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date'], _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date'], _endDateMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('cover_path_file')) {
      context.handle(
          _coverPathFileMeta,
          coverPathFile.isAcceptableOrUnknown(
              data['cover_path_file'], _coverPathFileMeta));
    }
    if (data.containsKey('cover_repo_id')) {
      context.handle(
          _coverRepoIdMeta,
          coverRepoId.isAcceptableOrUnknown(
              data['cover_repo_id'], _coverRepoIdMeta));
    }
    if (data.containsKey('contact_phone')) {
      context.handle(
          _contactPhoneMeta,
          contactPhone.isAcceptableOrUnknown(
              data['contact_phone'], _contactPhoneMeta));
    }
    if (data.containsKey('contact_email')) {
      context.handle(
          _contactEmailMeta,
          contactEmail.isAcceptableOrUnknown(
              data['contact_email'], _contactEmailMeta));
    }
    if (data.containsKey('organizers_name')) {
      context.handle(
          _organizersNameMeta,
          organizersName.isAcceptableOrUnknown(
              data['organizers_name'], _organizersNameMeta));
    }
    if (data.containsKey('organizers_info')) {
      context.handle(
          _organizersInfoMeta,
          organizersInfo.isAcceptableOrUnknown(
              data['organizers_info'], _organizersInfoMeta));
    }
    if (data.containsKey('send_reminder')) {
      context.handle(
          _sendReminderMeta,
          sendReminder.isAcceptableOrUnknown(
              data['send_reminder'], _sendReminderMeta));
    }
    if (data.containsKey('reminder_days')) {
      context.handle(
          _reminderDaysMeta,
          reminderDays.isAcceptableOrUnknown(
              data['reminder_days'], _reminderDaysMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id'], _branchIdMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id'], _companyIdMeta));
    }
    if (data.containsKey('started_state')) {
      context.handle(
          _startedStateMeta,
          startedState.isAcceptableOrUnknown(
              data['started_state'], _startedStateMeta));
    }
    if (data.containsKey('ordered_state')) {
      context.handle(
          _orderedStateMeta,
          orderedState.isAcceptableOrUnknown(
              data['ordered_state'], _orderedStateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  EventTicketEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return EventTicketEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EventTicketEntityTable createAlias(String alias) {
    return $EventTicketEntityTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ConfigurationEntityTable _configurationEntity;
  $ConfigurationEntityTable get configurationEntity =>
      _configurationEntity ??= $ConfigurationEntityTable(this);
  $VisitorCheckInEntityTable _visitorCheckInEntity;
  $VisitorCheckInEntityTable get visitorCheckInEntity =>
      _visitorCheckInEntity ??= $VisitorCheckInEntityTable(this);
  $VisitorTypeEntityTable _visitorTypeEntity;
  $VisitorTypeEntityTable get visitorTypeEntity =>
      _visitorTypeEntity ??= $VisitorTypeEntityTable(this);
  $CheckInFlowEntityTable _checkInFlowEntity;
  $CheckInFlowEntityTable get checkInFlowEntity =>
      _checkInFlowEntity ??= $CheckInFlowEntityTable(this);
  $VisitorLogEntityTable _visitorLogEntity;
  $VisitorLogEntityTable get visitorLogEntity =>
      _visitorLogEntity ??= $VisitorLogEntityTable(this);
  $CompanyBuildingEntityTable _companyBuildingEntity;
  $CompanyBuildingEntityTable get companyBuildingEntity =>
      _companyBuildingEntity ??= $CompanyBuildingEntityTable(this);
  $VisitorCompanyEntityTable _visitorCompanyEntity;
  $VisitorCompanyEntityTable get visitorCompanyEntity =>
      _visitorCompanyEntity ??= $VisitorCompanyEntityTable(this);
  $ContactPersonEntityTable _contactPersonEntity;
  $ContactPersonEntityTable get contactPersonEntity =>
      _contactPersonEntity ??= $ContactPersonEntityTable(this);
  $VisitorValueEntityTable _visitorValueEntity;
  $VisitorValueEntityTable get visitorValueEntity =>
      _visitorValueEntity ??= $VisitorValueEntityTable(this);
  $EventLogEntityTable _eventLogEntity;
  $EventLogEntityTable get eventLogEntity =>
      _eventLogEntity ??= $EventLogEntityTable(this);
  $EventDetailEntityTable _eventDetailEntity;
  $EventDetailEntityTable get eventDetailEntity =>
      _eventDetailEntity ??= $EventDetailEntityTable(this);
  $ImageDownloadedEntityTable _imageDownloadedEntity;
  $ImageDownloadedEntityTable get imageDownloadedEntity =>
      _imageDownloadedEntity ??= $ImageDownloadedEntityTable(this);
  $ETOrderDetailInfoEntityTable _eTOrderDetailInfoEntity;
  $ETOrderDetailInfoEntityTable get eTOrderDetailInfoEntity =>
      _eTOrderDetailInfoEntity ??= $ETOrderDetailInfoEntityTable(this);
  $ETOrderInfoEntityTable _eTOrderInfoEntity;
  $ETOrderInfoEntityTable get eTOrderInfoEntity =>
      _eTOrderInfoEntity ??= $ETOrderInfoEntityTable(this);
  $EventTicketEntityTable _eventTicketEntity;
  $EventTicketEntityTable get eventTicketEntity =>
      _eventTicketEntity ??= $EventTicketEntityTable(this);
  ConfigurationDAO _configurationDAO;
  ConfigurationDAO get configurationDAO =>
      _configurationDAO ??= ConfigurationDAO(this as Database);
  VisitorCheckInDAO _visitorCheckInDAO;
  VisitorCheckInDAO get visitorCheckInDAO =>
      _visitorCheckInDAO ??= VisitorCheckInDAO(this as Database);
  VisitorTypeDAO _visitorTypeDAO;
  VisitorTypeDAO get visitorTypeDAO =>
      _visitorTypeDAO ??= VisitorTypeDAO(this as Database);
  CheckInFlowDAO _checkInFlowDAO;
  CheckInFlowDAO get checkInFlowDAO =>
      _checkInFlowDAO ??= CheckInFlowDAO(this as Database);
  VisitorLogDAO _visitorLogDAO;
  VisitorLogDAO get visitorLogDAO =>
      _visitorLogDAO ??= VisitorLogDAO(this as Database);
  CompanyBuildingDAO _companyBuildingDAO;
  CompanyBuildingDAO get companyBuildingDAO =>
      _companyBuildingDAO ??= CompanyBuildingDAO(this as Database);
  VisitorCompanyDAO _visitorCompanyDAO;
  VisitorCompanyDAO get visitorCompanyDAO =>
      _visitorCompanyDAO ??= VisitorCompanyDAO(this as Database);
  ContactPersonDAO _contactPersonDAO;
  ContactPersonDAO get contactPersonDAO =>
      _contactPersonDAO ??= ContactPersonDAO(this as Database);
  VisitorValueDAO _visitorValueDAO;
  VisitorValueDAO get visitorValueDAO =>
      _visitorValueDAO ??= VisitorValueDAO(this as Database);
  EventLogDAO _eventLogDAO;
  EventLogDAO get eventLogDAO => _eventLogDAO ??= EventLogDAO(this as Database);
  EventDetailDAO _eventDetailDAO;
  EventDetailDAO get eventDetailDAO =>
      _eventDetailDAO ??= EventDetailDAO(this as Database);
  ImageDownloadedDAO _imageDownloadedDAO;
  ImageDownloadedDAO get imageDownloadedDAO =>
      _imageDownloadedDAO ??= ImageDownloadedDAO(this as Database);

  ETOrderDetailInfoDAO _eTOrderDetailInfoDAO;
  ETOrderDetailInfoDAO get eTOrderDetailInfoDAO =>
      _eTOrderDetailInfoDAO ??= ETOrderDetailInfoDAO(this as Database);
  ETOrderInfoDAO _eTOrderInfoDAO;
  ETOrderInfoDAO get eTOrderInfoDAO =>
      _eTOrderInfoDAO ??= ETOrderInfoDAO(this as Database);
  EventTicketDAO _eventTicketDAO;
  EventTicketDAO get eventTicketDAO =>
      _eventTicketDAO ??= EventTicketDAO(this as Database);

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        configurationEntity,
        visitorCheckInEntity,
        visitorTypeEntity,
        checkInFlowEntity,
        visitorLogEntity,
        companyBuildingEntity,
        visitorCompanyEntity,
        contactPersonEntity,
        visitorValueEntity,
        eventLogEntity,
        eventDetailEntity,
        imageDownloadedEntity,
        eTOrderDetailInfoEntity,
        eTOrderInfoEntity,
        eventTicketEntity
      ];
}
