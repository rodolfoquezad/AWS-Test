# AWS-Test


Justificacion para el uso EC2 y RDS

Dado que no esto es solo una prueba opte por utilizar EC2 tomando en cuenta los costos ya que puedo utilizar la opción gratis y realizar cualquier despliegue ahí sin problemas.

Para la base de datos utilice RDS por la facilidad que tiene para integrarse con servicios dentro de AWS, no considere apropiado invertir mas tiempo en esta area dada la complejidad de la tarea.

Para la gestion de los archivos de terraform, opte por incluir los statefiles en un archivo .gitignore para evitar compartirlos en el repositorio.


1. Funcionamiento del Sistema
El proyecto implementa una infraestructura en AWS que consta de:

Instancia EC2: Servidor Linux (t2.micro) con Amazon Linux 2 AMI

Base de datos RDS: Instancia PostgreSQL (db.t3.micro)

Conectividad: La EC2 puede comunicarse con RDS a través de un grupo de seguridad configurado

El flujo de funcionamiento es:

Terraform despliega los recursos usando módulos para EC2 y RDS

La EC2 ejecuta un script de inicio (bash_inicio.sh) que:

Instala Docker

Descarga una imagen de ECR (aws-test:latest)

Ejecuta un contenedor con la aplicación PHP en puertos 80 y 8080

La aplicación PHP:

Muestra una página "Hola Mundo"

Registra visitas en la base de datos PostgreSQL

Maneja errores de conexión

2. Beneficios de la Implementación Actual
2.1 Infraestructura como Código
Reproducibilidad: La infraestructura puede recrearse idénticamente en cualquier momento

Control de versiones: Todos los cambios quedan registrados en el repositorio

Modularidad: Separación clara entre componentes (EC2 y RDS)

2.2 Seguridad
Grupos de seguridad bien definidos:

EC2: Acceso solo a puertos 22 (SSH), 80 (HTTP) y 8080 (VS Code)

RDS: Solo acepta conexiones desde la EC2 (puerto 5432)

Credenciales manejadas como variables sensibles en Terraform

2.3 Escalabilidad
Diseño preparado para escalar horizontalmente (añadir más instancias EC2)

RDS puede escalarse verticalmente cambiando el tipo de instancia

2.4 Monitoreo Básico
La aplicación registra todas las visitas (IP, user agent, timestamp)

3. Posibles Mejoras
3.1 Seguridad Mejorada
Implementar AWS Secrets Manager para credenciales en lugar de variables

Restringir acceso SSH (actualmente abierto a 0.0.0.0/0)

Usar HTTPS con certificados ACM para tráfico web

Implementar WAF para protección contra ataques web

3.2 Alta Disponibilidad
Configurar múltiples instancias EC2 en diferentes AZs

Implementar un Application Load Balancer

Configurar RDS Multi-AZ para failover automático

3.3 Automatización y CI/CD
Integrar con GitHub Actions/GitLab CI para despliegues automáticos

Implementar blue-green deployments para actualizaciones sin downtime

Automatizar pruebas de infraestructura con Terratest

3.4 Monitoreo y Alertas
Implementar CloudWatch para métricas y logs

Configurar alertas para uso de CPU, memoria y conexiones a BD

Agregar Health Checks para la aplicación

3.5 Optimización de Costos
Usar instancias Spot para cargas de trabajo tolerantes a fallos

Implementar auto-scaling basado en demanda

Configurar paradas automáticas para entornos de desarrollo

4. Conclusión
La implementación actual proporciona una base sólida para una aplicación web simple con persistencia de datos. El uso de Terraform asegura que la infraestructura sea consistente y reproducible. Las principales áreas de mejora están en seguridad, alta disponibilidad y automatización de despliegues. Implementar estas mejoras convertiría este proyecto en una solución más robusta y lista para producción.