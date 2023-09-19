

import SwiftUI

struct HotelView: View {
    @ObservedObject var viewModel: HotelViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            
            // Основной вертикальный стек
            VStack {
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Первый блок с изображениями и информацией о гостинице
                        ZStack {
                            VStack(alignment: .leading, spacing: 8) {
                                sliderView(imageUrls: viewModel.hotelData?.image_urls ?? [])
                                hotelRatingView(rating: viewModel.hotelData?.rating ?? 0, ratingName: viewModel.hotelData?.rating_name ?? "")
                                hotelLabelView(name: viewModel.hotelData?.name ?? "")
                                Spacer()
                                hotelAddressView(address: viewModel.hotelData?.adress ?? "")
                                Spacer()
                                hotelPriceView(price: viewModel.hotelData?.minimal_price ?? 100000, description: viewModel.hotelData?.price_for_it.lowercased() ?? "")
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        
                        
                        Spacer().frame(height: 8)
                        
                        // Второй блок с дополнительной информацией о гостинице
                        ZStack {
                            VStack {
                                hotelInfoHeaderView()
                                hotelPeculiaritiesView(viewModel.hotelData?.about_the_hotel.peculiarities ?? [])
                                hotelDescriptionView(description: viewModel.hotelData?.about_the_hotel.description ?? "")
                                nonClickableButtonView(title: "Удобства", subtitle: "Самое необходимое", imageName: "face.smiling")
                                nonClickableButtonView(title: "Что включено", subtitle: "Самое необходимое", imageName: "checkmark.square")
                                nonClickableButtonView(title: "Что не включено", subtitle: "Самое необходимое", imageName: "multiply.square")
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.bottom, 12)
                    }
                    
                    .background(Color(red: 0.96, green: 0.96, blue: 0.98))
                }
                
                
                // Нижний блок с кнопкой
                ZStack {
                    VStack(alignment: .center, spacing: 0) {
                        NavigationLink(
                            destination: RoomListView(viewModel: RoomDataViewModel()),
                            label: {
                                Text("К выбору номера")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.blue)
                                    .cornerRadius(15)
                            }
                        )
                    }
                    .padding()
                    .padding(.top, 12)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                
            }
            
            .navigationBarTitle(Text("Отель"))
        }
        
    }
}




//MARK: - Subviews

func sliderView(imageUrls: [String]) -> some View {
    ImageSliderView(imageUrls: imageUrls)
        .frame(minHeight: 240, maxHeight: 400)
}

func hotelRatingView(rating: Int, ratingName: String) -> some View {
    ZStack {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color("PaleYellow"))
            .frame(width: 200, height: 25)
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(Color("RichYellow"))
            Text("\(rating) \(ratingName)")
                .foregroundColor(Color("RichYellow"))
        }
    }
}

func hotelLabelView(name: String) -> some View {
    Text(name)
        .font(.title)
        .fontWeight(.semibold)
}

func hotelAddressView(address: String) -> some View {
    Button(action: {}) {
        Text(address)
            .font(.subheadline)
            .foregroundColor(Color.blue)
    }
    .frame(alignment: .leading)
}

func hotelPriceView(price: Int, description: String) -> some View {
    HStack {
        Text("От: \(price)₽")
            .font(.title)
            .fontWeight(.bold)
        Text(description)
            .font(.footnote)
            .foregroundColor(Color("PaleGray"))
    }
    .padding(.trailing, 30)
}

func hotelInfoHeaderView() -> some View {
    Text("Об отеле")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
}


func hotelPeculiaritiesView(_ peculiarities: [String]) -> some View {
    let chunkedPeculiarities = peculiarities.chunkedArray(into: 2)
    
    return VStack {
        ForEach(chunkedPeculiarities, id: \.self) { pair in
            HStack(spacing: 4) {
                ForEach(pair, id: \.self) { peculiarity in
                    HStack(alignment: .center, spacing: 2) {
                        Text(peculiarity)
                            .font(.subheadline)
                            .foregroundColor(Color("PaleGray"))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(red: 0.98, green: 0.98, blue: 0.99))
                    .cornerRadius(5)
                }
                Spacer()
            }
        }
    }
}


func hotelDescriptionView(description: String) -> some View {
    Text(description)
}

func nonClickableButtonView(title: String, subtitle: String, imageName: String) -> some View {
    HStack {
        Image(systemName: imageName)
            .foregroundColor(Color.black)
        VStack(alignment: .leading) {
            Text(title)
            Text(subtitle)
                .foregroundColor(Color("PaleGray"))
        }
        Spacer()
        Image(systemName: "chevron.right")
            .foregroundColor(.black)
    }
    .padding(.horizontal, 10)
    .padding(.vertical, 10)
}

extension Array {
    func chunkedArray(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}



//Предварительный просмотр
struct HotelView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyViewModel = HotelViewModel()
        
        
        return HotelView(viewModel: dummyViewModel)
            .environmentObject(AppCoordinator())
            .previewDevice("iPhone 12")
    }
}

