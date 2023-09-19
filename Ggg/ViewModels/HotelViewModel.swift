
import SwiftUI
import Combine

// Определение ошибок
enum HotelError: Error {
    case invalidURL
    case networkError(Error)
}

class HotelViewModel: ObservableObject {

    // Данные отеля
    @Published var hotelData: HotelData?
    
    // Ошибка, которую мы можем показать пользователю
    @Published var error: HotelError?
    
    // Содержит все активные подписчики
    private var cancellables: Set<AnyCancellable> = []

    // Инициализация
    init() {
        loadData()
    }
    
    func loadData() {
        // Проверка действительности URL
        guard let url = URL(string: "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3") else {
            error = .invalidURL
            return
        }
        
        // Начинаем загрузки данных
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: HotelData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    // Завершили без ошибок
                    break
                case .failure(let error):
                    self?.error = .networkError(error)
                }
            }) { [weak self] hotelData in
                self?.hotelData = hotelData
            }
            .store(in: &cancellables)
    }
}

