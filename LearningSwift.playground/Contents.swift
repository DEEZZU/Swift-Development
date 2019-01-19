// Swift Tour : Detailed Practice from chapter

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

//FOR-IN Loop , for searching in the dictionaries

// E:5
var interestingNumbers = [
    "prime" : [2,3,5,7,11],
    "fibonacci" : [1,1,2,3,5,8],
    "Square" : [1,4,9,16,25]
]

var largest = 0
var type:String = "prime"

for (kind,numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            type = kind
        }
    }
}

print("\(largest) is the maximum value and it is a \(type)" )

//while loop
var m = 2
while m < 100{
    m*=2
}
print(m)

//repeat while : so that atleast once the loop is run :  checking condition at the end
var n = 2
repeat{
    n*=2
}while n < 100

print(n)

// ranges excluding the upper bound
for i in 0..<4{
    print(i)
}

// including upper bound
for i in 0...4{
    print(i)
}

// FUNCTIONS AND CLOSURES

// func function_name(arg1 : type1, arg2:type2 .....) -> return type { Body of the function }
func greet(name:String, day:String) -> String{
    return "Hello \(name). Today is \(day)"
}

print(greet( name : "Vipin", day : "Monday"))

// E:6
func greet(name:String, lunchSpecial:String) -> String{
    return "Hello \(name). Today's lunch special is \(lunchSpecial)"
}

print(greet( name : "Vipin", lunchSpecial: "Aloo Tikki"))

// using no label or custom labels for the arguments
func greetWithoutLabel(_ name:String,_ day:String) -> String{
    return "Hello \(name). Today is \(day)"
}

print(greetWithoutLabel("Smrity","Monday"))

func greetCustom(n name:String,d day:String) -> String{
    return "Hello \(name). Today is \(day)"
}

print(greetCustom(n:"Smrity", d: "Tuesday"))

// Multiple Return using Tuple
func StatisticalCalculator(numbers:[Int]) -> (max: Int, min: Int, sum: Int) {
    var minimum = numbers[0]
    var maximum = numbers[0]
    var summation = 0
    
    for i in numbers {
        if i > maximum {
            maximum = i
        }
        if i < minimum {
            minimum = i
        }
        summation += i
    }
    
    return ( maximum, minimum, summation)
}

let result = StatisticalCalculator(numbers: [4,5,6,2,7,1,9,21,87,43])
print(" Max = \(result.0) \n Min = \(result.min) \n Sum = \(result.2) ")

// Nested Functions
func functionInsideFunction(num : Int) -> Int {
    var y = num
    func addOne() {
        y += 1
    }
    addOne()
    return y
}

print(functionInsideFunction(num: 4))

// First Class Type : Can return a fucntion : Designing a function which would return based on a case value

func makeFunction(choice: Int) -> ((Int) -> Int) {
    switch choice {
    case 1 :
        func addOne(num: Int) -> Int {
            return num+1
        }
        return addOne
    default :
        func mulOne(num: Int) -> Int {
            return num*num
        }
        return mulOne
    }
}

var functionNew = makeFunction(choice: 2)
functionNew(4)

// something  :/
var 😏 = "Ahaaann "
print(😏)

// function as argument

func sum(list: [Int], cond: (Int)-> Bool ) -> Int {
  var summ = 0
    for item in list {
        if cond(item) {
            summ += item
        }
    }
    return summ
}

func testing(num: Int) -> Bool {
    return num < 25
}

sum(list: [23,45,65,32,22,32,11] ,cond: testing)

// Closure : block of code that can be called later : given as ({}) and the body  is separated from the arguments using in keyword

// E:7
var numbers = [ 20, 27, 17, 2]
numbers.map({ (number: Int) -> [Int] in
    var result = [Int]()
    for item in numbers {
        if item % 2 == 1 {
            result.append(0)
        } else {
            result.append(1)
        }
    }
    return result
})

// .map is used to write closure
// return and argument type can be omitted for simplicity if delegated value is known

let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

// A closure passed as the last argument to a function can appear immediately after the parentheses
// when a closure is the only argument , parentheses can be omitted entirely

let  sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)

// OBJECTS AND CLASSES

