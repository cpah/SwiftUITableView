//
//  ContentView.swift
//  SwiftUITableView
//
//  Created by cpahull on 14/11/2020.
//

import Foundation
import SwiftUI
import AppKit

class PayeeNode: NSObject, Identifiable {
    @objc var id = UUID()
    @objc var name: String
    @objc var cleared: Bool
    
    init(name: String, cleared: Bool) {
        self.name = name
        self.cleared = cleared
    }
}

struct ContentView: View {
        
    @State private var payeeNodes = [PayeeNode]()
    @State private var rowSelected = -1
    @State private var selectedName = ""
    @State private var selectedRef: UUID? = nil
    @State private var selectedCleared = false
    
    var body: some View {
        HSplitView { // Placing top level view inside a SplitView prevents this runtime warning: SwiftUITableView[9921:321879] [General] ERROR: Setting <_TtC7SwiftUIP33_9FEBA96B0BC70E1682E82D239F242E7319SwiftUIAppKitButton: 0x7fd4bd919d60> as the first responder for window <NSWindow: 0x7fd4bd904db0>, but it is in a different window ((null))! This would eventually crash when the view is freed. The first responder will be set to nil.
            VStack {
                HStack {
                    Button("Clear") {
                        payeeNodes.removeAll()
                        rowSelected = -1
                    }
                    .disabled(payeeNodes.count == 0)
                    Button("Populate") { // reloads payeenodes and preselects last item
                        payeeNodes = getpayeeNodes()
                        rowSelected = payeeNodes.count - 1
                        selectedRef = payeeNodes[rowSelected].id
                        selectedName = payeeNodes[rowSelected].name
                        selectedCleared = payeeNodes[rowSelected].cleared
                    }
                    .disabled(payeeNodes.count > 0)
                    Button("Delete") {
                        payeeNodes.remove(at: rowSelected)
                        rowSelected = -1
                    }
                    .disabled(rowSelected == -1)
                }
                TableVC(payeeNodes: $payeeNodes, rowSelected: $rowSelected, selectedName: $selectedName, selectedCleared: $selectedCleared)
                    .frame(minWidth: 450, minHeight: 200)
                    .onAppear(perform: {
                        payeeNodes = getpayeeNodes()
                    })
                HStack {
                    if rowSelected >= 0 {
                        Text(selectedName)
                        Text(payeeNodes[rowSelected].id.uuidString)
                        Text(selectedCleared == true ? "True":"False")
                    }
                    else {
                        Text("None")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct TableVC: NSViewControllerRepresentable {
    
    @Binding var payeeNodes: [PayeeNode]
    @Binding var rowSelected: Int
    @Binding var selectedName: String
    @Binding var selectedCleared: Bool
    
    func makeNSViewController(context: Context) -> NSViewController {
        let tableVC = TableViewController()
        return tableVC
    }
        
    func updateNSViewController(_ nsViewController: NSViewController, context: Context) {
        guard let tableVC = nsViewController as? TableViewController else {return}
        tableVC.setContents(payeeNodes: payeeNodes)
        tableVC.tableView?.delegate = context.coordinator
        guard rowSelected >= 0 else {
            tableVC.arrayController.removeSelectionIndexes([0])
            return
        }
        tableVC.arrayController.setSelectionIndex(rowSelected)
        tableVC.tableView.scrollRowToVisible(rowSelected)
    }
    
    class Coordinator: NSObject, NSTableViewDelegate {
        
        var parent: TableVC
        
        init(_ parent: TableVC) {
            self.parent = parent
        }
        
        func tableViewSelectionDidChange(_ notification: Notification) {
            guard let tableView = notification.object as? NSTableView else {return}
            guard self.parent.payeeNodes.count > 0 else {return}
            guard tableView.selectedRow >= 0 else {
                self.parent.rowSelected = -1
                return
            }
            self.parent.rowSelected = tableView.selectedRow
            self.parent.selectedName = self.parent.payeeNodes[tableView.selectedRow].name
            self.parent.selectedCleared = self.parent.payeeNodes[tableView.selectedRow].cleared
        }

        @IBAction func nameCellEdited(_ sender: Any) {
            guard let textView = sender as? NSTextField else {return}
            self.parent.selectedName = textView.stringValue
        }
        
        @IBAction func clearedCellToggled(_ sender: Any) {
            guard self.parent.rowSelected >= 0 else {return}
            self.parent.selectedCleared = self.parent.payeeNodes[self.parent.rowSelected].cleared
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

func getpayeeNodes() -> [PayeeNode] {
    return [
        PayeeNode(name: "Alpha", cleared: false),
        PayeeNode(name: "Bravo", cleared: false),
        PayeeNode(name: "Charlie", cleared: false),
        PayeeNode(name: "Delta", cleared: false),
        PayeeNode(name: "Echo", cleared: false),
        PayeeNode(name: "Foxtrot", cleared: false),
        PayeeNode(name: "Golf", cleared: false),
        PayeeNode(name: "Hotel", cleared: false),
        PayeeNode(name: "India", cleared: false),
        PayeeNode(name: "Juliet", cleared: false),
        PayeeNode(name: "Kilo", cleared: false),
        PayeeNode(name: "Lima", cleared: false),
        PayeeNode(name: "Mike", cleared: true),
        PayeeNode(name: "November", cleared: false),
        PayeeNode(name: "Oscar", cleared: false),
        PayeeNode(name: "Papa", cleared: false),
        PayeeNode(name: "Quebec", cleared: false),
        PayeeNode(name: "Romeo", cleared: false),
        PayeeNode(name: "Sierra", cleared: false),
        PayeeNode(name: "Tango", cleared: false),
        PayeeNode(name: "Uniform", cleared: false),
        PayeeNode(name: "Victor", cleared: false),
        PayeeNode(name: "Whiskey", cleared: false),
        PayeeNode(name: "X-Ray", cleared: false),
        PayeeNode(name: "Yankee", cleared: false),
        PayeeNode(name: "Zulu", cleared: false)
    ]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
