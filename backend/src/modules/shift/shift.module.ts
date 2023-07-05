import { Module } from '@nestjs/common';
import { ShiftService } from './services/shift.service';
import { ShiftController } from './controllers/shift.controller';
import { Shift } from './entities/shift.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Shift])],
  controllers: [ShiftController],
  providers: [ShiftService],
})
export class ShiftModule {}
