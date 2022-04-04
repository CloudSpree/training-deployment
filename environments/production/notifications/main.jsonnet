local _deployment = import '../../../lib/deployment.libsonnet';
local _service = import '../../../lib/service.libsonnet';
local _versions = import '../../../versions.json';
local _ingressRoute = import '../../../lib/ingressroute.libsonnet';
local _ingressRouteRule = import '../../../lib/ingressroute_rule.libsonnet';

[
    _deployment.new(
        name = 'notifications',
        image = "registry.digitalocean.com/cloudspree/notifications",
        tag = _versions.notifications,
    ),
    _service.new(
        name = 'notifications',
        selectorLabels = {
            'app': 'notifications',
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
        name = 'notifications',
        routes = [
            _ingressRouteRule.new(hostname='app.dev.stepanvrany.cz', pathPrefix='/api/v1/notifications', service='notifications', port=80, middlewares=[]),
        ],
    ),
]