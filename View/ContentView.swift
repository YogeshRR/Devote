//
//  ContentView.swift
//  Devote
//
//  Created by Yogesh Raut on 27/12/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - PROPERTIES
    @State var task : String = ""
    
    private var isDisabled : Bool {
        task.isEmpty
    }
    // CREATED SCRATCH PAD to manage or to interact with container and context.
    @Environment(\.managedObjectContext) private var viewContext
    
    
    
    // FETECHING DATA.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK: - FUNCTIONS
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.id = UUID()
            newItem.task = task
            newItem.completion = false
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack(spacing: 16) {
                        TextField("New Task", text: $task)
                            .padding()
                            .background(
                                Color(UIColor.systemGray6)
                            ).cornerRadius(10)
                        
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Container@*/VStack/*@END_MENU_TOKEN@*/ {
                            Button(action: {
                                addItem()
                            }, label: {
                                Spacer()
                                Text("Save")
                                    .frame(height: 50)
                                    .cornerRadius(10)
                                Spacer()
                            })
                            .disabled(isDisabled)
                            .background(isDisabled ? Color.gray : Color.pink)
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                        }
                        
                    } // :- VSTACK
                    .padding()
                    
                    List {
                        ForEach(items) { item in
                            
                            VStack(alignment: .leading) {
                                Text(item.task ?? "")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        .onDelete(perform: deleteItems)
                    } // :- LIST
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.35), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                } // :- VSTACK
            } // :- ZSTACK
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.blue
            }
            
            .navigationBarTitle("Daily Task", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                
            }
            .background(
                BackgroundImageView()
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
            .scrollContentBackground(.hidden)
            
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
    
}
