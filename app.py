# -*- coding: utf-8 -*-
from chalice import Chalice
from chalice import UnauthorizedError

from chalicelib import APP_NAME
from chalicelib import APP_VERIFY_TOKEN
from chalicelib import RESPONSE_MESSAGE

app = Chalice(app_name=APP_NAME)


@app.route('/', methods=['GET'])
def verify():
    """ Verify Token.
    when the endpoint is registered as a webhook, it must echo back
    the 'hub.challenge' value it receives in the query arguments

    """
    request = app.current_request
    if not request.query_params:
        return {'response': RESPONSE_MESSAGE}

    if request.query_params.get('hub.verify_token') == APP_VERIFY_TOKEN:
        return {
            request.query_params.get('hub.challenge'),
        }
    else:
        return UnauthorizedError('Err, Token Invalid')


@app.route('/', methods=['POST'])
def webhook():
    request = app.current_request
    messages = request.json_body
    for entry in messages['entry']:
        for message in entry['messaging']:
            return {'response': 'o/'}
    return {'response': 'o/'}
