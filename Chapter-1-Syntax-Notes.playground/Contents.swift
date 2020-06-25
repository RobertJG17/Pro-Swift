// **Notes and helpful examples gathered from Pro Swift by Paul Hudson**
//
//

import UIKit



// SECTION 1: - PATTERN MATCHING



// Pattern matching example with lists and tuples
//

let twoStraws = (name: "twostraws", password: "fr0stles")
let bilbo = (name: "Bilbo", password: "baggin5")
let taylor = (name: "Taylor", password: "swwwwwwifty")

let users = [twoStraws, bilbo, taylor]

for user in users {
    print(user.name)
}


// Using case + loop to pull specific data from iterable
//

for case ("twostraws", "fr0stles") in users {
    print("\nUser is twostraws has the password fr0stles")
}

for case (let name, let password) in users {
    print("User \(name) has the password \(password)")
}

// Same execution as above case however let placement convention changes
 for case let (name, password) in users {
    print("User \(name) has the password \(password)")
 }


// Matching optionals (using .none, .some keywords)
//

let name: String? = "twostraws"
let password: String? = "fr0stles"

switch (name, password) {
case let (.some(name), .some(password)):
    print("\nHowdy \(name), your password \(password) has not been changed in 6 months, would you like to modify it?")
case let (.some(name), .none):
    print("Please enter a password, \(name).")
default:
    print("Who are you?")
}

// .some(name) -> *The name variable here is a locally bound unwrapped optional,
// not the ones declared prior to the switch

//Example showing difference between option ? and .some/.none functionality

let data: [Any?] = ["Bill", nil, 69, "Ted"]

for case let .some(datum) in data {
    print(datum)
}

for case let datum? in data {
    print(datum)
}


// Pattern matching if-else flow using the pattern match operator (~=)
//

let age = 36

if 0 ..< 18 ~= age {
    print("You have the energy and time, but not the money")
} else if 18 ..< 70 ~= age {
    print("You have the energy and money, but not the time")
} else {
    print("You have the time and money, but not the energy")
}

// An even cleaner solution becomes clear when you remember that 0 ..< 18
//creates an instance of a Range struct, which has its own set of methods.

if (0 ..< 18).contains(age) {
    print("You have the energy and time, but not the money")
} else if (18 ..< 70).contains(age) {
    print("You have the energy and money, but not the time")
} else {
    print("You have the time and money, but not the energy")
}


// Matching enums and associated values
//

// Basic switch-enumeration construct
enum WeatherType {
    case cloudy
    case sunny
    case windy
}

let today = WeatherType.cloudy

switch today {
case .cloudy:
    print("\nToday is cloudy")
case .sunny:
    print("Today is sunny")
case .windy:
    print("Today is windy")
}

// Enumeration-switch construct with associated values
enum tomorrowWeatherType {
    case cloudy(coverage: Int)
    case sunny
    case windy
}

let tomorrow = tomorrowWeatherType.cloudy(coverage: 100)

switch tomorrow {
// Using local constant bind to have access to associated type variable
case .cloudy(coverage: let coverage):
    print("It's cloudy with \(coverage)% coverage")
case .sunny:
    print("Today is sunny")
case .windy:
    print("Today is windy")
}

// Loop with case-let structure and 'where' keyword
//

let forecast: [tomorrowWeatherType] = [.cloudy(coverage: 40), .sunny, .windy, .cloudy(coverage: 100), .sunny]
for case let .cloudy(coverage) in forecast {
    print("\nIt's cloudy with \(coverage)% coverage")
}

// Using 'is' keyword to check equality of UI objects

let view: AnyObject = UIButton()
switch view {
case is UIButton:
    print("\nFound a button")
case is UILabel:
    print("Found a label")
case is UISwitch:
    print("Found a switch")
case is UIView:
    print("Found a view")
default:
    print("Found something else")
}

// Using where keyword and loop optional construction
// to filter and print speciific, non-nil values
//

let celebrities: [String?] = ["Michael Jackson", nil, "Michael Caine", nil, "Michael Jordan"]

for case let name? in celebrities where name.count == 13 {
    print(name)
}



// SECTION 2: - NIL COALESCING



// Example of using nil coalescing if there is a chance of something returning nil

let savedText = (try? String(contentsOfFile: "saved.txt")) ?? "Hello, world!"
print(savedText)



// SECTION 3: - GUARD



// Usage of guard statement in for loop
//

for i in 1...100 {
    guard i % 8 == 0 else { continue }
    
    print(i)
}

// Completes same thing as above block, but using where in combination with for loop
for i in 1...100 where i % 8 == 0 {
    print(i)
}

