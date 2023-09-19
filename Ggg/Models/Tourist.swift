


import Foundation

struct Tourist {
    var name = ""
    var surname = ""
    var passport = ""
    var birthDate = ""
    var citizenship = ""
    var passportValidityPeriod = ""

    func isFilled() -> Bool {
        return !name.isEmpty && !passport.isEmpty && !birthDate.isEmpty && !surname.isEmpty && !citizenship.isEmpty && !passportValidityPeriod.isEmpty
    }
}

