App.conversation = App.cable.subscriptions.create "ConversationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    conversation = $('#conversations-list').find('[data-conversation-id=\'' + data['conversation_id'] + '\']')
    if data['window'] != undefined
      conversation_visible = conversation.is(':visible')
      if conversation_visible
        messages_visible = conversation.find('.conversation-body').is(':visible')
        if !messages_visible
          highlight(conversation.find('.conversation__header'))
        conversation.find('.messages-list').find('ul').append data['message']
      else
        $('#conversations-list').append data['window']
        conversation = $('#conversations-list').find('[data-conversation-id=\'' + data['conversation_id'] + '\']')
        conversation.find('.conversation-body').toggle()
    else
      conversation.find('ul').append data['message']
    messages_list = conversation.find('.messages-list')
    height = messages_list[0].scrollHeight
    messages_list.scrollTop height
    return

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'submit', '.new_message', (e) ->
  e.preventDefault()
  values = $(this).serializeArray()
  App.conversation.speak values
  $(this).trigger 'reset'
  return
