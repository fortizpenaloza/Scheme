Class {
	#name : #SchemeTest,
	#superclass : #TestCase,
	#instVars : [
		'scheme'
	],
	#category : #'Scheme-Tests'
}

{ #category : #running }
SchemeTest >> setUp [
	super setUp.
	
	scheme := Scheme new.
]

{ #category : #tests }
SchemeTest >> testDefineExpression [

	scheme parseAndEval: '(define pi 3.14)'.
	self assert: ( scheme parseAndEval: 'pi' ) equals: 3.14
]

{ #category : #tests }
SchemeTest >> testEvalBoolean [

	self assert: (scheme parseAndEval: 'true') equals: true.
	self assert: (scheme parseAndEval: 'false') equals: false.
]

{ #category : #tests }
SchemeTest >> testEvalEmptyList [

	self assert: ( scheme parseAndEval: '()' ) equals: #(  )
]

{ #category : #tests }
SchemeTest >> testEvalFloat [

	self
		assert: ( scheme parseAndEval: '12.33' ) equals: 12.33;
		assert: ( scheme parseAndEval: '-12.33' ) equals: -12.33
]

{ #category : #tests }
SchemeTest >> testEvalInteger [

	self
		assert: ( scheme parseAndEval: '12' ) equals: 12;
		assert: ( scheme parseAndEval: '-12' ) equals: -12
]

{ #category : #tests }
SchemeTest >> testEvalQuote [

	self assert: ( scheme parseAndEval: '(quote (* x x))' ) equals: #( #* #x #x ).
	self assert: ( scheme parseAndEval: '(quote (quote (* x x)))' ) equals: #( #quote #( #* #x #x ) )
]
