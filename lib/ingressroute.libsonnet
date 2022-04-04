local new = function(
  name='',
  routes=[],
  entrypoints=['web', 'websecure'],
            ) {
  apiVersion: 'traefik.containo.us/v1alpha1',
  kind: 'IngressRoute',
  metadata: {
    name: name,
  },
  spec: {
    entryPoints: entrypoints,
    routes: routes,
  },
};

{
  new: new,
}