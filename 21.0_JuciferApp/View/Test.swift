import SwiftUI

struct ContentView1: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                VStack{
                    Text("text one")
                }
            } label: {
                Text("Navigaton Link1")
                Image(systemName: "person.fill")
            }

        }
    }
}

struct DestinationView: View {
    var body: some View {
        Text("This is the destination view!")
    }
}
struct previP:PreviewProvider{
    static var previews: some View{
        ContentView1()
    }
}
