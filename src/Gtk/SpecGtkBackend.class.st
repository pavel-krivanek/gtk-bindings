Class {
	#name : #SpecGtkBackend,
	#superclass : #SpApplicationBackend,
	#category : #'Gtk-Backend'
}

{ #category : #accessing }
SpecGtkBackend class >> backendName [
	
	^ #Gtk
]

{ #category : #private }
SpecGtkBackend >> adapterBindingsClass [

	^ GtkAdapterBindings
]

{ #category : #accessing }
SpecGtkBackend >> defer: aBlock [ 

	GtkRunLoop defer: aBlock
]

{ #category : #accessing }
SpecGtkBackend >> forceDefer: aBlock [ 

	GtkRunLoop forceDefer: aBlock
]

{ #category : #initialization }
SpecGtkBackend >> initialize [ 
	
	GtkApplication ensureRunning.	
	super initialize.

]

{ #category : #'ui notifying' }
SpecGtkBackend >> notifyError: aSpecNotification [

	GtkErrorDialog runMessage: aSpecNotification message
]

{ #category : #'ui notifying' }
SpecGtkBackend >> notifyInfo: aSpecNotification [

	GtkInformDialog runMessage: aSpecNotification message
]

{ #category : #'ui dialogs' }
SpecGtkBackend >> selectDirectoryTitle: aString [
	| dialog |

	dialog := GtkFileChooserDialog 
		newOpenDirectoryTitle: 'Select file...' 
		acceptLabel: 'Accept' 
		cancelLabel: 'Cancel'.
	dialog showAll; run.
	^ dialog isOk 
		ifTrue: [ dialog filename asFileReference ]
		ifFalse: [ nil ]
]

{ #category : #private }
SpecGtkBackend >> setCursor: cursor toAll: aCollection [ 

	aCollection do: [ :each | 
			each adapter widget gdkWindow cursor: cursor ].
]

{ #category : #ui }
SpecGtkBackend >> showWaitCursorWhile: aBlock inApplication: anApplication [

	self forceDefer: [
		self setCursor: GdkCursor newWait toAll: anApplication windows ]. 
	aBlock ensure: [ 
		self forceDefer: [ 
			self setCursor: GdkCursor null toAll: anApplication windows ] ]
]
