enum Environment {
  development,
  production,
}

//! adb reverse tcp:5001 tcp:5001
const String DEVELOPMENT_SERVER_URL = "https://localhost:5001/api";
const String PRODUCTION_SERVER_URL = "";
const String BASE_SERVER_URL = "baseServerUrl";
const Environment ENVIRONMENT = Environment.development;
const String JWT_KEY = 'jwt';

Map<dynamic, dynamic> config;

// Development setup
Map<dynamic, dynamic> devConstants = {
  BASE_SERVER_URL: DEVELOPMENT_SERVER_URL,
  ENVIRONMENT: Environment.development,
};

// Production setup
Map<dynamic, dynamic> prodConstants = {
  BASE_SERVER_URL: PRODUCTION_SERVER_URL,
  ENVIRONMENT: Environment.production,
};

void setEnvironment(Environment env) {
  switch (env) {
    case Environment.development:
      config = devConstants;
      break;
    case Environment.production:
      config = prodConstants;
      break;
  }
}
