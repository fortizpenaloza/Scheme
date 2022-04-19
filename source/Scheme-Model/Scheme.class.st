"
I am a Scheme evaluator

I evaluate a body of text of the Scheme statemets. I collaborate with a `SchemeParser` 
"
Class {
	#name : #Scheme,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'Scheme-Model'
}

{ #category : #initialization }
Scheme >> initialize [ 

	super initialize.
	context := Dictionary new.
]
