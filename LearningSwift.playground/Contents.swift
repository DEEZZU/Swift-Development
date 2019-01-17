// simple print statement
print("Hello, world!")

// let for constants and var for variables
let myConstant = 23
var myAge = 23
myAge
print( myAge )

//E:1
// explicitly define the type of the variable
let experimentVar: Float = 4
experimentVar
//let experimentar2: Double
//experimentar2 // must have value initially

//E:2
let label = "My height is "
let height = 5.2
// let statement = label + height <-------- Binary operator cannot be applied to String+Double , so conversion is necessary
let statement = label + String(height)

//E:3
// using \() to include fractions and strings
let number1 = 1.1
let number2 = 3.4
var namVariable  = "Deepti"
let statement2 = "Hey I calculated this \( number1+number2 ) "
let statement3 = "Hey \(namVariable) "

//Multiline String
let quotation = """
                Do I have to try this as well ???
                What I am 3 year old at programming.
                Great .
                """
quotation
print( quotation )

// Arrays and Dictionaries
var newArray = ["Deeps" , "Hey Deeps", "Helloo", "How are you?", "Fine"]
newArray[0]

var newDictionary = [
    "Deepti" : "M.Sc.",
    "Vipin" : "MCA",
]
newDictionary["Deepti"]
newDictionary["Smrity"] = "MCA"

print(newDictionary)


newArray.append("Good Morning")
print(newArray)

//empty Dictionaries and Arrays
var newArray2 = [String]()
var newDict2 = [Float: String]()
// or
newArray2 = []
newDict2 = [:]

//Control flow
var listOfMarks = [55, 54, 32, 54, 12]
var passedSubjects = 0
for marks in listOfMarks {
    if marks > 40
    {
        passedSubjects += 1
    }
}
print("The number of subjects passed = \(passedSubjects)")

// OPTIONALS
// if and let can be used in conjuction to create optionals : values that might be missing
// optionals can be created by marking a question mark after the type of the variable
// they may have a value or may be nil

// E:4
var optionalName: String? = "Deepti"
if let name = optionalName {
    print("Hello \(name)")
}

var optionalName2: String? = nil
if let name = optionalName2 {
    
    print("Hello \(name)")
    
} else {
    
    print("Hello John Doe!")

}

// ??  Default Values
 var defaultValue = "John Doe"
var optionalName3: String? = nil
if let name = optionalName3 {
   print("Hello \(name ?? defaultValue)")
}

//SWITCH Case

let veggies = "Tomato"

switch veggies {
case "Onion" :
    print("Cry")
case "Tomato", "Cherries":
    print("Its red")
default : print("Why does color bother you ?") // commenting this gives error : "switch must be exhaustive"
}

