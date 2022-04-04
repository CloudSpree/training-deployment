local _deployment = import '../../../lib/deployment.libsonnet';
local _service = import '../../../lib/service.libsonnet';
local _versions = import '../../../versions.json';
local _ingressRoute = import '../../../lib/ingressroute.libsonnet';
local _ingressRouteRule = import '../../../lib/ingressroute_rule.libsonnet';

[
    _deployment.new(
        name = 'settlements',
        image = "registry.digitalocean.com/cloudspree/settlements",
        tag = _versions.settlements,
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
    _ingressRoute.new(
        name = 'settlements',
        routes = [
            _ingressRouteRule.new(hostname='demo.dev.stepanvrany.cz', pathPrefix='/api/v1/settlements', service='settlements', port=80, middlewares=[]),
        ],
    ),
]