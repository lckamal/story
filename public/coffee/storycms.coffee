root = @
$ = @jQuery
dispatcher = @Javie.make('event')

title = $('#title')

class Sluggable
	element: null
	constructor: (element) ->
		@element = element
	data: (key, value) ->
		@element.data(key, value)
	listen: ->
		return @element.data('listen')
	val: (str) ->
		@element.val(str)
	generate: (str) ->
		return '' if typeof str is 'undefined'

		str.toLowerCase()
			.replace('/^(_post_\/|_page_\/)/g', '')
			.replace('/[^\w\.]+/g', '-').replace('/ +/g', '-')
	handler: (str, update) ->
		str = @generate(str)
		update ?= false

		@val(str) if @listen() is yes and update

		null

slug = new Sluggable($('input[role="slug-editor"]:first'))

dispatcher.listen('storycms.update: slug', slug.handler)

if slug.val() is ''
	slug.data('listen', true)
	dispatcher.fire('storycms.update: slug', [title.val(), true])
else
	slug.data('listen', false)
	dispatcher.fire('storycms.update: slug', [slug.val(), true])

title.on('keyup', ->
	dispatcher.fire('storycms.update: slug', [title.val()])
	null
)

slug.on('blur', ->
	dispatcher.fire('storycms.update: slug', [slug.val(), true])
	null
)
