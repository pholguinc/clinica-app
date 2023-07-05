import { Module } from '@nestjs/common';
import { DateService } from './services/date.service';
import { DateController } from './controllers/date.controller';

@Module({
  controllers: [DateController],
  providers: [DateService]
})
export class DateModule {}
