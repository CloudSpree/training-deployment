local _rollout = import '../../../lib/rollout_bluegreen.libsonnet';
local _service = import '../../../lib/service.libsonnet';
local _versions = import '../../../versions.json';
local _ingressRoute = import '../../../lib/ingressroute.libsonnet';
local _ingressRouteRule = import '../../../lib/ingressroute_rule.libsonnet';

[
    _rollout.new(
        name = 'settlements',
        image = "registry.digitalocean.com/cloudspree/settlements",
        tag = _versions.settlements,
        activeService = "settlements",
        previewService = "settlements-preview",
        envSecrets = [
            "lightstep-token",
        ],
        envConfigMaps = [
            "environment-common",
        ],
    ),
    _service.new(
        name = 'settlements',
        selectorLabels = {
            'app': 'settlements',
        },
        ports = [
            {
                name: 'http',
                port: 80,
                targetPort: 8080,
            },
        ],
    ),
    _service.new(
        name = 'settlements-preview',
        selectorLabels = {
            'app': 'settlements',
        },
        ports = [
            {
                name: 'http',
                port: 80,
                targetPort: 8080,
            },
        ],
    ),
    _ingressRoute.new(
        name = 'settlements',
        routes = [
            _ingressRouteRule.new(hostname='app.dev.stepanvrany.cz', pathPrefix='/api/v1/settlements', service='settlements', port=80, middlewares=[]),
        ],
    ),
    _ingressRoute.new(
        name = 'settlements-preview',
        routes = [
            _ingressRouteRule.new(hostname='preview.dev.stepanvrany.cz', pathPrefix='/api/v1/settlements', service='settlements-preview', port=80, middlewares=[]),
        ],
    ),
]