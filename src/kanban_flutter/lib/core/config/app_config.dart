enum Environment {
  development,
  production,
}

//! adb reverse tcp:5001 tcp:5001
const String DEVELOPMENT_SERVER_URL = "https://localhost:5001/api";
const String BASE_SERVER_URL = "baseServerUrl";

Map<String, dynamic> config;

// Development setup
Map<String, dynamic> devConstants = {
  BASE_SERVER_URL: DEVELOPMENT_SERVER_URL,
};

// Production setup
Map<String, dynamic> prodConstants = {};

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
