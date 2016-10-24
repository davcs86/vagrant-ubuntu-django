"""
Django settings for docker_django project.

Generated by 'django-admin startproject' using Django 1.8.1.

For more information on this file, see
https://docs.djangoproject.com/en/1.8/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.8/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
from os.path import join, abspath, normpath, dirname
import warnings

DEBUG = False
BASE_DIR = dirname(dirname(abspath(__file__)))
PROJECT_ROOT = dirname(abspath(__file__))
DATA_DIR = normpath(os.environ.get('DATA_DIR', join(BASE_DIR, '__data__')))

REDIS_HOST = 'database'
POSTGRES_HOST = os.environ.get('DB_SERVICE', 'database')
# MONGO_HOST = '127.0.0.1'
DB_NAME = os.environ.get('DB_NAME', 'default')

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.8/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.environ.get('SECRET_KEY', 'Q+%ik6z&!yer+ga9m=e%jcqAd21asdAFw2')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = os.environ.get('DEBUG', 'true').lower() == 'true'
STATIC_ROOT = os.environ.get('STATIC_ROOT', join(DATA_DIR, 'static'))
MEDIA_DIR = os.environ.get('MEDIA_DIR', join(DATA_DIR, 'media'))
DATABASE = os.environ.get('DATABASE', 'postgresql')

ALLOWED_HOSTS = ['*']


# Application definition

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    # apps
    'todo',
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.auth.middleware.SessionAuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.middleware.security.SecurityMiddleware',
)

ROOT_URLCONF = '_project_.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            join(PROJECT_ROOT, 'templates'),
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = '_project_.wsgi.application'


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': DB_NAME,
        'USER': os.environ['DB_USER'],
        'PASSWORD': os.environ['DB_PASS'],
        'HOST': POSTGRES_HOST,
        'PORT': os.environ['DB_PORT']
    }
}


# Internationalization
# https://docs.djangoproject.com/en/1.8/topics/i18n/

LANGUAGE_CODE = 'es-mx'

TIME_ZONE = 'America/Monterrey'

USE_I18N = True
USE_L10N = True

USE_TZ = False


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.8/howto/static-files/

MEDIA_URL = '/media/'
# DEFAULT_FILE_STORAGE = 'utils.gridfs.GridFSStorage'
STATIC_URL = '/static/'
STATICFILES_DIRS = (
    os.path.join(PROJECT_ROOT, 'static'),
)

# Celery
BROKER_TRANSPORT = 'redis'
CELERY_BROKER_TRANSPORT = BROKER_URL = 'redis://%s:6379/0' % REDIS_HOST
CELERY_RESULT_BACKEND = 'redis://%s:6379/0' % REDIS_HOST
CELERY_TIMEZONE = 'UTC'
CELERY_TASK_SERIALIZER = 'json'
CELERY_ACCEPT_CONTENT = ['json']  # Ignore other content
CELERY_RESULT_SERIALIZER = 'json'
CELERYBEAT_SCHEDULE_FILENAME = join(DATA_DIR, 'celerybeat.db')
CELERYBEAT_SCHEDULE = {}


try:
    from celery.schedules import crontab  # noqa
    from datetime import timedelta  # noqa
    CELERYBEAT_SCHEDULE = {
        'update_todo_viewers': {
            'task': 'todo.tasks.increase',
            'schedule': timedelta(minutes=1),
            'args': (15, )
        },
    }
except ImportError:
    warnings.warn('CELERYBEAT DON`T WORK: from celery.schedules import '
                  'crontab raise ImportError!')
