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
    @State private var selectedName = ""
    @State private var selectedRef: UUID? = nil
    @State private var initialRef: UUID? = nil
    @State private var selectedCleared = ""
    
    var body: some View {
        HSplitView {
            VStack {
                HStack {
                    Button("Populate") {
                        payeeNodes = getpayeeNodes()
                        initialRef = nil
                    }
                    .disabled(payeeNodes.count > 0)
                    Button("Clear") {
                        payeeNodes.removeAll()
                        initialRef = nil
                    }
                    .disabled(payeeNodes.count == 0)
                    Button("Delete") {
                        payeeNodes.remove(at: getRowForSelectedRef(selectedRef: selectedRef))
                        initialRef = nil
                    }
                    .disabled(selectedRef == nil)
                }
                TableVC(payeeNodes: $payeeNodes, initialRef: $initialRef)
                    .frame(minWidth: 450, minHeight: 200)
                    .onReceive(newPayeeNodeSelected, perform: {notification in
                        if let newSelectedPayeeNode = notification { //as? [Int:PayeeNode?] {
                            for (_, selectedPayeeNode) in newSelectedPayeeNode {
                                let payeeNodeSelected = selectedPayeeNode as? PayeeNode
                                selectedName = payeeNodeSelected?.name ?? ""
                                selectedRef = payeeNodeSelected?.id ?? nil
                                if payeeNodeSelected != nil {
                                selectedCleared = payeeNodeSelected?.cleared == true ? "True":"False"
                                } else {
                                    selectedCleared = ""
                                }
                            }
                        }
                    })
                    .onReceive(payeeNodeEdited, perform: { _ in
                        if selectedRef == nil {return}
                        selectedName =  payeeNodes[getRowForSelectedRef(selectedRef: selectedRef)].name
                    })
                    .onReceive(clearedCellToggled, perform: { _ in
                        if selectedRef == nil {return}
                        selectedCleared =  payeeNodes[getRowForSelectedRef(selectedRef: selectedRef)].cleared == true ? "True":"False"
                    })
                    .onAppear(perform: {
                        payeeNodes = getpayeeNodes()
                        //initialRef = payeeNodes[payeeNodes.count - 1].id
                    })
                HStack {
                    HStack {
                        Text(selectedName)
                        Text(selectedRef?.uuidString ?? "Nil")
                        Text(selectedCleared)
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
    @Binding var initialRef: UUID?
    
    typealias NSViewControllerType = TableViewController
    
    func makeNSViewController(context: NSViewControllerRepresentableContext<TableVC>) -> TableViewController {
        let tableVC = TableViewController()
        return tableVC
    }
        
    func updateNSViewController(_ nsViewController: TableViewController, context: NSViewControllerRepresentableContext<TableVC>) {
        nsViewController.setContents(payeeNodes: payeeNodes)
        if initialRef != nil {
            let initialIndex = getRowForSelectedRef(selectedRef: initialRef)
            nsViewController.arrayController.setSelectionIndex(initialIndex)
            nsViewController.tableView.scrollRowToVisible(initialIndex)
        }
    }
    
    func getRowForSelectedRef(selectedRef: UUID?) -> Int {
        if selectedRef != nil {
            for i in 0 ..< payeeNodes.count {
                if payeeNodes[i].id == selectedRef {
                    return i
                }
            }
        }
        return -1
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

extension ContentView {
    
    func getRowForSelectedRef(selectedRef: UUID?) -> Int {
        if selectedRef != nil {
            for i in 0 ..< payeeNodes.count {
                if payeeNodes[i].id == selectedRef {
                    return i
                }
            }
        }
        return -1
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
