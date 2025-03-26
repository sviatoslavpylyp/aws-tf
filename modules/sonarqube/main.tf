resource "helm_release" "sonarqube" {
    name = "sonarqube"
    repository = "https://SonarSource.github.io/helm-chart-sonarqube"
    chart = "sonarqube"
    version = "10.8.1"
    create_namespace = true
    namespace = "sonarqube"

    values = [ 
        templatefile("${path.module}/template/values.yaml", {})
     ]
}
