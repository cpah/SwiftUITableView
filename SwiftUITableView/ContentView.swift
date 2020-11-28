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
    @objc dynamic var id = UUID()
    @objc dynamic var name: String
    @objc dynamic var idString: String
    
    init(name: String) {
        self.name = name
        self.idString = id.uuidString
    }
}

struct ContentView: View {
        
    @State private var payeeNodes = [PayeeNode]()
    @State private var selectedName = ""
    @State private var selectedRef: UUID? = nil
    
    var body: some View {
        VStack {
            HStack {
                Button("Populate") {
                    payeeNodes = getpayeeNodes()
                }
                Button("Clear") {
                    payeeNodes.removeAll()
                }
            }
            TableVC(payeeNodes: $payeeNodes)
                .frame(minWidth: 450, minHeight: 200)
                .onReceive(newPayeeNodeSelected, perform: {notification in
                    if let newSelectedPayeeNode = notification as [String:PayeeNode?]? {
                        for (_, selectedPayeeNode) in newSelectedPayeeNode {
                            selectedName = selectedPayeeNode?.name ?? ""
                            selectedRef = selectedPayeeNode?.id ?? nil
                        }
                    }
                })
                .onReceive(payeeNodeEdited, perform: { notification in
                    if let payeeNodeEdited = notification as [String:String]? {
                        for (_, newSelectedName) in payeeNodeEdited {
                            selectedName = newSelectedName
                        }
                    }
                })
                .onAppear(perform: {
                    //payeeNodes = getpayeeNodes()
                })
            HStack {
                HStack {
                Text(selectedName)
                Text(selectedRef?.uuidString ?? "Nil")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct TableVC: NSViewControllerRepresentable {
    
    @Binding var payeeNodes: [PayeeNode]

    typealias NSViewControllerType = TableViewController
    
    func makeNSViewController(context: NSViewControllerRepresentableContext<TableVC>) -> TableViewController {
        let tableVC = TableViewController()
        return tableVC
    }
        
    func updateNSViewController(_ nsViewController: TableViewController, context: NSViewControllerRepresentableContext<TableVC>) {
        nsViewController.setContents(payeeNodes: payeeNodes)
        return
    }
}

func getpayeeNodes() -> [PayeeNode] {
    return [
        PayeeNode(name: "Alpha"),
        PayeeNode(name: "Bravo"),
        PayeeNode(name: "Charlie"),
        PayeeNode(name: "Delta"),
        PayeeNode(name: "Echo"),
        PayeeNode(name: "Foxtrot"),
        PayeeNode(name: "Golf"),
        PayeeNode(name: "Hotel"),
        PayeeNode(name: "India"),
        PayeeNode(name: "Juliet"),
        PayeeNode(name: "Kilo"),
        PayeeNode(name: "Lima"),
        PayeeNode(name: "Mike"),
        PayeeNode(name: "November"),
        PayeeNode(name: "Oscar"),
        PayeeNode(name: "Papa"),
        PayeeNode(name: "Romeo"),
        PayeeNode(name: "Sierra"),
        PayeeNode(name: "Tango"),
        PayeeNode(name: "Uniform"),
        PayeeNode(name: "Victor"),
        PayeeNode(name: "Whiskey"),
        PayeeNode(name: "X-Ray"),
        PayeeNode(name: "Yankee"),
        PayeeNode(name: "Zulu")
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
            for i in 0 ..< payeeNodes.count {
                if payeeNodes[i].id == ref {
                    return i
                }
            }
        }
        return -1
    }

}
