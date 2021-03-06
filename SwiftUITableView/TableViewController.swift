//
//  TableViewController.swift
//  SwiftUITableView
//
//  Created by cpahull on 15/11/2020.
//

import Foundation
import Cocoa

class TableViewController: NSViewController {
    
    @objc dynamic var contents: [Item] = []

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet var arrayController: NSArrayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func nameCellEdited(_ sender: Any) {} // stub for delegate
    
    @IBAction func clearedCellToggled(_ sender: Any) {} // stub for delegate

    func setContents(items: [Item]) -> Void {
        contents = items
    }
    
}

