local new = function(
    name = "",
    image = "",
    tag = "",
    activeService = "",
    previewService = "",
    envSecrets = [],
    envConfigMaps = [],
) {
    apiVersion: "argoproj.io/v1alpha1",
    kind: "Rollout",
    metadata: {
        name: name,
    },
    spec: {
        replicas: 1,
        revisionHistoryLimit: 2,
        selector: {
            matchLabels: {
                app: name,
            },
        },
        strategy: {
            blueGreen: {
                activeService: activeService,
                previewService: previewService,
                autoPromotionEnabled: false,
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