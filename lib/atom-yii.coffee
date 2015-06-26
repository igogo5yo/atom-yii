AtomYiiView = require './atom-yii-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomYii =
  atomYiiView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomYiiView = new AtomYiiView(state.atomYiiViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomYiiView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-yii:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomYiiView.destroy()

  serialize: ->
    atomYiiViewState: @atomYiiView.serialize()

  toggle: ->
    console.log 'AtomYii was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
