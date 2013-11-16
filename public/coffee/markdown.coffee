root = @
@Javie.bind('markdown-editor', -> new Editor)

markdown_editor = ($) ->
	if $('textarea').size() > 0
		editor = root.Javie.make('markdown-editor')
		editor.render()

@jQuery(markdown_editor)
