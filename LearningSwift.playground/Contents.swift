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

// E:7
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

//E:
class Shape {
    var numberOfSides = 0
    let pi = 3.14
    func simpleDescription() -> String {
        return "Its a simple shape with \(numberOfSides) sides"
    }
    func addSides(s:Int) -> Int {
        numberOfSides = s
        return 1
    }
}

// creating object of the class

var shape = Shape()
var status = shape.addSides(s: 3)
var desc = shape.simpleDescription()
print(desc)


// Initialization or Instantiation of the Class : init to create one
// self is the this pointer of the class ?? perhaps

class NamedShape {
    var numberOfSides = 0
    var name:String
    
    init(name:String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "Its a \(name) with \(numberOfSides) sides"
    }
    
}

// deinit for cleanup before the object is deallocated
// all class concepts like inheritance , destructor , polymorphism using override word

class Square: NamedShape {
    var sideLength: Double
    
    init(sL:Double, name:String){
        self.sideLength = sL
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double { return sideLength*sideLength }
    override func simpleDescription() -> String {
        return "Its a square called as \(name) and area =\(self.area())"
    }
}

let test = Square(sL: 5.2, name: "New Square")
test.simpleDescription()

//E:10
class Circle:NamedShape {
    var radius:Double = 0
    let pi:Double = 3.14
    
    init(r:Double, name:String ){
        radius = r
        super.init(name: name)
    }
    
    func area() -> Double { return pi*radius*radius }
    override func simpleDescription() -> String {
        return "Its a circle of radius = \(radius) and area = \(area()). We named it \(name)."
    }
}

let circleObj = Circle(r: 7, name: "RainBow")
print(circleObj.simpleDescription())

// Getter and Setter Functions

/* properties can have getter and setter */
class EquilateralTriangle : NamedShape {
    var sideLength:Double = 0.0
    init(_ length: Double,_ name:String) {
        self.sideLength = length
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter:Double {
        get{
            return 3.0*sideLength
        }
        set{
            sideLength = newValue / 3.0 //new value is what ?? it is the implicit name : we can change this name
        }
    }
    
    override func simpleDescription() -> String {
        return "Its a triangle of equal sides"
    }
}


var triangleObject = EquilateralTriangle(4.5,"Triangle 1")
print( triangleObject.perimeter )
triangleObject.perimeter = 35
print(triangleObject.sideLength) // updated according to new value of perimeter

// willset and didset are used to provide value of the property that may be set before or after a new value

class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet{
            square.sideLength = newValue.sideLength
        }
    }
        var square :Square {
            willSet{
                triangle.sideLength=newValue.sideLength
            }
        }
    
    init(size:Double , name : String){
        square = Square(sL: size, name: name)
        triangle = EquilateralTriangle(size,name)
    }
}

var triAndSqrObj = TriangleAndSquare(size: 10, name: "testing")
triAndSqrObj.square = Square(sL: 12, name: "changed")
print(triAndSqrObj.square.sideLength)
print(triAndSqrObj.square.name)
print(triAndSqrObj.triangle.sideLength)
print(triAndSqrObj.triangle.name) // name wasnt updated accordingly when the square's name was changed as it wasnt mentioned in the willset

// optionals in the class

var squareObj:Square? = nil //Square(sL: 5.2, name: "Square 1")
print(squareObj?.sideLength ?? 5)

// ENUMERATIONS AND STRUCTURES
// enum to create an enumeration , they too have methoda associated with them

enum Rank:Int {
    case ace = 1 //explicity changed value from 0 to 1
    case two, three, four, five, six, seven, eigth, nine, ten
    case jack, queen, king
    
    func simpleDesc() ->String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default :
            return String(self.rawValue) // rawValue ?? it returns the associated integer inside the enum
        }
    }
    // E:11
    func compareRank(value1:Rank, value2:Rank) {
        if value1.rawValue == value2.rawValue {
            print("Equal")
        } else {
            print("Not Equal")
        }
    }
    
}

let ace = Rank.ace
let rankObj = Rank.five
rankObj.compareRank(value1: rankObj, value2: ace)
let aceRawValue = ace.rawValue

let Object = Rank(rawValue: 2)
// its a init?() because we donot know if it will return case or nil as case may not be there according to the rawValue



// cases where the rawvalue have no meaning

enum Suit: Int {
    case spades, hearts, diamonds, clubs
    
    func simpleDesc() -> String {
        switch self {
        case .spades :
            return "spades"
        case .hearts :
            return "hearts"
        case .clubs:
            return "clubs"
        case .diamonds:
            return "diamonds"
        }
    }
    // E:12
    func color() -> String{
        switch self {
        case .spades :
            return "black"
        case .hearts :
            return "red"
        case .clubs:
            return "black"
        case .diamonds:
            return "red"
        }
    }
}


let hearts = Suit.hearts
let heartsDesc = hearts.simpleDesc()
let heartColor = hearts.color()


// Associated values behave like stored properties of the enumeration case instance

enum ServerResponse {
    case result(String, String)
    case failure(String)
    case process(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let processing = ServerResponse.process("In middle of processing")
let failure = ServerResponse.failure("Out of cheese")

// E:13
switch processing {
case let .result(sunrise,sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .process(message):
    print("\(message)")
case let .failure(message):
    print("Failure...... \(message)")
}

// STRUCTURE

// structure are always copied while classes pass by reference

struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDesc() -> String {
        return "The \(rank.simpleDesc()) of \(suit.simpleDesc())"
    }
}

let threeOfSpades = Card(rank: .three, suit: .spades)
print(threeOfSpades.simpleDesc())

// E: 14  : print all combinations of rank X suit 😒
// how to iterate the cases when they have same value
func deckOfCards()-> [String] {
    var arrayOfDeck = [String]()
    for i in 0...3 {
        for j in 1...13 {
            let rankObj = Rank(rawValue:j)
            let suitObj = Suit(rawValue:i)
            let rankDesc = rankObj?.simpleDesc() ?? "card number"
            let suitDesc = suitObj?.simpleDesc() ?? "suit"
            arrayOfDeck.append(rankDesc+" of "+suitDesc)
        }
    }
    return arrayOfDeck
}

var resultList = deckOfCards()
// print(resultList)


// PROTOCOLS AND EXTENSIONS

// a astrict rule kind of thing , a certain structure a class declartion must follow : hence the name protocol

protocol ExampleProtocol {
    var simpleDesc: String { get }
    //var newReqr:Int { get }
    mutating func adjust()
    
}


// E : 15
// class, structure or enum : all can adopt the protocol version

class SimpleClass : ExampleProtocol {
    var simpleDesc: String = "A simple class"
   // var newReqr: Int = 1
    var anotherProp: Int = 1111
    func adjust() {
        simpleDesc += "mutated by a function : adjust()" // it doesnot need to mention mutating as class function can always modify
    }
}

let aProtocolInstance:ExampleProtocol = SimpleClass()
//print(aProtocolInstance.anotherProp)


var exampleClass = SimpleClass()
exampleClass.adjust()
let description = exampleClass.simpleDesc


// structure using protocol

struct SimpleStructure : ExampleProtocol {
    var simpleDesc: String = "A structure"
 //   var newReqr: Int = 2
    mutating func adjust() {
        simpleDesc += " mutated."
    }
}

var exampleStructure = SimpleStructure()
exampleStructure.adjust()
let descriptionStruct = exampleStructure.simpleDesc

// we had to add the variable added in the protocol


// extension : it is used to add functionality to an already existing type , such as a new methods and computed properties

// useful when you imported a type from a library or framework or for addding a protocol conformance to a type that is declared elsewhere


extension Int: ExampleProtocol {
    var simpleDesc: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

// The extension gave an error when protocol already had an integer in it . We are adding properties to already existing integer type of swift unresolvable recursion ??

print(7.simpleDesc)


// E: 16

protocol ProtocolAbsolute {
    var absoluteValue: Int {get}
}

extension Double : ProtocolAbsolute {
    var absoluteValue:Int { return Int(abs(self)) }
}

print(7.14.absoluteValue)

// protocol name can be used like any other named type :  a collection of objects that conforms to that protocol and have different types  for example the class and structure in the above examples
// methods outside protocol type are not visible , that is though simpleClass is a runtime type of protocol , its property is not visible to Example Protocol instances , hence protecting data from accidental access

// ERROR HANDLING 
