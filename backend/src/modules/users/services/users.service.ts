import { Injectable, NotFoundException, Inject } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ConfigService } from '@nestjs/config';
//import * as bcrypt from 'bcrypt';
import * as bcrypt from 'bcryptjs';

import { User } from '../entities/user.entity';
import { CreateUserDto, UpdateUserDto } from '../dtos/user.dto';

@Injectable()
export class UsersService {
  constructor(
    private configService: ConfigService,
    @InjectRepository(User) private userRepo: Repository<User>,
  ) {}

  findAll() {
    return this.userRepo.find();
  }

  findAllByUserRole(role: string) {
    return this.userRepo.find({ where: { role: 'user' } });
  }

  findAllByDoctorRole(role: string) {
    return this.userRepo.find({ where: { role: 'doctor' } });
  }

  async findOne(id: number) {
    const user = await this.userRepo.findOneBy({ id });
    if (!user) {
      throw new NotFoundException(`User #${id} not found`);
    }
    return user;
  }

  async create(data: CreateUserDto) {
    const { password, ...userData } = data;
    const hashedPassword = await bcrypt.hash(password, 10);
    const newData = { ...userData, password: hashedPassword };
    const newUser = this.userRepo.create(newData);
    return this.userRepo.save(newUser);
  }

  async update(id: number, changes: UpdateUserDto) {
    const user = await this.findOne(id);
    if (changes.password) {
      const hashedPassword = await bcrypt.hash(changes.password, 10);
      changes.password = hashedPassword;
    }
    this.userRepo.merge(user, changes);
    return this.userRepo.save(user);
  }

  remove(id: number) {
    return this.userRepo.delete(id);
  }

  async findByEmail(email: string) {
    return await this.userRepo.findOneBy({ email });
  }
}
