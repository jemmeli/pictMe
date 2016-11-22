#Liste de constantes utilisées sur l'app
REDIS_URL_VAR = "REDIS_URL"

#CSV
CSV_EXTENSION = ".csv"
CSV_SEPARATOR = ";"
IMAGE_HEIGHT = 1024
IMAGE_WIDTH = 1024

#mail
MAIL_REGEX = /^(\S+)@(\S+)\.(\w+)$/
PHONE_REGEX = /^(((\+?\s?\d{2}\s?\d)|(0\d))\s?\d{2}\s?\d{2}\s?\d{2}\s?\d{2})?$/

SMS_MAX_NAME_LENGHT = 15
SMS_LENGHT = 160

#AWS
AWS_ROOT = "http://s3-eu-west-1.amazonaws.com/"
KAPP10_BUCKET_NAME = ENV['S3_BUCKET']
KAPP10_BUCKET_ROOT = AWS_ROOT + KAPP10_BUCKET_NAME+ "/"

#SMS
SMS_LOGIN = ENV['ALLMYSMS_LOGIN']
SMS_API_KEY = ENV['ALLMYSMS_API_KEY']
SENDER_SMS = 'Kapp10'
SMS_PATH = 'https://api.allmysms.com/http/9.0/sendSms/'

#URL shortener
BITLY_LOGIN = ENV['BITLY_LOGIN']
BITLY_API_KEY = ENV['BITLY_API_KEY']

#constantes pour Messenger
MESSENGER_MESSAGE_LENGTH = 320
#expiration time of the saved WIT context in redis for a user (in seconds)
CONTEXT_EXPIRATION_TIME = 300
CONTEXT_EXPIRATION_TIME_LONG = 3000
RANDOM_KEY_MAX = 4
MAX_QUICK_REPLIES_COUNT = 11

# nombre de tentative de reconnexion en cas d'echec
FAIL_RETRY_LIMIT = 5
# délai d'attente avant une nouvelle tentative de connexion (en secondes)
FAIL_SLEEP_DELAY = (rand(1..5)).seconds

#Facebook & Messenger
DEFAULT_FACEBOOK_LOCALE = 'fr'
FACEBOOK_USER_FIELDS = 'first_name,last_name,locale,email'
MESSENGER_AUDIO = 'audio'
MESSENGER_TIME_PREFIX = '_seq_'

#Messenger callback payloads
TEXT = 'text'
MIN = 'min'
MAX = 'max'

#nombre maximal d'erreur permise
MAX_ERRORS = 1

MMS_TYPE_IMAGE = 'image'

