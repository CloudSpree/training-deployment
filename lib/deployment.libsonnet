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
                pullSecrets: [
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