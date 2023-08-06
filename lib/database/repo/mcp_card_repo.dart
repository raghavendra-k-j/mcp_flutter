import 'package:mcp_app/database/data.dart';
import 'package:mcp_app/util/exceptions.dart';
import 'package:drift/drift.dart' as drift;

class MCPCardRepo {
  MyDatabase myDatabase;

  MCPCardRepo(this.myDatabase);

  Future<MCPCard> addMCPCard({
    DateTime? createdAt,
    required String motherName,
    required int motherAge,
    String? mothersMobile,
    required String fatherName,
    String? fatherMobile,
    String? address,
    String? mctsOrRchId,
    DateTime? lmp,
    DateTime? edd,
    List<String>? healthIssues,
    double? hemoglobin,
    int? sBp,
    int? dBp,
    String? bankName,
    String? branchName,
    String? accountNumber,
    String? ifscCode,
  }) async {

    createdAt ??= DateTime.now();

    validateCreatedAt(createdAt);

    validateMotherName(motherName);
    String? motherNamePhonetic = PhoneticHelper.generatePhonetic(motherName);

    validateMotherAge(motherAge);

    validateMothersMobile(mothersMobile);
    mothersMobile = (mothersMobile != null && mothersMobile.isNotEmpty) ? mothersMobile : null;

    validateFatherName(fatherName);

    validateFatherMobile(fatherMobile);
    fatherMobile = (fatherMobile != null && fatherMobile.isNotEmpty) ? fatherMobile : null;

    validateAddress(address);
    address = (address != null && address.isNotEmpty) ? address : null;

    validateLMPandEDD(lmp, edd);

    validateHemoglobin(hemoglobin);

    validateSBP(sBp);
    validateDBP(dBp);

    validateBankName(bankName);
    bankName = (bankName != null && bankName.isNotEmpty) ? bankName : null;

    validateBranchName(branchName);
    branchName = (branchName != null && branchName.isNotEmpty) ? branchName : null;

    validateIFSCCode(ifscCode);
    ifscCode = (ifscCode != null && ifscCode.isNotEmpty) ? ifscCode : null;

    validateAccountNumber(accountNumber);
    accountNumber = (accountNumber != null && accountNumber.isNotEmpty) ? accountNumber : null;

    MCPCardsCompanion mcpCardsCompanion = MCPCardsCompanion.insert(
      createdAt: createdAt,
      motherName: motherName,
      motherNamePhonetic: drift.Value(motherNamePhonetic),
      motherAge: drift.Value(motherAge),
      mothersMobile: drift.Value(mothersMobile),
      fatherName: drift.Value(fatherName),
      fatherMobile: drift.Value(fatherMobile),
      address: drift.Value(address),
      lmp: drift.Value(lmp),
      edd: drift.Value(edd),
      healthIssues: drift.Value(healthIssues ?? []),
      hemoglobin: drift.Value(hemoglobin),
      sBp: drift.Value(sBp),
      dBp: drift.Value(dBp),
      bankName: drift.Value(bankName),
      branchName: drift.Value(branchName),
      accountNumber: drift.Value(accountNumber),
      ifscCode: drift.Value(ifscCode),
    );

    MCPCard mcpCard = await myDatabase
        .into(myDatabase.mCPCards)
        .insertReturning(mcpCardsCompanion);
    String mchOrRchId = "MCPC${mcpCard.id.toString().padLeft(4, '0')}";
    myDatabase
        .update(myDatabase.mCPCards)
        .where((tbl) => tbl.id.equals(mcpCard.id));
    (myDatabase.update(myDatabase.mCPCards)
      ..where((t) => t.id.equals(mcpCard.id)))
        .write(MCPCardsCompanion(
      mctsOrRchId: drift.Value(mchOrRchId),
    ));

    var queryBuilder = myDatabase.select(myDatabase.mCPCards);
    queryBuilder.where((tbl) => tbl.id.equals(mcpCard.id));
    return queryBuilder.getSingle();
  }

  void validateCreatedAt(DateTime? createdAt) {
    if (createdAt != null && createdAt.isAfter(DateTime.now())) {
      throw FormException(
          "Invalid createdAt date. The creation date cannot be in the future.");
    }
  }

  void validateMotherName(String motherName) {
    if (motherName.isEmpty) throw FormException("Wife name is required");
    if (motherName.length < 3) {
      throw FormException("Please enter a valid wife name");
    }
    if (motherName.length > 30) {
      throw FormException("Wife name must be less than 30 characters");
    }
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(motherName)) {
      throw FormException(
          "Wife name can only contain letters (a-z, A-Z) and spaces");
    }
  }

  void validateMotherAge(int motherAge) {
    if (motherAge < 18) {
      throw FormException("Wife age must be greater than or equal to 18");
    }
    if (motherAge > 50) {
      throw FormException("Wife age must be less than or equal to 50");
    }
  }

  void validateMothersMobile(String? mothersMobile) {
    if (mothersMobile != null && mothersMobile.isNotEmpty) {
      final RegExp mobileRegExp = RegExp(r'^[0-9]+$');
      if (!mobileRegExp.hasMatch(mothersMobile) || mothersMobile.length != 10) {
        throw FormException("Invalid wife's mobile number. Please enter a 10-digit mobile number.");
      }
    }
  }

  void validateFatherName(String fatherName) {
    if (fatherName.isEmpty) throw FormException("Husband name is required");
    if (fatherName.length < 3) {
      throw FormException("Please enter a valid husband name");
    }
    if (fatherName.length > 30) {
      throw FormException("Husband name must be less than 30 characters");
    }
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(fatherName)) {
      throw FormException(
          "Husband name can only contain letters (a-z, A-Z) and spaces");
    }
  }

  void validateFatherMobile(String? fatherMobile) {
    if (fatherMobile != null && fatherMobile.isNotEmpty) {
      final RegExp mobileRegExp = RegExp(r'^[0-9]+$');
      if (!mobileRegExp.hasMatch(fatherMobile) || fatherMobile.length != 10) {
        throw FormException(
            "Invalid husband's mobile number. Please enter a 10-digit mobile number.");
      }
    }
  }

  void validateAddress(String? address) {
    if (address != null && address.isNotEmpty) {
      if (address.length < 10) {
        throw FormException("Address must be at least 10 characters long");
      }
      if (address.length > 300) {
        throw FormException("Address must be less than 300 characters");
      }
    }
  }

  void validateLMPandEDD(DateTime? lmp, DateTime? edd) {
    if (lmp != null && edd != null) {
      if (lmp.isAfter(edd)) {
        throw FormException("LMP cannot be after EDD");
      }
      Duration duration = edd.difference(lmp);
      if (duration.inDays < 280) {
        throw FormException("EDD must be at least 280 days after LMP");
      }
    }
  }

  void validateHemoglobin(double? hemoglobin) {
    if (hemoglobin != null) {
      if (hemoglobin < 0 || hemoglobin > 20) {
        throw FormException(
            "Invalid hemoglobin value. Please enter a value between 0 and 20");
      }
    }
  }

  void validateSBP(int? sBp) {
    if (sBp != null) {
      if (sBp < 50 || sBp > 250) {
        throw FormException(
            "Invalid Systolic Blood Pressure value. Please enter a value between 50 and 250");
      }
    }
  }

  void validateDBP(int? dBp) {
    if (dBp != null) {
      if (dBp < 30 || dBp > 150) {
        throw FormException(
            "Invalid Diastolic Blood Pressure value. Please enter a value between 30 and 150");
      }
    }
  }

  void validateBankName(String? bankName) {
    if (bankName != null && bankName.isNotEmpty) {
      final RegExp bankNameRegExp = RegExp(r'^[A-Za-z\s]+$');
      if (!bankNameRegExp.hasMatch(bankName)) {
        throw FormException(
            "Bank name can only contain letters (a-z, A-Z) and spaces");
      }
      if (bankName.length > 60) {
        throw FormException("Bank name must be less than 60 characters");
      }
    }
  }

  void validateBranchName(String? branchName) {
    if (branchName != null && branchName.isNotEmpty) {
      final RegExp branchNameRegExp = RegExp(r'^[A-Za-z\s,]+$');
      if (!branchNameRegExp.hasMatch(branchName)) {
        throw FormException(
            "Branch name can only contain letters (a-z, A-Z), spaces, and commas");
      }
      if (branchName.length > 60) {
        throw FormException("Branch name must be less than 60 characters");
      }
    }
  }

  void validateIFSCCode(String? ifscCode) {
    if (ifscCode != null && ifscCode.isNotEmpty) {
      if (ifscCode.length != 11) {
        throw FormException(
            "Invalid IFSC code. IFSC code must be exactly 11 characters long");
      }
    }
  }

  void validateAccountNumber(String? accountNumber) {
    if (accountNumber != null && accountNumber.isNotEmpty) {
      final RegExp accountNumberRegExp = RegExp(r'^[0-9]{9,18}$');
      if (!accountNumberRegExp.hasMatch(accountNumber)) {
        throw FormException(
            "Invalid account number. Please enter a valid account number (9 to 18 digits)");
      }
    }
  }
}
