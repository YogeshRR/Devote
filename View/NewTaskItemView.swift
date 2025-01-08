//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Yogesh Raut on 07/01/25.
//

import SwiftUI

struct NewTaskItemView: View {
    
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext;
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    @State  var task : String = ""
    @Binding var isVisible : Bool
    
    private var isDisabled : Bool {
        task.isEmpty
    }
    
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
            isVisible = false
        }
    }
    
    //MARK: - BODY
    var body: some View {
        VStack {
            Text("Hello World")
            Spacer()
            
             VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .padding()
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .background( isDarkMode ?
                                 Color( UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    ).cornerRadius(10)
                
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Container@*/VStack/*@END_MENU_TOKEN@*/ {
                    Button(action: {
                        addItem()
                    }, label: {
                        Spacer()
                        Text("Save")
                            .frame(height: 50)
                            
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Spacer()
                    })
                    .disabled(isDisabled)
                    .background(isDisabled ? Color.blue : Color.pink)
                    .padding()
                    
                    .foregroundColor(.white)
                } // :- CONTAINER
                
            } // :- VSTACK
             .padding(.horizontal)
             .padding(.vertical, 20)
             .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
             )
             .cornerRadius(16)
             .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
             .frame(maxWidth: 640)
        } // :- VSTACK
        .padding()
    }
}
  //MARK: - PREVIEWS
struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isVisible: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
