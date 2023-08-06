class TablePrinter {
  List<List<String>> table;
  late List<int> columnWidths;

  TablePrinter(this.table) {
    columnWidths = List.filled(table[0].length, 0);
    _calculateColumnWidths();
  }

  void _calculateColumnWidths() {
    for (List<String> row in table) {
      for (int i = 0; i < row.length; i++) {
        if (row[i].length > columnWidths[i]) {
          columnWidths[i] = row[i].length;
        }
      }
    }
  }

  void _printHorizontalLine() {
    print("+${columnWidths.map((width) => '-' * (width + 2)).join('+')}+");
  }

  void _printRow(List<String> row) {
    String rowString = row.asMap().entries.map((entry) {
      int index = entry.key;
      String cell = entry.value;
      return cell.padRight(columnWidths[index] + 2);
    }).join('|');

    print("|$rowString|");
  }

  void printTable() {
    if (table.isEmpty) {
      print("Table is empty.");
      return;
    }

    _printHorizontalLine();
    _printRow(table[0]);
    _printHorizontalLine();

    for (int i = 1; i < table.length; i++) {
      _printRow(table[i]);
    }

    _printHorizontalLine();
  }
}

void main() {
  List<List<String>> myTable = [
    ['Name', 'Age', 'Gender'],
    ['Raghavendra', '20 Years', 'Male'],
    ['Rachana', '18 Years', 'Female'],
  ];

  TablePrinter tablePrinter = TablePrinter(myTable);
  tablePrinter.printTable();
}
