import SwiftUI
import PhotosUI

struct BetChoosePhotoView: View {
    @StateObject var betChoosePhotoModel = BetChoosePhotoViewModel()
    let grid = [GridItem(.flexible(), spacing: -20),
                GridItem(.flexible(), spacing: -20),
                GridItem(.flexible(), spacing: -20)]
    
    @State private var showingPhotoPicker = false
    @State private var pickedImage: UIImage?

       init() {
           if let savedImage = loadImageFromUserDefaults(key: "selectedPhoto") {
               _pickedImage = State(initialValue: savedImage)
           } else {
               _pickedImage = State(initialValue: nil)
           }
       }
    
    @Environment(\.presentationMode) var presentationMode
    @State var isBack = false
    func saveImageToUserDefaults(image: UIImage, key: String) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func loadImageFromUserDefaults(key: String) -> UIImage? {
        if let data = UserDefaults.standard.data(forKey: key) {
            return UIImage(data: data)
        }
        return nil
    }

    var body: some View {
        ZStack {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            isBack = true
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 30))
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        
                        Text("Photo")
                            .ProBold(size: 24)
                            .padding(.trailing, 20)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                     
                    HStack(spacing: 20) {
                        Button(action: {
                            showingPhotoPicker = true
                        }) {
                            if let image = pickedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                            } else {
                                Image(.choosePic)
                                    .resizable()
                                    .frame(width: 120, height: 120)
                            }
                        }
                        .sheet(isPresented: $showingPhotoPicker) {
                            PhotoPicker(selectedImage: $pickedImage)
                        }
                        .onChange(of: pickedImage) { newImage in
                            if let image = newImage {
                                saveImageToUserDefaults(image: image, key: "selectedPhoto")
                            }
                        }
                        
                        Text("Upload your photo")
                            .Pro(size: 18)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Rectangle()
                        .fill(Color(red: 141/255, green: 160/255, blue: 179/255))
                        .frame(height: 0.5)
                        .padding()
                        
                    LazyVGrid(columns: grid, spacing: 30) {
                        ForEach(0..<betChoosePhotoModel.contact.arrayOfAva.count, id: \.self) { index in
                            ZStack {
                                Image(betChoosePhotoModel.contact.arrayOfAva[index])
                                    .resizable()
                                    .frame(width: 110, height: 110)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(betChoosePhotoModel.selectedIndex == index ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color.clear, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        betChoosePhotoModel.selectedIndex = index
                                        betChoosePhotoModel.changeAvatar { result in
                                            switch result {
                                            case .success():
                                                UserDefaultsManager().saveImage(betChoosePhotoModel.contact.arrayOfAva[index])
                                                UserDefaults.standard.removeObject(forKey: "selectedPhoto")
                                            case .failure(let error):
                                                print("Failed to update avatar: \(error.localizedDescription)")
                                            }
                                        }
                                    }
                                
                                if betChoosePhotoModel.selectedIndex == index {
                                    Image(.choosed)
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .offset(x: -40, y: -40)
                                }
                            }
                        }
                    }
                }
            }
            .scrollDisabled(UIScreen.main.bounds.width > 380 ? true : false)
        }
        .fullScreenCover(isPresented: $isBack) {
            BetSettingsView()
        }
    }
}



#Preview {
    BetChoosePhotoView()
}
