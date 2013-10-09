import os
from flask import Flask, render_template, send_file
from flask.ext import restful
from config import Prod, Dev


class HelloWorld(restful.Resource):
    def get(self):
        return {'msg': 'hello world!'}


def listFiles(app, configs):
    result = []
    for dirpath, dirnames, filenames in os.walk(app.static_folder):
        for filename in [f for f in filenames if f.endswith(tuple(configs.keys()))]:
            name, extension = os.path.splitext(filename)
            config = configs[extension]
            file_config = config.copy()
            file_config['path'] = '/' + os.path.join(dirpath[len(app.root_path) + 1:], filename).replace('\\', '/')
            result.append(file_config)
    result.reverse()
    return result


def config_api(app):
    app.api.add_resource(HelloWorld, '/api/')


def partials(path):
    return send_file('partials/' + path)


def config_routing(app, config_env):
    scripts = listFiles(app, config_env.SCRIPTS_CONFIG)
    styles = listFiles(app, config_env.STYLES_CONFIG)

    def index(*args, **kwargs):
        options = {
            'scripts': scripts,
            'styles': styles,
            'lib_version_suffix': config_env.LIB_VERSION_SUFFIX
        }
        return render_template('index.jinja2', **options)

    app.add_url_rule('/partials/<path:path>', 'partials', partials)
    app.add_url_rule('/<path:path>', 'html5mode', index)
    app.add_url_rule('/', 'index', index)
    config_api(app)


def config_app(app, config_env):
    app.config.from_object(config_env)
    app.config.from_envvar('APP_CONFIG', silent=True)
    app.api = restful.Api(app)


def create_app(config_env=Prod):
    app = Flask(__name__)
    config_app(app, config_env)
    config_routing(app, config_env)
    return app


if __name__ == '__main__':
    app = create_app(Dev)
    app.run()