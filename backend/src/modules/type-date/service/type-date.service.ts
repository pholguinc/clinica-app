import { Injectable, NotFoundException } from '@nestjs/common';
import {
  CreateTypeDateDto,
  UpdateTypeDateDto,
} from '../dto/create-type-date.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeDate } from '../entities/type-date.entity';
import { Repository } from 'typeorm';

@Injectable()
export class TypeDateService {
  constructor(
    @InjectRepository(TypeDate)
    private typeDateRepo: Repository<TypeDate>,
  ) {}

  async create(data: CreateTypeDateDto) {
    const newService = this.typeDateRepo.create(data);
    return this.typeDateRepo.save(newService);
  }

  async findOne(id: number) {
    const typeDate = await this.typeDateRepo.findOneBy({ id });
    if (!typeDate) {
      throw new NotFoundException(`type Date #${id} not found`);
    }
    return typeDate;
  }

  async update(id: number, changes: UpdateTypeDateDto) {
    const typeDate = await this.findOne(id);
    this.typeDateRepo.merge(typeDate, changes);
    return this.typeDateRepo.save(typeDate);
  }

  findAll() {
    return this.typeDateRepo.find();
  }

  remove(id: number) {
    return this.typeDateRepo.delete(id);
  }
}
