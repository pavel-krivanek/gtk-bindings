Extension { #name : #SpMultipleSelectionMode }

{ #category : #'*Spec-Gtk' }
SpMultipleSelectionMode >> unsubscribeOuterContextReceiver: anObject [ 

	(self observablePropertyNamed: #selectedIndex) unsubscribeOuterContextReceiver: anObject.
]
