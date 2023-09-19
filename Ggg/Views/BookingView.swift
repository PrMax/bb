
import Combine
import SwiftUI

struct BookingView: View {
    @State private var email: String = ""
    @State private var isEmailValid: Bool? = nil
    @ObservedObject var viewModel: BookingViewModel = BookingViewModel()
    

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 8) {
                
                // ZStack для отображения рейтинга, названия и адреса отеля.
                ZStack {
                    Color.white
                    VStack(alignment: .leading, spacing: 10) {
                        makeHorating(horating: viewModel.bookingData?.horating ?? 0, ratingName: viewModel.bookingData?.rating_name ?? "")
                        makeHotelName(name: viewModel.bookingData?.hotel_name ?? "")
                        makeHotelAddressTwo(address: viewModel.bookingData?.hotel_adress ?? "")
                    }
                }
                .cornerRadius(12)
                
                // ZStack для отображения деталей бронирования.
                ZStack {
                    Color.white
                    VStack(alignment: .leading, spacing: 8) {
                        makeLabelWithValue(label: "Вылет из", value: viewModel.bookingData?.departure, trailingPadding: 50)
                        makeLabelWithValue(label: "Страна, город", value: viewModel.bookingData?.arrival_country, trailingPadding: 9)
                        makeLabelWithValue(label: "Даты", value: "\(viewModel.bookingData?.tour_date_start ?? "") - \(viewModel.bookingData?.tour_date_stop ?? "")", trailingPadding: 79)
                        makeLabelWithValue(label: "Кол-во ночей", value: "\(viewModel.bookingData?.number_of_nights ?? 0) ночей", trailingPadding: 15)
                        makeLabelWithValue(label: "Отель", value: viewModel.bookingData?.hotel_name, trailingPadding: 74)
                        makeLabelWithValue(label: "Номер", value: viewModel.bookingData?.room, trailingPadding: 66)
                        makeLabelWithValue(label: "Питание", value: viewModel.bookingData?.nutrition, trailingPadding: 51)
                    }
                }
                .cornerRadius(12)
                
                // ZStack для заголовка блока информации о покупателе и блока валидации.
                ZStack {
                    Color.white
                    VStack(alignment: .leading, spacing: 10) {
                        makeBuyerInformation()
                        ValidationBlock(email: $email, isEmailValid: $isEmailValid)
                    }
                }
                .cornerRadius(12)
                
                // ZStack для блока добавления новых туристов.
                ZStack {
                    Color.white
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(0..<viewModel.tourists.count, id: \.self) { index in
                            TouristEntryTabView(tourist: $viewModel.tourists[index])
                        }
                        Button(action: {
                            let newTourist = Tourist(name: "Новый турист")
                                viewModel.tourists.append(newTourist)
                        }) {
                            HStack {
                                Text("Добавить туриста")
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                        }
                        .padding()
                    }
                }
                .cornerRadius(12)
                
                TouristInformationView(viewModel: viewModel)
                
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(12)
            .background(Color(red: 0.96, green: 0.96, blue: 0.98))
        }
        .navigationBarTitle(Text("Бронирование"))
    }

    // Функция для создания представления рейтинга отеля.
    func makeHorating(horating: Int, ratingName: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("PaleYellow"))
                .frame(width: 200, height: 25)
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(Color("RichYellow"))
                
                Text("\(horating) \(ratingName)")
                    .foregroundColor(Color("RichYellow"))
            }
        }
    }
    
    // Функция для создания представления названия отеля.
    func makeHotelName(name: String) -> some View {
        Text(name)
            .font(.title)
            .fontWeight(.bold)
    }

    // Функция для создания представления адреса отеля с возможностью нажатия.
    func makeHotelAddressTwo(address: String) -> some View {
        Button(action: {}) {
            Text(address)
                .font(.subheadline)
                .foregroundColor(Color.blue)
        }
        .frame(alignment: .leading)
    }

    // Функция для создания представления метки с значением.
    func makeLabelWithValue(label: String, value: String?, trailingPadding: CGFloat) -> some View {
        HStack {
            Text(label)
                .foregroundColor(Color("PaleGray"))
                .padding(.trailing, trailingPadding)
                .padding(.leading, 16)
            
            Text(value ?? "")
                .padding(.leading, 16)
        }
        .padding(.vertical, 8)
    }

    // Функция для создания заголовка блока информации о покупателе.
    func makeBuyerInformation() -> some View {
        Text("Информация о покупателе")
            .font(
                Font.custom("SF Pro Display", size: 22)
                    .weight(.medium)
            )
            .foregroundColor(.black)
            .frame(width: 343, alignment: .topLeading)
            .padding(.top, 16)      // Отступ сверху
            .padding(.leading, 16)
    }
}

// Предварительный просмотр для BookingView.
struct BBookingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BookingViewModel()
        BookingView(viewModel: viewModel)
    }
}



   
