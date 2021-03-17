REBOL [
    Title:  "Whatever"
    Date:   2-Feb-2000
    File:   %whatever.reb
    Author: "Whatever"
    Version: 1.2.3
]

dict: [
	"name" john
	"surname" doe
	"country" Spain
]

loop 200000 [
	print [select dict "surname"]
]