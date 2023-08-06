// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// ignore_for_file: type=lint
class $MCPCardsTable extends MCPCards with TableInfo<$MCPCardsTable, MCPCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MCPCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _motherNameMeta =
      const VerificationMeta('motherName');
  @override
  late final GeneratedColumn<String> motherName = GeneratedColumn<String>(
      'mother_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _motherNamePhoneticMeta =
      const VerificationMeta('motherNamePhonetic');
  @override
  late final GeneratedColumn<String> motherNamePhonetic =
      GeneratedColumn<String>('mother_name_phonetic', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _motherAgeMeta =
      const VerificationMeta('motherAge');
  @override
  late final GeneratedColumn<int> motherAge = GeneratedColumn<int>(
      'mother_age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _mothersMobileMeta =
      const VerificationMeta('mothersMobile');
  @override
  late final GeneratedColumn<String> mothersMobile = GeneratedColumn<String>(
      'mothers_mobile', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fatherNameMeta =
      const VerificationMeta('fatherName');
  @override
  late final GeneratedColumn<String> fatherName = GeneratedColumn<String>(
      'father_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fatherMobileMeta =
      const VerificationMeta('fatherMobile');
  @override
  late final GeneratedColumn<String> fatherMobile = GeneratedColumn<String>(
      'father_mobile', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mctsOrRchIdMeta =
      const VerificationMeta('mctsOrRchId');
  @override
  late final GeneratedColumn<String> mctsOrRchId = GeneratedColumn<String>(
      'mcts_or_rch_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lmpMeta = const VerificationMeta('lmp');
  @override
  late final GeneratedColumn<DateTime> lmp = GeneratedColumn<DateTime>(
      'lmp', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _eddMeta = const VerificationMeta('edd');
  @override
  late final GeneratedColumn<DateTime> edd = GeneratedColumn<DateTime>(
      'edd', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _healthIssuesMeta =
      const VerificationMeta('healthIssues');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      healthIssues = GeneratedColumn<String>(
              'health_issues', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('[]'))
          .withConverter<List<String>>($MCPCardsTable.$converterhealthIssues);
  static const VerificationMeta _hemoglobinMeta =
      const VerificationMeta('hemoglobin');
  @override
  late final GeneratedColumn<double> hemoglobin = GeneratedColumn<double>(
      'hemoglobin', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sBpMeta = const VerificationMeta('sBp');
  @override
  late final GeneratedColumn<int> sBp = GeneratedColumn<int>(
      's_bp', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dBpMeta = const VerificationMeta('dBp');
  @override
  late final GeneratedColumn<int> dBp = GeneratedColumn<int>(
      'd_bp', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _bankNameMeta =
      const VerificationMeta('bankName');
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
      'bank_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _branchNameMeta =
      const VerificationMeta('branchName');
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
      'branch_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accountNumberMeta =
      const VerificationMeta('accountNumber');
  @override
  late final GeneratedColumn<String> accountNumber = GeneratedColumn<String>(
      'account_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ifscCodeMeta =
      const VerificationMeta('ifscCode');
  @override
  late final GeneratedColumn<String> ifscCode = GeneratedColumn<String>(
      'ifsc_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        motherName,
        motherNamePhonetic,
        motherAge,
        mothersMobile,
        fatherName,
        fatherMobile,
        address,
        mctsOrRchId,
        lmp,
        edd,
        healthIssues,
        hemoglobin,
        sBp,
        dBp,
        bankName,
        branchName,
        accountNumber,
        ifscCode
      ];
  @override
  String get aliasedName => _alias ?? 'm_c_p_cards';
  @override
  String get actualTableName => 'm_c_p_cards';
  @override
  VerificationContext validateIntegrity(Insertable<MCPCard> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('mother_name')) {
      context.handle(
          _motherNameMeta,
          motherName.isAcceptableOrUnknown(
              data['mother_name']!, _motherNameMeta));
    } else if (isInserting) {
      context.missing(_motherNameMeta);
    }
    if (data.containsKey('mother_name_phonetic')) {
      context.handle(
          _motherNamePhoneticMeta,
          motherNamePhonetic.isAcceptableOrUnknown(
              data['mother_name_phonetic']!, _motherNamePhoneticMeta));
    }
    if (data.containsKey('mother_age')) {
      context.handle(_motherAgeMeta,
          motherAge.isAcceptableOrUnknown(data['mother_age']!, _motherAgeMeta));
    }
    if (data.containsKey('mothers_mobile')) {
      context.handle(
          _mothersMobileMeta,
          mothersMobile.isAcceptableOrUnknown(
              data['mothers_mobile']!, _mothersMobileMeta));
    }
    if (data.containsKey('father_name')) {
      context.handle(
          _fatherNameMeta,
          fatherName.isAcceptableOrUnknown(
              data['father_name']!, _fatherNameMeta));
    }
    if (data.containsKey('father_mobile')) {
      context.handle(
          _fatherMobileMeta,
          fatherMobile.isAcceptableOrUnknown(
              data['father_mobile']!, _fatherMobileMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('mcts_or_rch_id')) {
      context.handle(
          _mctsOrRchIdMeta,
          mctsOrRchId.isAcceptableOrUnknown(
              data['mcts_or_rch_id']!, _mctsOrRchIdMeta));
    }
    if (data.containsKey('lmp')) {
      context.handle(
          _lmpMeta, lmp.isAcceptableOrUnknown(data['lmp']!, _lmpMeta));
    }
    if (data.containsKey('edd')) {
      context.handle(
          _eddMeta, edd.isAcceptableOrUnknown(data['edd']!, _eddMeta));
    }
    context.handle(_healthIssuesMeta, const VerificationResult.success());
    if (data.containsKey('hemoglobin')) {
      context.handle(
          _hemoglobinMeta,
          hemoglobin.isAcceptableOrUnknown(
              data['hemoglobin']!, _hemoglobinMeta));
    }
    if (data.containsKey('s_bp')) {
      context.handle(
          _sBpMeta, sBp.isAcceptableOrUnknown(data['s_bp']!, _sBpMeta));
    }
    if (data.containsKey('d_bp')) {
      context.handle(
          _dBpMeta, dBp.isAcceptableOrUnknown(data['d_bp']!, _dBpMeta));
    }
    if (data.containsKey('bank_name')) {
      context.handle(_bankNameMeta,
          bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta));
    }
    if (data.containsKey('branch_name')) {
      context.handle(
          _branchNameMeta,
          branchName.isAcceptableOrUnknown(
              data['branch_name']!, _branchNameMeta));
    }
    if (data.containsKey('account_number')) {
      context.handle(
          _accountNumberMeta,
          accountNumber.isAcceptableOrUnknown(
              data['account_number']!, _accountNumberMeta));
    }
    if (data.containsKey('ifsc_code')) {
      context.handle(_ifscCodeMeta,
          ifscCode.isAcceptableOrUnknown(data['ifsc_code']!, _ifscCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MCPCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MCPCard(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      motherName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mother_name'])!,
      motherNamePhonetic: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}mother_name_phonetic']),
      motherAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mother_age']),
      mothersMobile: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mothers_mobile']),
      fatherName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}father_name']),
      fatherMobile: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}father_mobile']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      mctsOrRchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mcts_or_rch_id']),
      lmp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}lmp']),
      edd: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}edd']),
      healthIssues: $MCPCardsTable.$converterhealthIssues.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}health_issues'])!),
      hemoglobin: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hemoglobin']),
      sBp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}s_bp']),
      dBp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}d_bp']),
      bankName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bank_name']),
      branchName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_name']),
      accountNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_number']),
      ifscCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ifsc_code']),
    );
  }

  @override
  $MCPCardsTable createAlias(String alias) {
    return $MCPCardsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterhealthIssues =
      const StringListConverter();
}

class MCPCard extends DataClass implements Insertable<MCPCard> {
  final int id;
  final DateTime createdAt;
  final String motherName;
  final String? motherNamePhonetic;
  final int? motherAge;
  final String? mothersMobile;
  final String? fatherName;
  final String? fatherMobile;
  final String? address;
  final String? mctsOrRchId;
  final DateTime? lmp;
  final DateTime? edd;
  final List<String> healthIssues;
  final double? hemoglobin;
  final int? sBp;
  final int? dBp;
  final String? bankName;
  final String? branchName;
  final String? accountNumber;
  final String? ifscCode;
  const MCPCard(
      {required this.id,
      required this.createdAt,
      required this.motherName,
      this.motherNamePhonetic,
      this.motherAge,
      this.mothersMobile,
      this.fatherName,
      this.fatherMobile,
      this.address,
      this.mctsOrRchId,
      this.lmp,
      this.edd,
      required this.healthIssues,
      this.hemoglobin,
      this.sBp,
      this.dBp,
      this.bankName,
      this.branchName,
      this.accountNumber,
      this.ifscCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['mother_name'] = Variable<String>(motherName);
    if (!nullToAbsent || motherNamePhonetic != null) {
      map['mother_name_phonetic'] = Variable<String>(motherNamePhonetic);
    }
    if (!nullToAbsent || motherAge != null) {
      map['mother_age'] = Variable<int>(motherAge);
    }
    if (!nullToAbsent || mothersMobile != null) {
      map['mothers_mobile'] = Variable<String>(mothersMobile);
    }
    if (!nullToAbsent || fatherName != null) {
      map['father_name'] = Variable<String>(fatherName);
    }
    if (!nullToAbsent || fatherMobile != null) {
      map['father_mobile'] = Variable<String>(fatherMobile);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || mctsOrRchId != null) {
      map['mcts_or_rch_id'] = Variable<String>(mctsOrRchId);
    }
    if (!nullToAbsent || lmp != null) {
      map['lmp'] = Variable<DateTime>(lmp);
    }
    if (!nullToAbsent || edd != null) {
      map['edd'] = Variable<DateTime>(edd);
    }
    {
      final converter = $MCPCardsTable.$converterhealthIssues;
      map['health_issues'] = Variable<String>(converter.toSql(healthIssues));
    }
    if (!nullToAbsent || hemoglobin != null) {
      map['hemoglobin'] = Variable<double>(hemoglobin);
    }
    if (!nullToAbsent || sBp != null) {
      map['s_bp'] = Variable<int>(sBp);
    }
    if (!nullToAbsent || dBp != null) {
      map['d_bp'] = Variable<int>(dBp);
    }
    if (!nullToAbsent || bankName != null) {
      map['bank_name'] = Variable<String>(bankName);
    }
    if (!nullToAbsent || branchName != null) {
      map['branch_name'] = Variable<String>(branchName);
    }
    if (!nullToAbsent || accountNumber != null) {
      map['account_number'] = Variable<String>(accountNumber);
    }
    if (!nullToAbsent || ifscCode != null) {
      map['ifsc_code'] = Variable<String>(ifscCode);
    }
    return map;
  }

  MCPCardsCompanion toCompanion(bool nullToAbsent) {
    return MCPCardsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      motherName: Value(motherName),
      motherNamePhonetic: motherNamePhonetic == null && nullToAbsent
          ? const Value.absent()
          : Value(motherNamePhonetic),
      motherAge: motherAge == null && nullToAbsent
          ? const Value.absent()
          : Value(motherAge),
      mothersMobile: mothersMobile == null && nullToAbsent
          ? const Value.absent()
          : Value(mothersMobile),
      fatherName: fatherName == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherName),
      fatherMobile: fatherMobile == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherMobile),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      mctsOrRchId: mctsOrRchId == null && nullToAbsent
          ? const Value.absent()
          : Value(mctsOrRchId),
      lmp: lmp == null && nullToAbsent ? const Value.absent() : Value(lmp),
      edd: edd == null && nullToAbsent ? const Value.absent() : Value(edd),
      healthIssues: Value(healthIssues),
      hemoglobin: hemoglobin == null && nullToAbsent
          ? const Value.absent()
          : Value(hemoglobin),
      sBp: sBp == null && nullToAbsent ? const Value.absent() : Value(sBp),
      dBp: dBp == null && nullToAbsent ? const Value.absent() : Value(dBp),
      bankName: bankName == null && nullToAbsent
          ? const Value.absent()
          : Value(bankName),
      branchName: branchName == null && nullToAbsent
          ? const Value.absent()
          : Value(branchName),
      accountNumber: accountNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(accountNumber),
      ifscCode: ifscCode == null && nullToAbsent
          ? const Value.absent()
          : Value(ifscCode),
    );
  }

  factory MCPCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MCPCard(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      motherName: serializer.fromJson<String>(json['motherName']),
      motherNamePhonetic:
          serializer.fromJson<String?>(json['motherNamePhonetic']),
      motherAge: serializer.fromJson<int?>(json['motherAge']),
      mothersMobile: serializer.fromJson<String?>(json['mothersMobile']),
      fatherName: serializer.fromJson<String?>(json['fatherName']),
      fatherMobile: serializer.fromJson<String?>(json['fatherMobile']),
      address: serializer.fromJson<String?>(json['address']),
      mctsOrRchId: serializer.fromJson<String?>(json['mctsOrRchId']),
      lmp: serializer.fromJson<DateTime?>(json['lmp']),
      edd: serializer.fromJson<DateTime?>(json['edd']),
      healthIssues: serializer.fromJson<List<String>>(json['healthIssues']),
      hemoglobin: serializer.fromJson<double?>(json['hemoglobin']),
      sBp: serializer.fromJson<int?>(json['sBp']),
      dBp: serializer.fromJson<int?>(json['dBp']),
      bankName: serializer.fromJson<String?>(json['bankName']),
      branchName: serializer.fromJson<String?>(json['branchName']),
      accountNumber: serializer.fromJson<String?>(json['accountNumber']),
      ifscCode: serializer.fromJson<String?>(json['ifscCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'motherName': serializer.toJson<String>(motherName),
      'motherNamePhonetic': serializer.toJson<String?>(motherNamePhonetic),
      'motherAge': serializer.toJson<int?>(motherAge),
      'mothersMobile': serializer.toJson<String?>(mothersMobile),
      'fatherName': serializer.toJson<String?>(fatherName),
      'fatherMobile': serializer.toJson<String?>(fatherMobile),
      'address': serializer.toJson<String?>(address),
      'mctsOrRchId': serializer.toJson<String?>(mctsOrRchId),
      'lmp': serializer.toJson<DateTime?>(lmp),
      'edd': serializer.toJson<DateTime?>(edd),
      'healthIssues': serializer.toJson<List<String>>(healthIssues),
      'hemoglobin': serializer.toJson<double?>(hemoglobin),
      'sBp': serializer.toJson<int?>(sBp),
      'dBp': serializer.toJson<int?>(dBp),
      'bankName': serializer.toJson<String?>(bankName),
      'branchName': serializer.toJson<String?>(branchName),
      'accountNumber': serializer.toJson<String?>(accountNumber),
      'ifscCode': serializer.toJson<String?>(ifscCode),
    };
  }

  MCPCard copyWith(
          {int? id,
          DateTime? createdAt,
          String? motherName,
          Value<String?> motherNamePhonetic = const Value.absent(),
          Value<int?> motherAge = const Value.absent(),
          Value<String?> mothersMobile = const Value.absent(),
          Value<String?> fatherName = const Value.absent(),
          Value<String?> fatherMobile = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> mctsOrRchId = const Value.absent(),
          Value<DateTime?> lmp = const Value.absent(),
          Value<DateTime?> edd = const Value.absent(),
          List<String>? healthIssues,
          Value<double?> hemoglobin = const Value.absent(),
          Value<int?> sBp = const Value.absent(),
          Value<int?> dBp = const Value.absent(),
          Value<String?> bankName = const Value.absent(),
          Value<String?> branchName = const Value.absent(),
          Value<String?> accountNumber = const Value.absent(),
          Value<String?> ifscCode = const Value.absent()}) =>
      MCPCard(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        motherName: motherName ?? this.motherName,
        motherNamePhonetic: motherNamePhonetic.present
            ? motherNamePhonetic.value
            : this.motherNamePhonetic,
        motherAge: motherAge.present ? motherAge.value : this.motherAge,
        mothersMobile:
            mothersMobile.present ? mothersMobile.value : this.mothersMobile,
        fatherName: fatherName.present ? fatherName.value : this.fatherName,
        fatherMobile:
            fatherMobile.present ? fatherMobile.value : this.fatherMobile,
        address: address.present ? address.value : this.address,
        mctsOrRchId: mctsOrRchId.present ? mctsOrRchId.value : this.mctsOrRchId,
        lmp: lmp.present ? lmp.value : this.lmp,
        edd: edd.present ? edd.value : this.edd,
        healthIssues: healthIssues ?? this.healthIssues,
        hemoglobin: hemoglobin.present ? hemoglobin.value : this.hemoglobin,
        sBp: sBp.present ? sBp.value : this.sBp,
        dBp: dBp.present ? dBp.value : this.dBp,
        bankName: bankName.present ? bankName.value : this.bankName,
        branchName: branchName.present ? branchName.value : this.branchName,
        accountNumber:
            accountNumber.present ? accountNumber.value : this.accountNumber,
        ifscCode: ifscCode.present ? ifscCode.value : this.ifscCode,
      );
  @override
  String toString() {
    return (StringBuffer('MCPCard(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('motherName: $motherName, ')
          ..write('motherNamePhonetic: $motherNamePhonetic, ')
          ..write('motherAge: $motherAge, ')
          ..write('mothersMobile: $mothersMobile, ')
          ..write('fatherName: $fatherName, ')
          ..write('fatherMobile: $fatherMobile, ')
          ..write('address: $address, ')
          ..write('mctsOrRchId: $mctsOrRchId, ')
          ..write('lmp: $lmp, ')
          ..write('edd: $edd, ')
          ..write('healthIssues: $healthIssues, ')
          ..write('hemoglobin: $hemoglobin, ')
          ..write('sBp: $sBp, ')
          ..write('dBp: $dBp, ')
          ..write('bankName: $bankName, ')
          ..write('branchName: $branchName, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('ifscCode: $ifscCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      motherName,
      motherNamePhonetic,
      motherAge,
      mothersMobile,
      fatherName,
      fatherMobile,
      address,
      mctsOrRchId,
      lmp,
      edd,
      healthIssues,
      hemoglobin,
      sBp,
      dBp,
      bankName,
      branchName,
      accountNumber,
      ifscCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MCPCard &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.motherName == this.motherName &&
          other.motherNamePhonetic == this.motherNamePhonetic &&
          other.motherAge == this.motherAge &&
          other.mothersMobile == this.mothersMobile &&
          other.fatherName == this.fatherName &&
          other.fatherMobile == this.fatherMobile &&
          other.address == this.address &&
          other.mctsOrRchId == this.mctsOrRchId &&
          other.lmp == this.lmp &&
          other.edd == this.edd &&
          other.healthIssues == this.healthIssues &&
          other.hemoglobin == this.hemoglobin &&
          other.sBp == this.sBp &&
          other.dBp == this.dBp &&
          other.bankName == this.bankName &&
          other.branchName == this.branchName &&
          other.accountNumber == this.accountNumber &&
          other.ifscCode == this.ifscCode);
}

class MCPCardsCompanion extends UpdateCompanion<MCPCard> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> motherName;
  final Value<String?> motherNamePhonetic;
  final Value<int?> motherAge;
  final Value<String?> mothersMobile;
  final Value<String?> fatherName;
  final Value<String?> fatherMobile;
  final Value<String?> address;
  final Value<String?> mctsOrRchId;
  final Value<DateTime?> lmp;
  final Value<DateTime?> edd;
  final Value<List<String>> healthIssues;
  final Value<double?> hemoglobin;
  final Value<int?> sBp;
  final Value<int?> dBp;
  final Value<String?> bankName;
  final Value<String?> branchName;
  final Value<String?> accountNumber;
  final Value<String?> ifscCode;
  const MCPCardsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.motherName = const Value.absent(),
    this.motherNamePhonetic = const Value.absent(),
    this.motherAge = const Value.absent(),
    this.mothersMobile = const Value.absent(),
    this.fatherName = const Value.absent(),
    this.fatherMobile = const Value.absent(),
    this.address = const Value.absent(),
    this.mctsOrRchId = const Value.absent(),
    this.lmp = const Value.absent(),
    this.edd = const Value.absent(),
    this.healthIssues = const Value.absent(),
    this.hemoglobin = const Value.absent(),
    this.sBp = const Value.absent(),
    this.dBp = const Value.absent(),
    this.bankName = const Value.absent(),
    this.branchName = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.ifscCode = const Value.absent(),
  });
  MCPCardsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    required String motherName,
    this.motherNamePhonetic = const Value.absent(),
    this.motherAge = const Value.absent(),
    this.mothersMobile = const Value.absent(),
    this.fatherName = const Value.absent(),
    this.fatherMobile = const Value.absent(),
    this.address = const Value.absent(),
    this.mctsOrRchId = const Value.absent(),
    this.lmp = const Value.absent(),
    this.edd = const Value.absent(),
    this.healthIssues = const Value.absent(),
    this.hemoglobin = const Value.absent(),
    this.sBp = const Value.absent(),
    this.dBp = const Value.absent(),
    this.bankName = const Value.absent(),
    this.branchName = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.ifscCode = const Value.absent(),
  })  : createdAt = Value(createdAt),
        motherName = Value(motherName);
  static Insertable<MCPCard> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? motherName,
    Expression<String>? motherNamePhonetic,
    Expression<int>? motherAge,
    Expression<String>? mothersMobile,
    Expression<String>? fatherName,
    Expression<String>? fatherMobile,
    Expression<String>? address,
    Expression<String>? mctsOrRchId,
    Expression<DateTime>? lmp,
    Expression<DateTime>? edd,
    Expression<String>? healthIssues,
    Expression<double>? hemoglobin,
    Expression<int>? sBp,
    Expression<int>? dBp,
    Expression<String>? bankName,
    Expression<String>? branchName,
    Expression<String>? accountNumber,
    Expression<String>? ifscCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (motherName != null) 'mother_name': motherName,
      if (motherNamePhonetic != null)
        'mother_name_phonetic': motherNamePhonetic,
      if (motherAge != null) 'mother_age': motherAge,
      if (mothersMobile != null) 'mothers_mobile': mothersMobile,
      if (fatherName != null) 'father_name': fatherName,
      if (fatherMobile != null) 'father_mobile': fatherMobile,
      if (address != null) 'address': address,
      if (mctsOrRchId != null) 'mcts_or_rch_id': mctsOrRchId,
      if (lmp != null) 'lmp': lmp,
      if (edd != null) 'edd': edd,
      if (healthIssues != null) 'health_issues': healthIssues,
      if (hemoglobin != null) 'hemoglobin': hemoglobin,
      if (sBp != null) 's_bp': sBp,
      if (dBp != null) 'd_bp': dBp,
      if (bankName != null) 'bank_name': bankName,
      if (branchName != null) 'branch_name': branchName,
      if (accountNumber != null) 'account_number': accountNumber,
      if (ifscCode != null) 'ifsc_code': ifscCode,
    });
  }

  MCPCardsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? createdAt,
      Value<String>? motherName,
      Value<String?>? motherNamePhonetic,
      Value<int?>? motherAge,
      Value<String?>? mothersMobile,
      Value<String?>? fatherName,
      Value<String?>? fatherMobile,
      Value<String?>? address,
      Value<String?>? mctsOrRchId,
      Value<DateTime?>? lmp,
      Value<DateTime?>? edd,
      Value<List<String>>? healthIssues,
      Value<double?>? hemoglobin,
      Value<int?>? sBp,
      Value<int?>? dBp,
      Value<String?>? bankName,
      Value<String?>? branchName,
      Value<String?>? accountNumber,
      Value<String?>? ifscCode}) {
    return MCPCardsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      motherName: motherName ?? this.motherName,
      motherNamePhonetic: motherNamePhonetic ?? this.motherNamePhonetic,
      motherAge: motherAge ?? this.motherAge,
      mothersMobile: mothersMobile ?? this.mothersMobile,
      fatherName: fatherName ?? this.fatherName,
      fatherMobile: fatherMobile ?? this.fatherMobile,
      address: address ?? this.address,
      mctsOrRchId: mctsOrRchId ?? this.mctsOrRchId,
      lmp: lmp ?? this.lmp,
      edd: edd ?? this.edd,
      healthIssues: healthIssues ?? this.healthIssues,
      hemoglobin: hemoglobin ?? this.hemoglobin,
      sBp: sBp ?? this.sBp,
      dBp: dBp ?? this.dBp,
      bankName: bankName ?? this.bankName,
      branchName: branchName ?? this.branchName,
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (motherName.present) {
      map['mother_name'] = Variable<String>(motherName.value);
    }
    if (motherNamePhonetic.present) {
      map['mother_name_phonetic'] = Variable<String>(motherNamePhonetic.value);
    }
    if (motherAge.present) {
      map['mother_age'] = Variable<int>(motherAge.value);
    }
    if (mothersMobile.present) {
      map['mothers_mobile'] = Variable<String>(mothersMobile.value);
    }
    if (fatherName.present) {
      map['father_name'] = Variable<String>(fatherName.value);
    }
    if (fatherMobile.present) {
      map['father_mobile'] = Variable<String>(fatherMobile.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (mctsOrRchId.present) {
      map['mcts_or_rch_id'] = Variable<String>(mctsOrRchId.value);
    }
    if (lmp.present) {
      map['lmp'] = Variable<DateTime>(lmp.value);
    }
    if (edd.present) {
      map['edd'] = Variable<DateTime>(edd.value);
    }
    if (healthIssues.present) {
      final converter = $MCPCardsTable.$converterhealthIssues;
      map['health_issues'] =
          Variable<String>(converter.toSql(healthIssues.value));
    }
    if (hemoglobin.present) {
      map['hemoglobin'] = Variable<double>(hemoglobin.value);
    }
    if (sBp.present) {
      map['s_bp'] = Variable<int>(sBp.value);
    }
    if (dBp.present) {
      map['d_bp'] = Variable<int>(dBp.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (accountNumber.present) {
      map['account_number'] = Variable<String>(accountNumber.value);
    }
    if (ifscCode.present) {
      map['ifsc_code'] = Variable<String>(ifscCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MCPCardsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('motherName: $motherName, ')
          ..write('motherNamePhonetic: $motherNamePhonetic, ')
          ..write('motherAge: $motherAge, ')
          ..write('mothersMobile: $mothersMobile, ')
          ..write('fatherName: $fatherName, ')
          ..write('fatherMobile: $fatherMobile, ')
          ..write('address: $address, ')
          ..write('mctsOrRchId: $mctsOrRchId, ')
          ..write('lmp: $lmp, ')
          ..write('edd: $edd, ')
          ..write('healthIssues: $healthIssues, ')
          ..write('hemoglobin: $hemoglobin, ')
          ..write('sBp: $sBp, ')
          ..write('dBp: $dBp, ')
          ..write('bankName: $bankName, ')
          ..write('branchName: $branchName, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('ifscCode: $ifscCode')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $MCPCardsTable mCPCards = $MCPCardsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mCPCards];
}
