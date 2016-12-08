from __future__ import absolute_import, print_function

import json
import os
import sys

import requests
from flask import Flask, request

app = Flask(__name__)
RESPONSE_MESSAGE = 'Deja de hablar y comienza a actuar'


@app.route('/', methods=['GET'])
def verify():
    """ Verify Token.
    when the endpoint is registered as a webhook, it must echo back
    the 'hub.challenge' value it receives in the query arguments

    """
    if request.args.get('hub.mode') == 'subscribe' and request.args.get('hub.challenge'):
        if not request.args.get('hub.verify_token') == os.environ['VERIFY_TOKEN']:
            return 'Verification token mismatch', 403
        return request.args['hub.challenge'], 200

    return 'Hello world', 200


@app.route('/', methods=['POST'])
def webhook():

    # endpoint for processing incoming messaging events

    data = request.get_json()
    log(data)  # you may not want to log every incoming message in production, but it's good for testing

    if data['object'] == 'page':

        for entry in data['entry']:
            for messaging_event in entry['messaging']:

                if messaging_event.get('message'):  # someone sent us a message

                    sender_id = messaging_event['sender']['id']        # the facebook ID of the person sending you the message
                    recipient_id = messaging_event['recipient']['id']  # the recipient's ID, which should be your page's facebook ID
                    message_text = messaging_event['message']['text']  # the message's text
                    kwargs = {
                        'sender': sender_id,
                        'recipient': recipient_id,
                        'message': message_text,
                    }

                    send_message(
                        **kwargs
                    )

                if messaging_event.get('delivery'):  # delivery confirmation
                    pass

                if messaging_event.get('optin'):  # optin confirmation
                    pass

                if messaging_event.get('postback'):  # user clicked/tapped "postback" button in earlier message
                    pass

    return 'ok', 200


def send_message(*args, **kwargs):
    # sender = kwargs.get('sender')
    recipient = kwargs.get('recipient')
    # message = kwargs.get('message')
    log_message = [
        'sender -> {sender}',
        'recipient -> {recipient}',
        'message -> {message}',
    ]

    log(
        ' '.join(log_message).format(
            **kwargs
        )
    )

    log(
        'sending message to {recipient}: {text}'.format(
            recipient=recipient,
            text=RESPONSE_MESSAGE
        )
    )

    params = {
        'access_token': os.environ['PAGE_ACCESS_TOKEN']
    }
    headers = {
        'Content-Type': 'application/json'
    }
    data = json.dumps({
        'recipient': {
            'id': recipient
        },
        'message': {
            'text': RESPONSE_MESSAGE
        }
    })
    response = requests.post(
        'https://graph.facebook.com/v2.6/me/messages',
        params=params,
        headers=headers,
        data=data
    )
    if response.status_code != 200:
        log(response.status_code)
        log(response.text)


def log(message):  # simple wrapper for logging to stdout on heroku
    print(str(message))
    sys.stdout.flush()


if __name__ == '__main__':
    app.run(debug=True)
