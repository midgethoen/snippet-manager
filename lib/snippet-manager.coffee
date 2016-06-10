SnippetManagerView = require './snippet-manager-view'
{CompositeDisposable} = require 'atom'

module.exports = SnippetManager =
  snippetManagerView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @snippetManagerView = new SnippetManagerView(state.snippetManagerViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @snippetManagerView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'snippet-manager:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @snippetManagerView.destroy()

  serialize: ->
    snippetManagerViewState: @snippetManagerView.serialize()

  toggle: ->
    console.log 'SnippetManager was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
