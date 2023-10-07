//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Adam Tokarski on 07/10/2023.
//

import SwiftUI

// 1 - Codable class with @publisher properties
//class User: ObservableObject, Codable {
//    private enum CodingKeys: CodingKey {
//        case name
//    }
//    
//    @Published var name = "Adam Tokarski"
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Creat account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
    
//    var body: some View {
// 3 - fetching image option 3
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
//            if let image = phase.image {
//                image
//                    .resizable()
//                    .scaledToFit()
//            } else if phase.error != nil {
//                Text("There was an error loading the image")
//            } else {
//                ProgressView()
//            }
//        }
//        .frame(width: 200, height: 200)
        
// 3 - fetching image option 2
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            ProgressView()
//        }
//        .frame(width: 200, height: 200)
        
// 3 - fetching image option 1
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
//    }
    
// 2 - fetching data from internet
//    @State private var results: [Result] = []
//    
//    var body: some View {
//        List(results, id: \.trackId) { item in
//            VStack(alignment: .leading) {
//                Text(item.trackName)
//                    .font(.headline)
//                
//                Text(item.collectionName)
//            }
//        }
//        .task {
//            await loadData()
//        }
//    }
//    
//    func loadData() async {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid URL")
//            return
//        }
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                results = decodedResponse.results
//            }
//        } catch {
//            print("Invalid data")
//        }
//    }
}

#Preview {
    ContentView()
}
