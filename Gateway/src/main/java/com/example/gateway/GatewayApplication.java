package com.example.gateway;

import com.example.gateway.config.CandidatLoadBalancerConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.loadbalancer.annotation.LoadBalancerClient;

/**
 * Classe principale de l'API Gateway.
 *
 * Annotations :
 * - @SpringBootApplication : configure et initialise le contexte Spring Boot.
 * - @EnableDiscoveryClient : enregistre l'API Gateway auprès du serveur Eureka (Partie 1 & Partie 3).
 * - @LoadBalancerClient : configure l'algorithme RandomLoadBalancer spécifiquement pour le microservice 'candidat' (Partie 3 - Question 3).
 */
@SpringBootApplication
@EnableDiscoveryClient
@LoadBalancerClient(name = "candidat", configuration = CandidatLoadBalancerConfiguration.class)
public class GatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(GatewayApplication.class, args);
    }

    /**
     * Alternative de configuration des routes en code Java après la méthode main
     * (conforme aux consignes de l'atelier).
     *
     * Note : Les routes dynamiques sont actuellement actives via application.properties.
     * Pour basculer sur cette méthode Java, il suffit de décommenter le @Bean ci-dessous.
     */
    /*
    @Bean
    public RouteLocator gatewayRoutes(RouteLocatorBuilder builder) {
        return builder.routes()
                // --- Approche 1 : Configuration Statique (Partie 2) ---
                // .route("candidat-static", r -> r.path("/candidat/**", "/candidats/**", "/mic1/**").uri("http://localhost:8081"))
                // .route("job-static", r -> r.path("/jobs/**", "/api/**").uri("http://localhost:8082"))

                // --- Approche 2 : Configuration Dynamique avec Eureka (Partie 3) ---
                .route("candidat-dynamic", r -> r.path("/candidat/**", "/candidats/**", "/mic1/**").uri("lb://candidat"))
                .route("job-dynamic", r -> r.path("/jobs/**", "/api/**").uri("lb://job"))
                .build();
    }
    */
}
