

import SwiftUI

struct ValidationBlock: View {
    @Binding var email: String
    @Binding var isEmailValid: Bool?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Блок для ввода номера телефона.
            ValidationTelephone()

            // Блок для ввода электронной почты.
            ZStack(alignment: .leading) {
                Color(red: 0.96, green: 0.96, blue: 0.98)
                    .cornerRadius(10)

                LabeledInputFieldView(title: "Почта", placeholder: "exempl@email.com", onEditingChanged: { newValue in
                }, errorText: (isEmailValid == false) ? "Неверный формат электронной почты" : nil, text: $email)
            }
            .padding(16)
            .padding(.vertical)

            // Информационное сообщение для пользователя.
            Text("Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту")
                .font(.footnote)
                .padding(.leading, 16)
                .padding(.bottom, 10)
                .foregroundColor(Color("PaleGray"))
        }
    }

}


