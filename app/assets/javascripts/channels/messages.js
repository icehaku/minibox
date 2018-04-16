//= require cable
//= require_self

(function() {
    App.messages = App.cable.subscriptions.create('MessagesChannel', {
        received: function(message) {
            var $messages = $('.messages');
            var $message = $('[data-message-id="' + message.id + '"]', $messages);
            if ($message.length > 0) {
                switch (message.status) {
                    case 'saved':
                        $message.replaceWith(message.html);
                        break;
                    case 'deleted':
                        $message.remove();
                        break;
                }
            } else {
                $messages.prepend(message.html);
            }
        }
    });
}).call(this);
