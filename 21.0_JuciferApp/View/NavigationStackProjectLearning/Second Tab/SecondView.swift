//
//  SecondView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 11/04/23.
//

import SwiftUI

struct SecondView: View {
    
    let books:[Book] = Book.examples()
    @State var selectedBookPath = [Book]()
    var body: some View {
        VStack{
            NavigationStack(path: $selectedBookPath) {
                List(books) { book in
                    NavigationLink(book.title, value: book)
                }
                .navigationDestination(for: Book.self) { book in
                    BookDestinationView(book: book)
                }
            }
            
            VStack{
                ForEach(selectedBookPath) { book in
                    Text(book.title)
                }
                
                Button("go to book.first") {
                    guard let book = books.first else {return}
                    selectedBookPath = [book]
                }
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}


struct Book:Identifiable,Hashable{
    let id:UUID
    let title:String
    
    init(title: String) {
        self.id = UUID()
        self.title = title
    }
    
    static func examples()->[Book]{
        [Book(title: "Lord of Rings"),
        Book(title: "Game of thrones"),
         Book(title: "The shining")]
    }
}
