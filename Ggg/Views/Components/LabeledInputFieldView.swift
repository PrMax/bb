


import SwiftUI


struct LabeledInputFieldView: View {
    var title: String
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    var onEditingChanged: (String) -> Void = { _ in }
    var errorText: String? = nil
    var allowOnlyLetters: Bool = false

    @Binding var text: String

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(Color("PaleGray"))
                    .padding(.leading, 16)
                    .padding(.top, 10)
                
                TextField(placeholder, text: $text, onCommit: {
                    self.onEditingChanged(self.text)
                })
                .font(Font.custom("SF Pro Display", size: 16))
                .kerning(0.75)
                .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.17))
                .padding(.leading, 16)
                .padding(.bottom, 10)
                .onChange(of: text) { newValue in
                    if allowOnlyLetters && !newValue.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
                        text = String(newValue.filter { $0.isLetter || $0.isWhitespace })
                    }
                }
                
                if let error = errorText {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.leading, 16)
                }
            }
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.98).cornerRadius(10))
    }
}


