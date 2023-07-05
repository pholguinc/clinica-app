import * as Joi from 'joi';

const configSchema = Joi.object({
  DB_NAME: Joi.string().required(),
  DB_PORT: Joi.number().required(),
  JWT_SECRET: Joi.string().required(),
});

export default configSchema;
