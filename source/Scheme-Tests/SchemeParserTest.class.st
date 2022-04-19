Class {
	#name : #SchemeParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Scheme-Tests'
}

{ #category : #tests }
SchemeParserTest >> testParseBoolean [

	self
		assert: ( parser parse: 'true' );
		deny: ( parser parse: 'false' )
]

{ #category : #tests }
SchemeParserTest >> testParseEmptyList [

	self assert: ( parser parse: '()' ) equals: #(  )
]

{ #category : #tests }
SchemeParserTest >> testParseExpression [

	self assert: ( parser parse: '(define r 10)' ) equals: #( #define #r 10 )
]

{ #category : #tests }
SchemeParserTest >> testParseFloat [

	self
		assert: ( parser parse: '12.33' ) equals: 12.33;
		assert: ( parser parse: '-12.33' ) equals: -12.33
]

{ #category : #tests }
SchemeParserTest >> testParseInteger [

	self
		assert: ( parser parse: '12' ) equals: 12;
		assert: ( parser parse: '-12' ) equals: -12
]

{ #category : #tests }
SchemeParserTest >> testParseIsNull [

	self assert: ( parser parse: '(isNull (cons (quote a) ()))' )
		equals: #( #isNull #( #cons #( #quote #a ) #(  ) ) )
]

{ #category : #tests }
SchemeParserTest >> testParseLambda [

	self assert: ( parser parse: '(define squared (lambda (x) (* x x)))' )
		equals: #( #define #squared #( #lambda #( #x ) #( #* #x #x ) ) )
]

{ #category : #tests }
SchemeParserTest >> testParseProgram [

	self assert: ( parser parse: '(begin (define r 10) (* pi (* r r)))' )
		equals: #( #begin #( #define #r 10 ) #( #* #pi #( #* #r #r ) ) )
]

{ #category : #tests }
SchemeParserTest >> testParseSymbol [

	self assert: ( parser parse: 'r' ) equals: #r
]

{ #category : #tests }
SchemeParserTest >> testParseSyntaxError [

	self should: [ parser parse: ')' ] raise: SyntaxError withMessageText: 'Unexpected )'.
	self should: [ parser parse: '(()' ] raise: SyntaxError withMessageText: 'Missing )'.
	self should: [ parser parse: '(' ] raise: SyntaxError withMessageText: 'Missing )'.
	self should: [ parser parse: '(* 1 2' ] raise: SyntaxError withMessageText: 'Missing )'.
	self should: [ parser parse: '' ] raise: SyntaxError withMessageText: 'Unexpected EOF'
]
