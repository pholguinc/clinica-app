import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DatabaseModule } from './database/database.module';
import { ConsultingRoomModule } from './modules/consulting-room/consulting-room.module';
import { ShiftModule } from './modules/shift/shift.module';
import { ServiceModule } from './modules/service/service.module';
import { MedicinesModule } from './modules/medicines/medicine.module';
import { DateModule } from './modules/date/date.module';
import { SicknessModule } from './modules/sickness/sickness.module';
import config from './config/config';
import configSchema from './config/configSchema';
import { HistoryModule } from './modules/history/history.module';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './auth/auth.module';
import { DoctorsModule } from './modules/doctors/doctors.module';
import { TypeDateModule } from './modules/type-date/type-date.module';
@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: process.env.NODE_ENV || '.env',
      load: [config],
      isGlobal: true,
      validationSchema: configSchema,
    }),
    DatabaseModule,
    ConsultingRoomModule,
    ShiftModule,
    ServiceModule,
    MedicinesModule,
    DateModule,
    SicknessModule,
    HistoryModule,
    UsersModule,
    AuthModule,
    DoctorsModule,
    TypeDateModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
