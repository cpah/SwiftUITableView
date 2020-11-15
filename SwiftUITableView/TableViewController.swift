//
//  TableViewController.swift
//  SwiftUITableView
//
//  Created by cpahull on 15/11/2020.
//

import Cocoa
import SwiftUI

class TableViewController: NSViewController {
    
    var names: [[String]]?

    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do view setup here.
    }
    
}

extension TableViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return names?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result: NSTableCellView
        result = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        result.textField?.stringValue = names?[row][Int((tableColumn?.identifier.rawValue)!)!] ?? "None"
        return result
    }
    
    func getNames(myNames: [[String]]) -> Void {
        names = myNames
        tableView.reloadData()
    }
}

