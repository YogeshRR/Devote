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
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    @State private var showNewTaskItem : Bool = false
    
    // CREATED SCRATCH PAD to manage or to interact with container and context.
    @Environment(\.managedObjectContext) private var viewContext
    
    
    
    // FETECHING DATA.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
   
    
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
                //MARK: - MAINVIEW
                VStack {
                    
                    //MARK: - HEADER
                    HStack(spacing : 10) {
                        //MARK: - TITLE
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        Spacer()
                        //MARK: - EDIT BUTTON
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth : 70, minHeight: 24)
                            .background(Capsule().stroke(Color.white, lineWidth: 2))
                        
                        //MARK: - APPERANCE BUTTON
                        
                        Button(action: {
                            isDarkMode.toggle()
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width : 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                        
                    } // :- HSTACK
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    //MARK: - NEW TASK BUTTON
                     
                    Button(action: {
                        showNewTaskItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                    })
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0, y: 4)
                     // :- VSTACK
                    
                    
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
                
                //MARK: - NEW TASK ITEM
                
                if showNewTaskItem {
                    BlankScreenView()
                        .onTapGesture(perform: {
                            showNewTaskItem = false
                        })
                    NewTaskItemView(isVisible: $showNewTaskItem)
                }
                 
            } // :- ZSTACK
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.blue
            }
            
            .navigationBarTitle("Daily Task", displayMode: .large)
            .navigationBarHidden(true)
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
