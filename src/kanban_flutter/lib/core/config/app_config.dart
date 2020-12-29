enum Environment {
  Development,
  Production,
}

//! adb reverse tcp:5001 tcp:5001
const String DEVELOPMENT_SERVER_URL = "https://localhost:5001/api";
const String PRODUCTION_SERVER_URL = "https://kanbanboardsapi.azurewebsites.net/api";
const String BASE_SERVER_URL = "baseServerUrl";
const Environment ENVIRONMENT = Environment.Development;
const String JWT_TOKEN = 'token';
const String JWT_REFRESH_TOKEN = 'refreshToken';

Map<dynamic, dynamic> config;

// Development setup
Map<dynamic, dynamic> devConstants = {
  BASE_SERVER_URL: DEVELOPMENT_SERVER_URL,
  ENVIRONMENT: Environment.Development,
};

// Production setup
Map<dynamic, dynamic> prodConstants = {
  BASE_SERVER_URL: PRODUCTION_SERVER_URL,
  ENVIRONMENT: Environment.Production,
};

void setEnvironment(Environment env) {
  switch (env) {
    case Environment.Development:
      config = devConstants;
      break;
    case Environment.Production:
      config = prodConstants;
      break;
  }
}
