local new = function(
    name = "",
    image = "",
    tag = "",
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