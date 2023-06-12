//
//  ContentView.swift
//  scheduleApp
//
//  Created by TakuyaAsaoka on 2023/06/12.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Schedule.entity(),
        sortDescriptors: [NSSortDescriptor(key: "scheduledAt", ascending: true)],
        animation: .default)
    private var fetchedScheduleList: FetchedResults<Schedule>

    var body: some View {
        NavigationView {
            List {
                ForEach(fetchedScheduleList) { schedule in
                    NavigationLink {
                        Text("Schedule at \(schedule.title)")
                            .font(.title)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            // .lineLimit(1)
                      Text("Content at \(schedule.content)")
                        .font(Font.body)
                    } label: {
                         NavigationLink {
                            Text("createdAt at \(schedule.createdAt)")
                                // .lineLimit(1)
                         } label: {
                            Text("scheduledAt at \(schedule.scheduledAt)")
                                // .lineLimit(2)
                         }
                    }
                }
//                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
