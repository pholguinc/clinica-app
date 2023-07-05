import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateShiftDto } from '../dto/shift.dto';
import { UpdateShiftDto } from '../dto/shift.dto';
import { Shift } from '../entities/shift.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class ShiftService {
  constructor(@InjectRepository(Shift) private shiftRepo: Repository<Shift>) {}

  create(data: CreateShiftDto) {
    const newShift = this.shiftRepo.create(data);
    return this.shiftRepo.save(newShift);
  }

  findAll() {
    return this.shiftRepo.find();
  }

  async findOne(id: number) {
    const shift = await this.shiftRepo.findOneBy({ id });
    if (!shift) {
      throw new NotFoundException(`Service #${id} not found`);
    }
    return shift;
  }

  async update(id: number, changes: UpdateShiftDto) {
    const shift = await this.findOne(id);
    this.shiftRepo.merge(shift, changes);
    return this.shiftRepo.save(shift);
  }

  remove(id: number) {
    return this.shiftRepo.delete(id);
  }
}
