import { Module } from '@nestjs/common';
import { MedicinesService } from './services/medicine.service';
import { MedicinesController } from './controllers/medicine.controller';
import { Medicine } from './entities/medicine.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Medicine])],
  controllers: [MedicinesController],
  providers: [MedicinesService],
})
export class MedicinesModule {}
