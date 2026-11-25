# TP 2 – Observabilité avec Spring Boot Actuator

## Présentation
Ce TP porte sur l'observabilité des microservices avec Spring Boot Actuator, la publication de leur état dans Eureka et l'exposition de points de contrôle pour les services non-Spring.

## Microservices concernés
| Microservice | Port | Observabilité / contrôle |
|---|---:|---|
| Candidat | 8081 | Actuator : `health`, `info`, `metrics`, `loggers` |
| Job (nom affiché dans Eureka : EMPLOI) | 8082 | Actuator, état de la base de données et `CustomJobHealthIndicator` |
| Meeting | 8083 | `GET /health` et `GET /info`, URLs déclarées dans Eureka |
| Notification | 8084 | `GET /health` et `GET /info`, URLs déclarées dans Eureka |
| Candidature (nom technique : `canditature`) | 8085 | Actuator : `health`, `info`, `metrics`, client Eureka |

Eureka Server : `http://localhost:8761`

## Configurations principales

### Spring Boot – Candidat, Job et Candidature
Les endpoints exposés comprennent :
```properties
management.endpoints.web.exposure.include=health,info,metrics
management.endpoint.health.show-details=always
eureka.client.healthcheck.enabled=true
management.info.env.enabled=true
```

Les métadonnées applicatives sont définies avec `info.app.name`, `info.app.version` et `info.app.description`.

### Meeting – Node.js
- `GET /health` retourne l'état de santé.
- `GET /info` retourne le nom et la version du service.
- Eureka référence `/health` comme health check et `/info` comme status page.

### Notification – FastAPI
- `GET /health` retourne l'état de santé.
- `GET /info` retourne le nom et la version du service.
- Le client Eureka référence ces deux URLs.

## Vérifications réalisées

### 1. Santé et enregistrement Eureka
Les tests rapportés pendant la réalisation ont confirmé le démarrage des services et leur enregistrement auprès d'Eureka. Les captures incluses montrent notamment :
- les services enregistrés à l'état UP ;
- le passage de `EMPLOI` à DOWN lorsque MySQL est arrêté ;
- le retour de `JOB` à UP après redémarrage.

### 2. HealthIndicator personnalisé de Job
Un `CustomJobHealthIndicator` contrôle l'accès à la base de données via un `DataSource`. Lorsque la connexion à la base échoue, l'indicateur retourne DOWN ; lorsque la base est accessible, il retourne UP.

### 3. Analyse des métriques HTTP de Candidat
Résultat obtenu pour :
`GET http://localhost:8081/actuator/metrics/http.server.requests`

| Mesure | Valeur |
|---|---:|
| COUNT | 5 |
| TOTAL_TIME | 0.1694985 s |
| MAX | 0.0836664 s |

Résultat obtenu avec le filtre :
`GET http://localhost:8081/actuator/metrics/http.server.requests?tag=status:200`

| Mesure | Valeur |
|---|---:|
| COUNT | 3 |
| TOTAL_TIME | 0.0638439 s |
| MAX | 0.0522165 s |

Le filtre `tag=status:200` conserve les mesures associées aux réponses HTTP 200.

## Captures d'écran
Les captures utilisées dans le PDF sont également disponibles dans le dossier [`captures/`](captures/).

1. `captures/capture_01.png` – Eureka : services UP.
2. `captures/capture_02.png` – Eureka : EMPLOI DOWN lorsque MySQL est arrêté.
3. `captures/capture_03.png` – Eureka : JOB UP après redémarrage.
4. `captures/capture_04.png` – Métriques HTTP de Candidat.
5. `captures/capture_05.png` – Métriques HTTP filtrées par status 200.

## À compléter avant le dépôt final
- Ajouter les noms et prénoms de tous les membres de l'équipe.
- Vérifier que les captures complémentaires demandées par l'enseignant (Actuator `/health`, `/info`, `/metrics`, Meeting et Notification) sont ajoutées si elles sont exigées individuellement.
- Vérifier le dépôt Git, puis effectuer le commit et le push final.

> Remarque : les valeurs COUNT, TOTAL_TIME et MAX sont celles observées pendant la session de test ; elles peuvent varier après de nouvelles requêtes.
