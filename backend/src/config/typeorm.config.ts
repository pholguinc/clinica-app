import {
  TypeOrmModuleAsyncOptions,
  TypeOrmModuleOptions,
} from '@nestjs/typeorm';

import config from './config';
import { ConfigType } from '@nestjs/config';

export const typeOrmAsyncConfig: TypeOrmModuleAsyncOptions = {
  inject: [config.KEY],
  useFactory: async (
    configService: ConfigType<typeof config>,
  ): Promise<TypeOrmModuleOptions> => {
    const { user, name, port, password, host } = configService.database;
    return {
      type: 'postgres',
      host,
      port: +port,
      username: user,
      password,
      database: name,
      synchronize: false, //false in migrations
      autoLoadEntities: true,
    };
  },
};
