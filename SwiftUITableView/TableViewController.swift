//
//  TableViewController.swift
//  SwiftUITableView
//
//  Created by cpahull on 15/11/2020.
//

import Cocoa
import SwiftUI

var newSelectedRow = -1 // Global var to share TableViewController.xib selectedRow with SwiftUUI
let newRowSelected = NotificationCenter.default // Notification to prompt SwiftUI to update selectedRow
    .publisher(for: Notification.Name("newRowSelected"))

class TableViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var contents: [[String]]?

    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return contents?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result: NSTableCellView
        result = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        result.textField?.stringValue = contents?[row][Int((tableColumn?.identifier.rawValue)!)!] ?? "None"
        return result
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        newSelectedRow = tableView.selectedRow
        NotificationCenter.default.post(name: Notification.Name("newRowSelected"), object: nil)
    }

    func setContents(names: [[String]]) -> Void {
        contents = names
        tableView.reloadData()
        if names.count == 0 && newSelectedRow >= 0 {
            newSelectedRow = tableView.selectedRow
            NotificationCenter.default.post(name: Notification.Name("newRowSelected"), object: nil)
        }
    }
    
    func setSelectedRow(selectedRow: Int) -> Void {
        tableView.selectRowIndexes([selectedRow], byExtendingSelection: false)
    }
    
    func getSelectedRow() -> Int {
        return tableView.selectedRow
    }
}

