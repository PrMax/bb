

import SwiftUI

struct TouristInformationView: View {
    @ObservedObject var viewModel: BookingViewModel
    @State private var showAlert = false
    @State private var navigateToNextScreen = false

    init(viewModel: BookingViewModel) {
        self.viewModel = viewModel
    }

    var totalAmount: Int {
        let tourPrice = viewModel.bookingData?.tour_price ?? 0
        let fuelCharge = viewModel.bookingData?.fuel_charge ?? 0
        let serviceCharge = viewModel.bookingData?.service_charge ?? 0
        return tourPrice + fuelCharge + serviceCharge
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack {
                HStack {
                    Text("Тур")
                        .foregroundColor(Color("PaleGray"))
                    Spacer()
                    Text("\(viewModel.bookingData?.tour_price ?? 0)₽")
                }
                HStack {
                    Text("Топливный сбор")
                        .foregroundColor(Color("PaleGray"))
                    Spacer()
                    Text("\(viewModel.bookingData?.fuel_charge ?? 0)₽")
                }
                HStack {
                    Text("Сервисный сбор")
                        .foregroundColor(Color("PaleGray"))
                    Spacer()
                    Text("\(viewModel.bookingData?.service_charge ?? 0)₽")
                }
                HStack {
                    Text("К оплате")
                        .foregroundColor(Color("PaleGray"))
                    Spacer()
                    Text("\(totalAmount)₽")
                        .foregroundColor(.blue)
                }
            }

            NavigationLink(
                destination: PaymentConfirmationView(),
                label: {
                    Text("Оплатить \(totalAmount)₽")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded{
                if areAllTouristsFilled() {
                    navigateToNextScreen = true
                    showAlert = false
                } else {
                    showAlert = true
                }
            }).disabled(!areAllTouristsFilled())
        }
        .padding()
        .frame(maxHeight: .infinity)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Ошибка"), message: Text("Пожалуйста, заполните все поля"), dismissButton: .default(Text("OK")))
        }
    }

    func areAllTouristsFilled() -> Bool {
        for tourist in viewModel.tourists {
            if !tourist.isFilled() {
                return false
            }
        }
        return true
    }
}


struct TouristInformationView_Previews: PreviewProvider {
    static var previews: some View {

        let viewModel = BookingViewModel()
        return TouristInformationView(viewModel: viewModel)
    }
}


