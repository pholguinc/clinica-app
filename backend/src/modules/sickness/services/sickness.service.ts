import { Sickness } from './../entities/sickness.entity';
import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateSicknessDto, UpdateSicknessDto } from '../dto/sickness.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class SicknessService {
  constructor(
    @InjectRepository(Sickness) private sicknessRepo: Repository<Sickness>,
  ) {}

  findAll() {
    return this.sicknessRepo.find();
  }

  async findOne(id: number) {
    const sickness = await this.sicknessRepo.findOneBy({ id });
    if (!sickness) {
      throw new NotFoundException(`Sickness #${id} not found`);
    }
    return sickness;
  }

  create(data: CreateSicknessDto) {
    const newSickness = this.sicknessRepo.create(data);
    return this.sicknessRepo.save(newSickness);
  }

  async update(id: number, changes: UpdateSicknessDto) {
    const sickness = await this.findOne(id);
    this.sicknessRepo.merge(sickness, changes);
    return this.sicknessRepo.save(sickness);
  }

  remove(id: number) {
    return this.sicknessRepo.delete(id);
  }
}
