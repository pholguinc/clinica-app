import { Module } from '@nestjs/common';
import { DateService } from './services/date.service';
import { DateController } from './controllers/date.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppointmentDate } from './entities/date.entity';
import { User } from '../users/entities/user.entity';
import { ConsultingRoom } from '../consulting-room/entities/consulting-room.entity';

@Module({
  imports: [TypeOrmModule.forFeature([AppointmentDate, User, ConsultingRoom])],
  controllers: [DateController],
  providers: [DateService],
})
export class DateModule {}
