local new = function(
  name = '',
  selectorLabels = {},
  ports = [],
            ) {
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: name,
    labels: selectorLabels,
  },
  spec: {
    type: 'ClusterIP',
    ports: ports,
    selector: selectorLabels,
  },

  name:: name,
};

{
  new: new,
}