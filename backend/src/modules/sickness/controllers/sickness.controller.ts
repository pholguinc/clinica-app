import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  ParseIntPipe,
  Put,
} from '@nestjs/common';
import { SicknessService } from '../services/sickness.service';
import { CreateSicknessDto, UpdateSicknessDto } from '../dto/sickness.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Sickness')
@Controller('sickness')
export class SicknessController {
  constructor(private readonly sicknessService: SicknessService) {}

  @Get()
  findAll() {
    return this.sicknessService.findAll();
  }

  @Get(':id')
  get(@Param('id', ParseIntPipe) id: number) {
    return this.sicknessService.findOne(id);
  }

  @Post()
  create(@Body() payload: CreateSicknessDto) {
    return this.sicknessService.create(payload);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() payload: UpdateSicknessDto,
  ) {
    return this.sicknessService.update(id, payload);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.sicknessService.remove(+id);
  }
}
