local new = function(
    name = "",
    image = "",
    tag = "",
    envSecrets = [],
    envConfigMaps = [],
) {
    apiVersion: "apps/v1",
    kind: "Deployment",
    metadata: {
        name: name,
    },
    spec: {
        replicas: 1,
        strategy: {
            type: "RollingUpdate",
            rollingUpdate: {
                maxSurge: 1,
                maxUnavailable: 0,
            },
        },
        selector: {
            matchLabels: {
                app: name,
            },
        },
        template: {
            metadata: {
                labels: {
                    app: name,
                },
            },
            spec: {
                imagePullSecrets: [
                    {
                        name: "docker-cfg",
                    },
                ],
                containers: [
                    {
                        name: "app",
                        image: image + ":" + tag,
                        imagePullPolicy: "Always",
                        readinessProbe: {
                            httpGet: {
                                path: "/_health/ready",
                                port: 8080,
                            },
                            initialDelaySeconds: 20,
                            periodSeconds: 5,
                            timeoutSeconds: 1,
                        },
                        ports: [
                            {
                                containerPort: 8080,
                                name: "http",
                            },
                        ],
                        envFrom: []
                          + [
                                  {
                                    secretRef: {
                                      name: i,
                                    },
                                  }
                                  for i in envSecrets
                        ]
                        + [
                                {
                                  configMapRef: {
                                    name: i,
                                  },
                                }
                                for i in envConfigMaps
                              ]
                    },
                ]
            }
        }
    }
};

{
    new: new,
}