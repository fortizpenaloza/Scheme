"
I am a Scheme parser

I produce an AST from a body of text of the Scheme statemets. I tokenize and parse the expressions.

"
Class {
	#name : #SchemeParser,
	#superclass : #Object,
	#category : #'Scheme-Model'
}

{ #category : #'private - parsing' }
SchemeParser >> assertNotEmpty: aTokenList [

	AssertionChecker 
		refuse: aTokenList isEmpty 
		because: 'Unexpected EOF' 
		raising: SyntaxError
]

{ #category : #'private - parsing' }
SchemeParser >> buildASTRecursivelyFrom: aTokenList [

	| currentToken |

	self assertNotEmpty: aTokenList.

	currentToken := aTokenList pop.

	^ currentToken = $(
		  then: [ 
			  | list |

			  list := OrderedCollection new.
			  [ aTokenList top ~= $) ] 
					whileTrue: [ list add: ( self buildASTRecursivelyFrom: aTokenList ) ].
			  aTokenList pop.
			  list asArray
			  ]
		  otherwise: [ 
				[ currentToken ] 
					unless: currentToken = $) 
					inWhichCase: [ SyntaxError signal: 'Unexpected )' ] ]
]

{ #category : #parsing }
SchemeParser >> parse: aProgramString [

	^ [ self buildASTRecursivelyFrom: ( self tokenize: aProgramString ) ] on: CollectionIsEmpty
		  do: [ :signal | SyntaxError signal: 'Missing )' ]
]

{ #category : #'private - tokenizing' }
SchemeParser >> tokenize: aProgramString [

	^ Stack withAll: ( ( RBScanner scanTokens: aProgramString ) collect: [ :token | 
			    token isString then: [ token asSymbol ] otherwise: [ token ] ] )
]
