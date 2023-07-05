import { ConsultingRoom } from '../entities/consulting-room.entity';
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import {
  CreateConsultingRoomDto,
  UpdateConsultingRoomDto,
} from '../dto/consulting-room.dto';

@Injectable()
export class ConsultingRoomService {
  private counter = 0;

  constructor(
    @InjectRepository(ConsultingRoom)
    private consultingRoomRepo: Repository<ConsultingRoom>,
  ) {}

  findAll() {
    return this.consultingRoomRepo.find();
  }

  async findOne(id: number) {
    const conRoom = await this.consultingRoomRepo.findOneBy({ id });
    if (!conRoom) {
      throw new NotFoundException(`Consulting room #${id} not found`);
    }
    return conRoom;
  }

  async create(data: CreateConsultingRoomDto) {
    const newConsultingRoom = this.consultingRoomRepo.create(data);
    return this.consultingRoomRepo.save(newConsultingRoom);
  }

  async update(id: number, changes: UpdateConsultingRoomDto) {
    const user = await this.findOne(id);
    this.consultingRoomRepo.merge(user, changes);
    return this.consultingRoomRepo.save(user);
  }

  remove(id: number) {
    return this.consultingRoomRepo.delete(id);
  }
}
