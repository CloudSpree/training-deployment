local _deployment = import '../../../lib/deployment.libsonnet';
local _versions = import '../../../versions.json';

[
    _deployment.new(
        name = 'notifications',
        image = "registry.digitalocean.com/cloudspree/notifications",
        tag = _versions.notifications,
    ),
]