
import SwiftUI


struct RoomDetailView: View {
    // Массив комнат
    let rooms: [BRoom]
    
    
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(rooms) { room in
                    ZStack {
                        Color.white
                        VStack(alignment: .leading, spacing: 12) {
                            RoomComponents.CustomSliderView(imageUrls: room.image_urls)
                            RoomComponents.RoomLabel(name: room.name)
                            RoomComponents.Peculiarities(peculiarities: room.peculiarities)
                            RoomComponents.DisabledButton()
                            RoomComponents.PriceBlock(price: room.price, period: room.price_per.lowercased())
                            RoomComponents.RoomDetailButton()
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.bottom, 8)
                }
            }
            .background(Color(red: 0.96, green: 0.96, blue: 0.98))
            .navigationBarTitle(Text("Номер"), displayMode: .inline)
        }
    }
}


// Расширение для структурирования компонентов комнаты.
extension RoomDetailView {
    struct RoomComponents {
        
        // Функция для создания представления слайдера изображений.
        static func CustomSliderView(imageUrls: [String]) -> some View {
           
            ImageSliderView(imageUrls: imageUrls)
                .frame(minHeight: 240, maxHeight: 400)
                .cornerRadius(32)
        }
        
        // Функция для создания метки с названием комнаты.
        static func RoomLabel(name: String) -> some View {
            Text(name)
                .font(.title)
        }
        
        // Функция для отображения особенностей комнаты.
        static func Peculiarities(peculiarities: [String]) -> some View {
            HStack {
                ForEach(peculiarities, id: \.self) { peculiarity in
                    Text(peculiarity)
                        .padding(.leading)
                        .foregroundColor(Color("PaleGray"))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color(red: 0.98, green: 0.98, blue: 0.99))
                .cornerRadius(5)
            }
        }
        
        // Функция для создания отключенной кнопки "Подробнее о номере".
        static func DisabledButton() -> some View {
            Button(action: {}) {
                HStack {
                    Text("Подробнее о номере")
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .foregroundColor(Color.blue)
                        .disabled(true)
                }
                .padding(.leading, 10)
                .padding(.trailing, 2)
                .padding(.vertical, 5)
                .frame(height: 29, alignment: .leading)
                .background(Color(red: 0.05, green: 0.45, blue: 1).opacity(0.1))
                .cornerRadius(5)
            }
        }
        
        // Функция для отображения блока с ценой комнаты.
        static func PriceBlock(price: Int, period: String) -> some View {
            HStack {
                Text("\(price)₽")
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(period)")
                    .font(.footnote)
                    .foregroundColor(Color("PaleGray"))
            }
        }
        
        // Функция для создания кнопки, ведущей к деталям бронирования.
        static func RoomDetailButton() -> some View {
            NavigationLink(
                destination: BookingView(viewModel: BookingViewModel()),
                label: {
                    Text("Выбрать номер")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            )
        }
    }
}




