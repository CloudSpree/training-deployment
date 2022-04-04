local _deployment = import '../../../lib/deployment.libsonnet';
local _service = import '../../../lib/service.libsonnet';
local _versions = import '../../../versions.json';
local _ingressRoute = import '../../../lib/ingressroute.libsonnet';
local _ingressRouteRule = import '../../../lib/ingressroute_rule.libsonnet';

[
    _deployment.new(
        name = 'provider',
        image = "registry.digitalocean.com/cloudspree/provider",
        tag = _versions.provider,
    ),
    _service.new(
        name = 'provider',
        selectorLabels = {
            'app': 'provider',
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
        name = 'provider',
        routes = [
            _ingressRouteRule.new(hostname='app.dev.stepanvrany.cz', pathPrefix='/api/v1/provider', service='provider', port=80, middlewares=[]),
        ],
    ),
]