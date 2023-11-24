# Makefile for Django projects

# Configuration
VENV_NAME = myenv
PYTHON = python
PIP = pip
SERVER_HOST = 0.0.0.0
SERVER_PORT = 8001

# Virtual environment setup
setup:
    @echo "Creating virtual environment..."
    $(PYTHON) -m venv $(VENV_NAME)
    @echo "Activating virtual environment..."
    source $(VENV_NAME)/bin/activate
    @echo "Installing dependencies..."
    $(PIP) install -r requirements.txt

# Django commands
migrate:
    @echo "Running migrations..."
    $(PYTHON) manage.py migrate

makemigrations:
    @echo "Creating new migrations..."
    $(PYTHON) manage.py makemigrations

run:
    @echo "Starting Django server..."
    $(PYTHON) manage.py runserver $(SERVER_HOST):$(SERVER_PORT)

test:
    @echo "Running tests..."
    $(PYTHON) manage.py test

# Database
reset_db:
    @echo "Resetting database..."
    $(PYTHON) manage.py flush --no-input

# Cleaning up
clean:
    @echo "Cleaning up..."
    find . -type f -name '*.pyc' -delete
    find . -type d -name '__pycache__' -delete
    rm -rf $(VENV_NAME)

# Utility rules
.PHONY: setup migrate makemigrations run test reset_db clean
