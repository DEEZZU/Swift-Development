//: [Previous](@previous)
// fundamental types : Int, Double, Float, Bool, String
// Collection types : Array, Set, Dictionary
// Variables : to store data , refered to identify values
// Constants : variables whose values cannot be changed , more powerful >??
// makes code safer and clearer in intent
// Advanced Types : Tuples , enables to create and pass arounf groupings of values : multiple value return as a single compound
// Optionals : handle the absence of the value  : value or nil : can work for any type not just classes like in obj-C : more expressive, safer
// TYPE-SAFE Language : helps you to be clear of type of value the code can use . helps within the development process


// CONSTANTS AND VARIABLES
// value and particular type are associated
let anotherConstant = 10
var anotherVariable = 0
// multiple declaration
 var x=10.0, y=19.4, z=0.0

// TYPE ANNOTATIONS
// annotate a type to indicate the type of the value variable can store : String
var welcomeMesage: String = "I am here."
welcomeMesage = "Hello World"
// Multiple Declarations: annotated type
var red:Double = 4.5 , blue:Double = 6.7 , green:Double = 9.4 //<=== This requires attention
// green = 5.6
// blue = 7.6

// NAMING CONSTANTS AND VARIABLES
// name can contain any character
var 🍔: String = "This burger contains AT"
// naming converntion : unicode character + no spacing + any character + no ( mathematical symbols + arrows+ private use unicode scalar values (??) + line- or box- drawing characters ) + cannot begin with numbers , though they may occur anywhere
// redeclaration of variables not allowed , var of certain types cant change value just like constants
// var -> const or vice versa conversion not possible
// NOTE : giving a keywors or constant same name as a reserved keyword, surround it by (`) <- backticks
//var (')var(') = 45

// PRINTING
print(welcomeMesage)
// print function has two parameters : separators , terminators : terminate at line break (default)
print(welcomeMesage, terminator: "!!!!")
// string interpolation : \() <-  to surpass datatype and print the content in the string
print ("Here is an example : \(red)")

// COMMENTS
// use comments to include non executable text in code , ignored by compiler
// single line : //  or multi line : /*....*/ : nested comments are possible

// SEMICOLON
// semicolons can be written after each statement
let broco = "🥦" ; print(broco)


// INTEGER
// no fractional component , can be signed or unsigned
// UInt8 : 8 bit unsigned integer
// Int32 : 32 bit signed
// 2 properties :  min and max
let minValue = UInt8.min
let maxValue = UInt8.max // + 1 <-  overflow

// Int : Int32, Int64
// print(Int.max)
// UInt : UInt32, UInt64


// FLOATING-POINT NUMBERS
// fractional part

// Double : 64 Bit : 15 decimal digits
// Float : 32 Bit : 6 decimal digits


// TYPE SAFTEY AND TYPE INFERENCE
// type safe lang: clear about the type of values
// type checks are performed when compiling code and flags mismatch
// type inference : swift infer the value type , constants and variables are still typed explicitly
// use : literal value assigned


// NUMERIC LITERALS

// 1. Integer Literals : a decimal with no prefix, binary : 0b, hex : 0x , oct : 0o
let decimalInteger = 17
let binaryInteger = 0b1001
let octalInteger = 0o17
let hexInteger = 0x17

// 2. Floating Point Literal : decimal with no prefix, hex, values on both side of decimal point , dec floats with e to denote exponent, hex can have an exponent denoted by p (2 ^ exp)
let decFloat = 1.25e2
let hexFloat = 0xFp2

// Numeric literals can be formatted : both integers and float can be padded with extra zeroes , can contain underscores to help with readability .
// Neither type of formatting affects the underlying value of the literal.

let paddedDouble =  000123.456
let oneMillion = 1_000_000
let justOverMillion =  1_000_000.000_000_1


// NUMERIC TYPE CONVERSION
/*
Integer Conversion
let cannotBeNeg:UInt8 = -1 // cannot be neg
let tooBig:Int8 = Int8.max + 1 // overflow
*/
let twoThousand:UInt16 = 2_000
let one:UInt8 = 1
let addSum = twoThousand + UInt16(one)
/* Integer to Float Conversion */
let three = 3
let pointValue = 0.14
let pi = (three) + Int(pointValue)
/* Numeric literals can be added directly  wihtout type conversion as accompanied in the variables and constants */


// TYPE ALIASES
// an alt name for an existing type
// typealias keyword can be used
// helps to maintain the context , working with data of a specified form
typealias  AudioSample = UInt16
var maxAmplitude:AudioSample = AudioSample.max


// BOOLEANS
// Bool : logical values : true or false
let orangeAreOrange = true
let orangeAreBrown  = false
// most useful with conditional statements

if orangeAreBrown {
    print("You are lying!")
} else {
    print("We know!!")
}
/*
let i = 1
if i {}
type safety ensures to raise an error for non bool types
*/
let i = 1
if i==1{}
// if Bool(i) {} <- Doesnt work


// TUPLES
/* group multiple values into single compound value */
//: [Next](@next)
