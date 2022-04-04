local new = function(
  hostname='',
  pathPrefix='/',
  service='',
  port=80,
  scheme='http',
  middlewares=[],
            ) {
  kind: 'Rule',
  match: std.format('Host(`%s`) && PathPrefix(`%s`)', [hostname, pathPrefix]),
  middlewares: [
    {
      name: i,
    }
    for i in middlewares
  ],
  services: [
    {
      kind: 'Service',
      name: service,
      port: port,
      scheme: scheme,
    },
  ],
};

{
  new: new,
}