import SwiftUI
import MapKit

struct BetArenaView: View {
    @StateObject var betArenaModel =  BetArenaViewModel()
    @State private var showBetTraining = false
    @State private var isTapped = false
    @State private var isFinish = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Nearest arenas")
                        .ProBold(size: 32)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation {
                            betArenaModel.isMap = false
                            betArenaModel.isList = true
                        }
                    }) {
                        Rectangle()
                            .fill(betArenaModel.isList ? Color(red: 20/255, green: 160/255, blue: 255/255) : .clear)
                            .overlay {
                                if betArenaModel.isList {
                                    Text("List")
                                        .ProBold(size: 18)
                                } else {
                                    Text("List")
                                        .Pro(size: 18)
                                }
                            }
                            .frame(height: 54)
                            .cornerRadius(16)
                    }
                    
                    Button(action: {
                        withAnimation {
                            betArenaModel.isMap = true
                            betArenaModel.isList = false
                        }
                    }) {
                        Rectangle()
                            .fill(betArenaModel.isMap ? Color(red: 20/255, green: 160/255, blue: 255/255) : .clear)
                            .overlay {
                                if betArenaModel.isMap {
                                    Text("On the map")
                                        .ProBold(size: 18)
                                } else {
                                    Text("On the map")
                                        .Pro(size: 18)
                                }
                            }
                            .frame(height: 54)
                            .cornerRadius(16)
                    }
                }
                .background(Color(red: 33/255, green: 85/255, blue: 132/255))
                .cornerRadius(16)
                .padding(.horizontal)
                
                if betArenaModel.isList {
                    VStack {
                        ScrollView(showsIndicators: false) {
                            VStack {
                                ForEach(0..<3, id: \.self) { index in
                                    Rectangle()
                                        .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color(red: 21/255, green: 157/255, blue: 252/255))
                                                .overlay {
                                                    VStack {
                                                        HStack(alignment: .top) {
                                                            VStack(alignment: .leading) {
                                                                VStack(alignment: .leading, spacing: 10) {
                                                                    Text("Arena name")
                                                                        .ProBold(size: 24)
                                                                    
                                                                    Text("There's a coach to choose from")
                                                                        .Pro(size: 16, color: Color(red: 196/255, green: 204/255, blue: 213/255))
                                                                }
                                                                
                                                                Rectangle()
                                                                    .fill(Color(red: 58/255, green: 84/255, blue: 110/255))
                                                                    .frame(height: 1)
                                                                    .padding(.trailing, 10)
                                                                    .padding(.top, 10)
                                                                
                                                                VStack(alignment: .leading, spacing: 5) {
                                                                    Text("Training price:")
                                                                        .Pro(size: 14, color: Color(red: 196/255, green: 204/255, blue: 213/255))
                                                                    
                                                                    Text("15$ (regular)")
                                                                        .Pro(size: 14, color: Color(red: 196/255, green: 204/255, blue: 213/255))
                                                                    
                                                                    Text("20$ (advanced)")
                                                                        .Pro(size: 14, color: Color(red: 196/255, green: 204/255, blue: 213/255))
                                                                    
                                                                    Text("10$ (just sparring)")
                                                                        .Pro(size: 14, color: Color(red: 196/255, green: 204/255, blue: 213/255))
                                                                }
                                                                .padding(.top, 10)
                                                            }
                                                            
                                                            
                                                            Image(.arenaImg)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 120, height: 210)
                                                        }
                                                        .padding(.horizontal)
                                                        
                                                        HStack {
                                                            Text("Burga Street 21")
                                                                .Pro(size: 14, color: Color(red: 139/255, green: 153/255, blue: 170/255))
                                                            
                                                            Spacer()
                                                            
                                                            Text("9:00 - 21:00")
                                                                .Pro(size: 14, color: Color(red: 139/255, green: 153/255, blue: 170/255))
                                                        }
                                                        .padding(.horizontal, 20)
                                                        
                                                        Button(action: {
                                                            
                                                        }) {
                                                            Rectangle()
                                                                .fill(Color(red: 126/255, green: 172/255, blue: 47/255))
                                                                .overlay {
                                                                    Text("Sign up for training")
                                                                        .Pro(size: 21)
                                                                }
                                                                .frame(height: 54)
                                                                .cornerRadius(16)
                                                                .padding(.horizontal)
                                                        }
                                                        .padding(.top, 20)
                                                    }
                                                }
                                        }
                                        .frame(height: 350)
                                        .cornerRadius(16)
                                        .padding(.horizontal)
                                }
                                
                                Color.clear.frame(height: 80)
                            }
                        }
                    }
                    .padding(.top)
                } else {
                    MapView(showBetTraining: $showBetTraining)
                        .padding(.top)
                }
            }
            .padding(.top)
            .blur(radius: showBetTraining ? 5 : isFinish ? 5 : 0)
            .onTapGesture {
                withAnimation {
                    if showBetTraining {
                        showBetTraining = false
                    }
                }
            }
            
            if showBetTraining {
                BetTrainingView(isTapped: $isTapped, isFinish: $isFinish, showBetTraining: $showBetTraining)
                    .frame(height: isTapped ? 730 : 330)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                    .offset(y: -35)
            }
            
            if isFinish {
                Image(.modalTraining)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 230)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 300)
                    .transition(.opacity)
                    .onAppear {
                        hideModalAfterDelay()
                    }
            }
        }
        .animation(.easeInOut, value: showBetTraining)
    }
    
    func hideModalAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                isFinish = false
            }
        }
    }
}

#Preview {
    BetArenaView()
}

struct MapView: View {
    @Binding var showBetTraining: Bool
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    let annotationItems = [
        AnnotationItem(id: 0, coordinate: CLLocationCoordinate2D(latitude: 55.763244, longitude: 37.605)),
        AnnotationItem(id: 1, coordinate: CLLocationCoordinate2D(latitude: 55.75, longitude: 37.635)),
        AnnotationItem(id: 2, coordinate: CLLocationCoordinate2D(latitude: 55.741, longitude: 37.60))
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotationItems) { item in
            MapAnnotation(coordinate: item.coordinate) {
                Image("pin")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        withAnimation {
                            showBetTraining = true
                            print("tapped")
                        }
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AnnotationItem: Identifiable {
    let id: Int
    let coordinate: CLLocationCoordinate2D
}
