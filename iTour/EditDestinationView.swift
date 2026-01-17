//
//  EditDestinationView.swift
//  iTour
//
//  Created by dkc on 2026/01/17.
//

import SwiftData
import SwiftUI

struct EditDestinationView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var destination: Destination
    @State private var newSightName: String = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.detail)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Maybe").tag(1)
                    Text("Perhaps").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSight)
                
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    Button("Add", action: addSight)
                        .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
    
    func deleteSight(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight = destination.sights[index]
            destination.sights.remove(at: index)
            modelContext.delete(sight)
        }
    }
}

#Preview {
    do {
        let container = try ModelContainer(for: Destination.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let exampleDestination = Destination(name: "Tokyo", detail: "Lorem Ipsum Dollar")
        
        return EditDestinationView(destination: exampleDestination)
            .modelContainer(container)
    } catch {
        fatalError("Error: \(error.localizedDescription)")
    }
    
}
