import { CreateMedicineDto, UpdateMedicineDto } from './../dto/medicine.dto';
import { Injectable, NotFoundException } from '@nestjs/common';
import { Medicine } from '../entities/medicine.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class MedicinesService {
  constructor(
    @InjectRepository(Medicine) private medicineRepo: Repository<Medicine>,
  ) {}

  async create(data: CreateMedicineDto) {
    const newMedicine = this.medicineRepo.create(data);
    return this.medicineRepo.save(newMedicine);
  }

  async findOne(id: number) {
    const medicine = await this.medicineRepo.findOneBy({ id });
    if (!medicine) {
      throw new NotFoundException(`Medicine #${id} not found`);
    }
    return medicine;
  }

  async update(id: number, changes: UpdateMedicineDto) {
    const medicine = await this.findOne(id);
    this.medicineRepo.merge(medicine, changes);
    return this.medicineRepo.save(medicine);
  }

  findAll() {
    return this.medicineRepo.find();
  }

  remove(id: number) {
    return this.medicineRepo.delete(id);
  }
}
