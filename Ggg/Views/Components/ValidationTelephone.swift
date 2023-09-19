
import SwiftUI

struct PhoneNumberValidationView: View {
    @State private var phoneNumber = ""
    private let maxLength = 11 // Максимальная длина номера (без учета префикса +7)
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color(red: 0.96, green: 0.96, blue: 0.98)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Номер телефона")
                    .font(Font.custom("SF Pro Display", size: 12))
                    .foregroundColor(Color("PaleGray"))
                    .kerning(0.12)
                    .padding(.leading, 16)
                    
            
                // Поле для ввода номера телефона
                TextField("Введите номер телефона", text: $phoneNumber)
                    .font(Font.custom("SF Pro Display", size: 16))
                    .kerning(0.75)
                    .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.17))
                    .padding(.leading, 16)
                    .autocapitalization(.none)
                    .keyboardType(.phonePad)
                    .onChange(of: phoneNumber) { newValue in
                        // Форматирование номера при изменении
                        phoneNumber = formatPhoneNumber(newValue)
                    }
            }
            
            .padding(.vertical)
        }
        .padding(16)
        .frame(height: 52)
    }
    
    // Функция для форматирования номера телефона
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        var cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // Обрезаем номер, если он превышает максимальную длину
        if cleanedPhoneNumber.count > maxLength {
            cleanedPhoneNumber = String(cleanedPhoneNumber.prefix(maxLength))
        }
        
        // Заменяем первую цифру на 7, если это не так
        if !cleanedPhoneNumber.isEmpty && cleanedPhoneNumber.first != "7" {
            cleanedPhoneNumber = "7" + cleanedPhoneNumber.dropFirst()
        }
        
        // Форматирование по маске
        let mask = "+X (XXX) XXX-XX-XX"
        var result = ""
        var index = cleanedPhoneNumber.startIndex
        
        for char in mask {
            if char == "X" {
                guard index < cleanedPhoneNumber.endIndex else { break }
                result.append(cleanedPhoneNumber[index])
                index = cleanedPhoneNumber.index(after: index)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}

struct ValidationTelephone: View {
    var body: some View {
        PhoneNumberValidationView()
    }
}

struct BValidationTelephone_Previews: PreviewProvider {
    static var previews: some View {
        ValidationTelephone()
    }
}
