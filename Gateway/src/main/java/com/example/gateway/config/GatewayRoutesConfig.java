package com.example.gateway.config;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Classe illustrant la configuration des routes en Java DSL avec RouteLocatorBuilder.
 *
 * Le workshop propose 2 approches pour definir les routes :
 * 1. Java DSL via RouteLocatorBuilder (@Bean)
 * 2. Proprietes externes via application.properties
 *
 * Cette classe met a disposition :
 * - gatewayRoutesStatic : configuration statique vers des adresses en dur (Partie 2 - Methode 1)
 * - gatewayRoutesDynamic : configuration dynamique avec lb:// via Eureka (Partie 3 - Methode 1)
 */
@Configuration
public class GatewayRoutesConfig {

    /**
     * Partie 2 - Methode 1 : Configuration Statique via classe Java
     * Activee si la propriete gateway.routing.mode=static-code est presente
     */
    @Bean
    @ConditionalOnProperty(name = "gateway.routing.mode", havingValue = "static-code")
    public RouteLocator gatewayRoutesStatic(RouteLocatorBuilder builder) {
        return builder.routes()
                .route("Candidat", r -> r.path("/candidats/**", "/candidat/**", "/mic1/**")
                        .uri("http://localhost:8081"))
                .route("Job", r -> r.path("/jobs/**", "/api/**")
                        .uri("http://localhost:8082"))
                .build();
    }

    /**
     * Partie 3 - Methode 1 : Configuration Dynamique via classe Java avec lb://
     * Activee si la propriete gateway.routing.mode=dynamic-code est presente
     */
    @Bean
    @ConditionalOnProperty(name = "gateway.routing.mode", havingValue = "dynamic-code")
    public RouteLocator gatewayRoutesDynamic(RouteLocatorBuilder builder) {
        return builder.routes()
                .route("candidat", r -> r.path("/candidat/**", "/candidats/**", "/mic1/**")
                        .uri("lb://candidat"))
                .route("job", r -> r.path("/jobs/**", "/api/**")
                        .uri("lb://job"))
                .build();
    }
}
