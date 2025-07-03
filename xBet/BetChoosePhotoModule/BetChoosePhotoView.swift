import SwiftUI
import PhotosUI

struct BetChoosePhotoView: View {
    @StateObject var betChoosePhotoModel = BetChoosePhotoViewModel()
    let grid = [GridItem(.flexible(), spacing: -20),
                GridItem(.flexible(), spacing: -20),
                GridItem(.flexible(), spacing: -20)]
    
    @State private var selectedIndex: Int? = nil
    @State private var showingPhotoPicker = false
    @State private var pickedImage: UIImage? = nil
    
    var body: some View {
        ZStack {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            
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
                                            .stroke(selectedIndex == index ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color.clear, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        selectedIndex = index
                                    }
                                
                                if selectedIndex == index {
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
    }
}


#Preview {
    BetChoosePhotoView()
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        if let uiImage = image as? UIImage {
                            self.parent.selectedImage = uiImage
                        }
                    }
                }
            }
        }
    }
}
