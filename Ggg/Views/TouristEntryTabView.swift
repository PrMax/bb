


import SwiftUI

struct TouristEntryTabView: View {
    @Binding var tourist: Tourist
    @State private var isExpanded = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            DisclosureGroup(
                .init(""),
                isExpanded: $isExpanded,
                content: {
                    Text("Турист")
                        .font(.subheadline)

                    LabeledInputFieldView(title: "Имя", placeholder: "Введите ваше имя", allowOnlyLetters: true, text: $tourist.name)
                        .padding(.bottom, 8)
                    LabeledInputFieldView(title: "Фамилия", placeholder: "Введите вашу фамилию", text: $tourist.surname)
                        .padding(.bottom, 8)
                    LabeledInputFieldView(title: "Дата рождения", placeholder: "Введите дату рождения", text: $tourist.birthDate)
                        .padding(.bottom, 8)
                    LabeledInputFieldView(title: "Гражданство", placeholder: "Введите гражданство", text: $tourist.citizenship)
                        .padding(.bottom, 8)
                    LabeledInputFieldView(title: "Номер загранпаспорта", placeholder: "Введите номер", text: $tourist.passport)
                        .padding(.bottom, 8)
                    LabeledInputFieldView(title: "Срок действия загранпаспорта", placeholder: "Введите срок действия", text: $tourist.passportValidityPeriod)
                })
        }
        .padding()
    }
}


struct TouristEntryTabView_Previews: PreviewProvider {
    static var previews: some View {
        TouristEntryTabView(tourist: .constant(Tourist(name: "Иван", surname: "Иванов", passport: "123456789", birthDate: "01.01.1990", citizenship: "Россия", passportValidityPeriod: "01.01.2030")))
    }
}
