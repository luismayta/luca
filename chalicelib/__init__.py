# -*- coding: utf-8 -*-
import ast
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# Application
APP_NAME = os.environ.get('APP_NAME')
APP_DEBUG = ast.literal_eval(os.environ.get('APP_DEBUG', 'False'))
APP_VERIFY_TOKEN = os.environ.get('APP_VERIFY_TOKEN')
RESPONSE_MESSAGE = 'Hacer > Hablar'
