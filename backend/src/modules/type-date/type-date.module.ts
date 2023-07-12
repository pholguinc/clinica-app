import { Module } from '@nestjs/common';
import { TypeDateService } from './service/type-date.service';
import { TypeDateController } from './controllers/type-date.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TypeDate } from './entities/type-date.entity';

@Module({
  imports: [TypeOrmModule.forFeature([TypeDate])],
  controllers: [TypeDateController],
  providers: [TypeDateService],
})
export class TypeDateModule {}
