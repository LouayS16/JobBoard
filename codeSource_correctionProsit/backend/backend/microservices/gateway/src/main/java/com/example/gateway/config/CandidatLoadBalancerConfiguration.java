package com.example.gateway.config;

import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.loadbalancer.core.RandomLoadBalancer;
import org.springframework.cloud.loadbalancer.core.ReactorLoadBalancer;
import org.springframework.cloud.loadbalancer.core.RoundRobinLoadBalancer;
import org.springframework.cloud.loadbalancer.core.ServiceInstanceListSupplier;
import org.springframework.cloud.loadbalancer.support.LoadBalancerClientFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.Environment;

/**
 * Configuration du Load Balancer personnalise pour le microservice 'candidat' (Partie 3 - Question 3).
 *
 * Cette configuration remplace l'algorithme par defaut (Round Robin) par l'algorithme Random
 * UNIQUEMENT pour le microservice 'candidat', conformement a la consigne de l'atelier :
 * "Chercher les autres types de load balancing existants puis ajouter la configuration
 *  necessaire pour tester l'algorithme Random en l'appliquant uniquement au service candidat".
 */
public class CandidatLoadBalancerConfiguration {

    @Bean
    public ReactorLoadBalancer<ServiceInstance> randomLoadBalancer(
            Environment environment,
            LoadBalancerClientFactory loadBalancerClientFactory) {
        String name = environment.getProperty(LoadBalancerClientFactory.PROPERTY_NAME);
        return new RandomLoadBalancer(
                loadBalancerClientFactory.getLazyProvider(name, ServiceInstanceListSupplier.class),
                name
        );
    }
}
