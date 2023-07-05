import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Put,
  ParseIntPipe,
} from '@nestjs/common';
import { ShiftService } from '../services/shift.service';
import { CreateShiftDto } from '../dto/shift.dto';
import { UpdateShiftDto } from '../dto/shift.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Shift')
@Controller('shift')
export class ShiftController {
  constructor(private readonly shiftService: ShiftService) {}

  @Post()
  create(@Body() createShiftDto: CreateShiftDto) {
    return this.shiftService.create(createShiftDto);
  }

  @Get()
  findAll() {
    return this.shiftService.findAll();
  }

  @Get(':id')
  get(@Param('id', ParseIntPipe) id: number) {
    return this.shiftService.findOne(id);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() payload: UpdateShiftDto,
  ) {
    return this.shiftService.update(id, payload);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.shiftService.remove(+id);
  }
}
