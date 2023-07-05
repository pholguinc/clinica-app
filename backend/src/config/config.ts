import { registerAs } from '@nestjs/config';

export default registerAs('config', () => {
  return {
    database: {
      name: process.env.DB_NAME,
      port: process.env.DB_PORT,
      password: process.env.DB_PASSWORD,
      user: process.env.DB_USERNAME,
      host: process.env.DB_HOST,
    },
    jwtSecret: process.env.JWT_SECRET,
    API_KEY: process.env.API_KEY,
  };
});
