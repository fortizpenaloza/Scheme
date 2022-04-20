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

{ #category : #'private - evaluating' }
Scheme >> eval: anExpression in: aContext [

	anExpression = #() then: [  ^ anExpression ].

	anExpression isSymbol  then: [ ^ aContext at: anExpression  ].

	anExpression isArray
		  then: [ 
			  anExpression first = #define then: [ 
				  ^ aContext at: anExpression second put: ( self eval: anExpression third in: aContext ) ].
			  anExpression first = #quote then: [ ^ anExpression second ]
			  ]
		  otherwise: [ ^ anExpression ]
]

{ #category : #initialization }
Scheme >> initialize [ 

	super initialize.
	context := Dictionary new.
]

{ #category : #evaluating }
Scheme >> parseAndEval: aProgramString [

	| expression |
	expression := SchemeParser new parse: aProgramString.
	^ self eval: expression in: context
	
]
