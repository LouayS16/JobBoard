package com.awd.job.health;

import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.Connection;

@Component
public class CustomJobHealthIndicator implements HealthIndicator {

    private final DataSource dataSource;

    public CustomJobHealthIndicator(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Health health() {
        try (Connection connection = dataSource.getConnection()) {
            return Health.up()
                    .withDetail("database", "Base de données accessible")
                    .build();
        } catch (Exception e) {
            return Health.down(e)
                    .withDetail("database", "Base de données inaccessible")
                    .build();
        }
    }
}
