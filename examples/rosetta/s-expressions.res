[ :inline
	[ :inline
		data :word
		quoted data :string
		123 :integer
		4.5 :floating
	]
	[ :inline
		data :word
		[ :inline
			<exclamation> :symbol
			<at> :symbol
			<sharp> :symbol
			[ :inline
				4.5 :floating
			]
			(more :string
			data) :string
		]
	]
]
((data "quoted data" 123 4.5) (data (! @ # (4.5) "(more" "data)")))