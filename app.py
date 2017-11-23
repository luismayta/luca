# -*- coding: utf-8 -*-
from sanic import Sanic
from sanic.request import RequestParameters
from sanic.response import json

app = Sanic(__name__)


@app.route('/', methods=['GET'])
async def verify(request):
    """ Verify Token.
    when the endpoint is registered as a webhook, it must echo back
    the 'hub.challenge' value it receives in the query arguments
    """
    query_params = RequestParameters()
    if not query_params:
        return json({'response': 'hacer > hablar'})

    if query_params.get('hub.verify_token') == 'hacker':
        return json({
            query_params.get('hub.challenge'),
        })
    return json({'Err, Token Invalid'})


@app.route('/', methods=['POST'])
async def webhook(request):
    messages = json(request.body)
    for entry in messages['entry']:
        for message in entry['messaging']:
            return json({'response': '{} o/'.format(message)})
    return json({'response': 'o/'})


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8000)
