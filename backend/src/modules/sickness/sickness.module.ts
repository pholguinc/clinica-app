import { Module } from '@nestjs/common';
import { SicknessService } from './services/sickness.service';
import { SicknessController } from './controllers/sickness.controller';
import { Sickness } from './entities/sickness.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Sickness])],
  controllers: [SicknessController],
  providers: [SicknessService],
})
export class SicknessModule {}
