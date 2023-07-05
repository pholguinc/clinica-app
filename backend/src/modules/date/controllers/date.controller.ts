import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { DateService } from '../services/date.service';
import { CreateDateDto, UpdateDateDto } from '../dto/date.dto';

@Controller('date')
export class DateController {
  constructor(private readonly dateService: DateService) {}

  @Post()
  create(@Body() createDateDto: CreateDateDto) {
    return this.dateService.create(createDateDto);
  }

  @Get()
  findAll() {
    return this.dateService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.dateService.findOne(+id);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.dateService.remove(+id);
  }
}
