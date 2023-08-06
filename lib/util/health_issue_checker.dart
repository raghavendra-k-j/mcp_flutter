import 'package:mcp_app/database/data.dart';

class HealthIssueChecker {

  static const int lowSystolicBpThreshold = 90;
  static const int lowDiastolicBpThreshold = 60;
  static const int highSystolicBpThreshold = 140;
  static const int highDiastolicBpThreshold = 90;
  static const double lowHbLevelThreshold = 11.0;
  static const double highHbLevelThreshold = 17.5;

  static bool hasLowBp(int? sBp, int? dBp) {
    return sBp != null && dBp != null && (sBp <= lowSystolicBpThreshold || dBp <= lowDiastolicBpThreshold);
  }

  static bool hasHighBp(int? sBp, int? dBp) {
    return sBp != null && dBp != null && (sBp >= highSystolicBpThreshold || dBp >= highDiastolicBpThreshold);
  }

  static bool hasLowBpForPerson(MCPCard mcpCard) {
    return hasLowBp(mcpCard.sBp, mcpCard.dBp);
  }

  static bool hasHighBpForPerson(MCPCard mcpCard) {
    return hasHighBp(mcpCard.sBp, mcpCard.dBp);
  }

  static bool hasHbLevelIssue(double? hbLevel) {
    return hbLevel != null && (hbLevel <= lowHbLevelThreshold || hbLevel >= highHbLevelThreshold);
  }

  static bool hasHealthIssuesList(MCPCard mcpCard) {
    return mcpCard.healthIssues.isNotEmpty;
  }

  static bool hasBPIssue(MCPCard mcpCard) {
    return hasLowBpForPerson(mcpCard) || hasHighBpForPerson(mcpCard);
  }

  static bool hasComplications(MCPCard mcpCard) {
    return hasBPIssue(mcpCard) ||  hasHbLevelIssue(mcpCard.hemoglobin) || hasHealthIssuesList(mcpCard);
  }

}
