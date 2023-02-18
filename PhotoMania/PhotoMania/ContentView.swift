//
//  ContentView.swift
//  PhotoMania
//
//  Created by Ammar on 2023-02-17.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var image: Image?
    
    func fetchNewImage() {
        guard let url = URL(
            string: "https://random.imagecdn.app/500/500"
        ) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, _, _ in guard let data = data else { return }
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else { return }
                
                self.image = Image(uiImage: uiImage)
            }
        }
        
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                if let image = viewModel.image {
                    ZStack {
                        image
                            .resizable()
                            .foregroundColor(Color.pink)
                            .frame(width: 200, height: 200)
                            .padding()
                    }.frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                        .background(Color.green)
                        .cornerRadius(8)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(Color.pink)
                        .frame(width: 200, height: 200)
                        .padding()
                }
                Spacer()
                Button {
                    viewModel.fetchNewImage()
                } label: {
                  Text("New Image!")
                        .bold()
                        .frame(width: 250, height: 40)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(8)
                        .padding()
                }

            }.navigationTitle("Photo Mania")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
