import { Module } from '@nestjs/common';
import { ConsultingRoomService } from './services/consulting-room.service';
import { ConsultingRoomController } from './controllers/consulting-room.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConsultingRoom } from './entities/consulting-room.entity';

@Module({
  imports: [TypeOrmModule.forFeature([ConsultingRoom])],
  controllers: [ConsultingRoomController],
  providers: [ConsultingRoomService],
  exports: [ConsultingRoomService, TypeOrmModule],
})
export class ConsultingRoomModule {}
