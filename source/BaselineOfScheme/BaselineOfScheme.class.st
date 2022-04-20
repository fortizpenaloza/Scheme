"
Baseline of Scheme
"
Class {
	#name : #BaselineOfScheme,
	#superclass : #BaselineOf,
	#category : #BaselineOfScheme
}

{ #category : #baselines }
BaselineOfScheme >> baseline: spec [

	<baseline>
	spec for: #pharo do: [ 
		self
			setUpDependencies: spec;
			setUpPackages: spec.

		spec
			group: 'CI' with: 'Tests';
			group: 'Development' with: #( 'Tests' )
		]
]

{ #category : #accessing }
BaselineOfScheme >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #baselines }
BaselineOfScheme >> setUpDependencies: spec [

	spec
		baseline: 'Buoy' with: [ spec repository: 'github://ba-st/Buoy:v6' ];
		project: 'Buoy-Deployment' copyFrom: 'Buoy' with: [ spec loads: 'Deployment' ];
		project: 'Buoy-SUnit' copyFrom: 'Buoy' with: [ spec loads: 'Dependent-SUnit-Extensions' ]
]

{ #category : #baselines }
BaselineOfScheme >> setUpPackages: spec [

	spec
		package: 'Scheme-Model' with: [ spec requires: 'Buoy-Deployment' ];
		group: 'Deployment' with: 'Scheme-Model';
		package: 'Scheme-Tests' with: [ spec requires: #( 'Scheme-Model' 'Buoy-SUnit' ) ];
		group: 'Tests' with: 'Scheme-Tests'
]
