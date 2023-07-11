import { Module } from '@nestjs/common';
import { DateService } from './services/date.service';
import { DateController } from './controllers/date.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Date } from './entities/date.entity';
import { User } from '../users/entities/user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Date, User])],
  controllers: [DateController],
  providers: [DateService]
})
export class DateModule {}
