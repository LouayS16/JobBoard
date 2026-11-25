const app = require('./app');
const { getEurekaClient } = require('./config/eureka');

const PORT = parseInt(process.env.PORT || '8083', 10);

const eurekaClient = getEurekaClient(PORT);

const server = app.listen(PORT, () => {
  console.log(`meeting microservice running on http://localhost:${PORT}`);
  console.log(`Swagger UI: http://localhost:${PORT}/swagger-ui`);

  eurekaClient.start((error) => {
    if (error) {
      console.error('Failed to register with Eureka:', error);
    } else {
      console.log('Successfully registered with Eureka!');
    }
  });
});

// Graceful shutdown
function gracefulShutdown() {
  console.log('\nShutting down meeting service...');
  eurekaClient.stop((error) => {
    if (error) {
      console.error('Error deregistering from Eureka:', error);
    } else {
      console.log('Successfully deregistered from Eureka');
    }
    server.close(() => {
      process.exit(0);
    });
  });
}

process.on('SIGINT', gracefulShutdown);
process.on('SIGTERM', gracefulShutdown);
