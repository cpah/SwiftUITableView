//
//  ContentView.swift
//  SwiftUITableView
//
//  Created by cpahull on 14/11/2020.
//

import Foundation
import SwiftUI
import AppKit

struct PayeeName: Identifiable {
    var id = UUID()
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct ContentView: View {
    
    @State private var payeeNames = [PayeeName]()
    @State private var selectedRow = -1
    @State private var selectedRef: UUID? = nil
    
    var body: some View {
        VStack {
            HStack {
                Button("Populate") {
                    payeeNames = getPayeeNames()
                    selectedRow = payeeNames.count - 1
                    //selectedRow = -1
                }
                Button("Clear") {
                    payeeNames.removeAll()
                }
            }
            TableVC(payeeNames: $payeeNames, selectedRow: $selectedRow)
                .frame(minWidth: 450, minHeight: 200)
                .onReceive(newRowSelected, perform: {notification in
                    if let newRowSelected = notification as [String:Int]? {
                        for (_, rowSelected) in newRowSelected {selectedRow = rowSelected}
                        selectedRef = payeeNames[selectedRow].id
                    }
                })
                .onAppear(perform: {
                    payeeNames = getPayeeNames()
                    //selectedRow = payeeNames.count - 1
                })
            HStack {
                if payeeNames.count > 0 && selectedRow >= 0 {
                    HStack {
                        Text(payeeNames[selectedRow].name)
                        Text(selectedRef?.uuidString ?? "Nil")
                    }
                } else {
                    Text("None")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct TableVC: NSViewControllerRepresentable {
    
    @Binding var payeeNames: [PayeeName]
    @Binding var selectedRow: Int

    typealias NSViewControllerType = TableViewController
    
    func makeNSViewController(context: NSViewControllerRepresentableContext<TableVC>) -> TableViewController {
        let tableVC = TableViewController()
        return tableVC
    }
        
    func updateNSViewController(_ nsViewController: TableViewController, context: NSViewControllerRepresentableContext<TableVC>) {
        nsViewController.setContents(payeeNames: payeeNames)
        nsViewController.setSelectedRow(selectedRow: selectedRow)
        nsViewController.tableView.scrollRowToVisible(selectedRow)
        return
    }
}

func getPayeeNames() -> [PayeeName] {
    return [
        PayeeName(name: "Alpha"),
        PayeeName(name: "Bravo"),
        PayeeName(name: "Charlie"),
        PayeeName(name: "Delta"),
        PayeeName(name: "Echo"),
        PayeeName(name: "Foxtrot"),
        PayeeName(name: "Golf"),
        PayeeName(name: "Hotel"),
        PayeeName(name: "India"),
        PayeeName(name: "Juliet"),
        PayeeName(name: "Kilo"),
        PayeeName(name: "Lima"),
        PayeeName(name: "Mike"),
        PayeeName(name: "November"),
        PayeeName(name: "Oscar"),
        PayeeName(name: "Papa"),
        PayeeName(name: "Romeo"),
        PayeeName(name: "Sierra"),
        PayeeName(name: "Tango"),
        PayeeName(name: "Uniform"),
        PayeeName(name: "Victor"),
        PayeeName(name: "Whiskey"),
        PayeeName(name: "X-Ray"),
        PayeeName(name: "Yankee"),
        PayeeName(name: "Zulu")
    ]
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    func getRowForRef(ref: UUID?) -> Int {
        if ref != nil {
            for i in 0 ..< payeeNames.count {
                if payeeNames[i].id == ref {
                    return i
                }
            }
        }
        return -1
    }

}
