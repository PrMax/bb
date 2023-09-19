
import SwiftUI

struct PaymentConfirmationView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
       
            VStack(spacing:10) {
                Text("🎉")
                    .font(.custom("MyCustomFont", size: 70))
                Text("Ваш заказ принят в работу")
                Text(generateOrderConfirmationText())
                    .foregroundColor(Color("PaleGray"))
                    .multilineTextAlignment(.center)
                
          
                               NavigationLink(
                                   destination: HotelView(viewModel: HotelViewModel()),
                label: {
                                       Text("Супер!")
                                           .font(.headline)
                                           .foregroundColor(.white)
                                           .frame(maxWidth: .infinity)
                                           .frame(height: 50)
                                           .background(Color.blue)
                                           .cornerRadius(8)
                }
                               )
            }
            .navigationBarItems(leading: Text("Заказ оплачен"))
       
        
    }
    
    
    
    func generateOrderConfirmationText() -> String {
        let randomOrderNumber = String(format: "%04d", Int.random(in: 1...9999))
        return "Подтверждение заказа №\(randomOrderNumber) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление"
    }
}
struct BPaidView_Previews: PreviewProvider {
    static var previews: some View {
       PaymentConfirmationView()
        
    }
}
