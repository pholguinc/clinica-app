import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateServiceDto, UpdateServiceDto } from '../dto/service.dto';
import { Service } from '../entities/service.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class ServiceService {
  constructor(
    @InjectRepository(Service) private serviceRepo: Repository<Service>,
  ) {}

  async create(data: CreateServiceDto) {
    const newService = this.serviceRepo.create(data);
    return this.serviceRepo.save(newService);
  }

  async findOne(id: number) {
    const service = await this.serviceRepo.findOneBy({ id });
    if (!service) {
      throw new NotFoundException(`Service #${id} not found`);
    }
    return service;
  }

  async update(id: number, changes: UpdateServiceDto) {
    const service = await this.findOne(id);
    this.serviceRepo.merge(service, changes);
    return this.serviceRepo.save(service);
  }

  findAll() {
    return this.serviceRepo.find();
  }

  remove(id: number) {
    return this.serviceRepo.delete(id);
  }
}
