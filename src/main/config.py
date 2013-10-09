class Prod(object):
    DEBUG = False

    SCRIPTS_CONFIG = {
        '.js': {
            'type': 'text/javascript',
        }
    }
    STYLES_CONFIG = {
        '.css': {
            'type': 'text/css',
            'rel': 'stylesheet'
        }
    }
    LIB_VERSION_SUFFIX = '.min'


class Dev(Prod):
    DEBUG = True

    SCRIPTS_CONFIG = {
        '.js': {
            'type': 'text/javascript',
        },
        '.coffee': {
            'type': 'text/coffeescript',
        }
    }

    STYLES_CONFIG = {
        '.css': {
            'type': 'text/css',
            'rel': 'stylesheet'
        },
        '.less': {
            'type': 'text/css',
            'rel': 'stylesheet/less'
        }
    }
    LIB_VERSION_SUFFIX = ''
