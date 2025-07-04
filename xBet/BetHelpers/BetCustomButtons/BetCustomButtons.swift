import SwiftUI
import PhotosUI

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 24/255, green: 58/255, blue: 93/255))
                .frame(height: 57)
                .cornerRadius(12)
                .padding(.horizontal, 15)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 16)
            .frame(height: 47)
            .font(.custom("SFProDisplay-Regular", size: 15))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .Pro(size: 16, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                    .frame(height: 57)
                    .padding(.leading, 30)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}

struct CustomSecureField: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    
    @State private var isSecure: Bool = true
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 24/255, green: 58/255, blue: 93/255))
                .frame(height: 57)
                .cornerRadius(12)
                .padding(.horizontal, 15)
            
            HStack {
                if isSecure {
                    SecureField("", text: $text)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .font(.custom("SFProDisplay-Regular", size: 16))
                        .foregroundStyle(.white)
                        .focused($isTextFocused)
                } else {
                    TextField("", text: $text)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .font(.custom("SFProDisplay-Regular", size: 16))
                        .foregroundStyle(.white)
                        .focused($isTextFocused)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 57)
            .cornerRadius(9)
            .padding(.horizontal, 15)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .font(.custom("SFProDisplay-Regular", size: 16))
                    .foregroundColor(Color(red: 141/255, green: 160/255, blue: 179/255))
                    .frame(height: 57)
                    .padding(.leading, 30)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Main
        case Arena
        case Training
        case Diary
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                Rectangle()
                    .fill(Color(red: 33/255, green: 85/255, blue: 132/255))
                    .frame(height: 110)
                    .cornerRadius(30)
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: 35)
                    .shadow(color: .black.opacity(0.8), radius: 20, y: -5)
            }
            
            HStack(spacing: 0) {
                TabBarItem(imageName: "tab1", tab: .Main, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .Arena, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Training, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab4", tab: .Diary, selectedTab: $selectedTab)
            }
            .padding(.top, 10)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 5) {
                Image(selectedTab == tab ? imageName : imageName)
                    .resizable()
                    .frame(
                        width: 32,
                        height: 32
                    )
                 
        
                Text("\(tab)")
                    .Pro(
                        size: 12
                    )
            }
            .frame(maxWidth: .infinity)
            .opacity(selectedTab == tab ? 1 : 0.4)
        }
    }
}

struct CustomTextView: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var height: CGFloat = 260
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 24/255, green: 58/255, blue: 93/255))
                .cornerRadius(16)
                .padding(.horizontal)
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, 15)
                .padding(.horizontal)
                .padding(.top, 5)
                .frame(height: height)
                .font(.custom("SFProDisplay-Regular", size: 18))
                .foregroundStyle(.white)
                .focused($isTextFocused)
            
            if text.isEmpty && !isTextFocused {
                VStack {
                    Text(placeholder)
                        .Pro(size: 18, color: Color(red: 153/255, green: 173/255, blue: 200/255))
                        .padding(.leading, 15)
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .onTapGesture {
                            isTextFocused = true
                        }
                    Spacer()
                }
            }
        }
        .frame(height: height)
    }
}

struct SwipeToDeleteRow<Content: View>: View {
    let content: Content
    let onDelete: () -> Void
    
    @State private var offsetX: CGFloat = 0
    @GestureState private var isDragging = false
    
    init(@ViewBuilder content: () -> Content, onDelete: @escaping () -> Void) {
        self.content = content()
        self.onDelete = onDelete
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Button(action: {
                onDelete()
            }) {
                HStack {
                    Spacer()
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Spacer()
                }
                .frame(width: 80, height: 130)
                .background(Color.red)
                .cornerRadius(16)
            }
            
            content
                .offset(x: offsetX)
                .gesture(
                    DragGesture()
                        .updating($isDragging) { value, state, _ in
                            state = true
                        }
                        .onChanged { value in
                            if value.translation.width < 0 {
                                offsetX = max(value.translation.width, -100)
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -50 {
                                offsetX = -100
                            } else {
                                offsetX = 0
                            }
                        }
                )
                .animation(.easeInOut, value: offsetX)
        }
        .frame(height: 130)
        .padding(.horizontal)
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 33/255, green: 85/255, blue: 132/255) : Color(red: 33/255, green: 85/255, blue: 131/255))
                .frame(width: 60, height: 30)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 27/255, green: 123/255, blue: 193/255))
                        .frame(width: 23, height: 23)
                        .offset(x: configuration.isOn ? 13 : -13)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding()
    }
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
