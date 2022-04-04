local new = function(
    name = "",
    image = "",
    tag = "",
    activeService = "",
    previewService = "",
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
                    },
                ]
            }
        }
    }
};

{
    new: new,
}