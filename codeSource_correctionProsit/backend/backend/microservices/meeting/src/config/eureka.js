const { Eureka } = require('eureka-js-client');

function getEurekaClient(port) {
  return new Eureka({
    instance: {
      app: 'MEETING',
      instanceId: `localhost:meeting:${port}`,
      hostName: 'localhost',
      ipAddr: '127.0.0.1',
      statusPageUrl: `http://localhost:${port}/info`,
      healthCheckUrl: `http://localhost:${port}/health`,
      port: {
        '$': port,
        '@enabled': 'true',
      },
      vipAddress: 'MEETING',
      dataCenterInfo: {
        '@class': 'com.netflix.appinfo.InstanceInfo$DefaultDataCenterInfo',
        name: 'MyOwn',
      },
    },
    eureka: {
      host: 'localhost',
      port: 8761,
      servicePath: '/eureka/apps/',
      maxRetries: 10,
      requestRetryDelay: 2000,
    },
  });
}

module.exports = { getEurekaClient };
